#!/bin/sh

PROG_NAME='migrateXsan.sh'

LSP_BASE='/Library/Server/Previous'
LDAP_BASE="${LSP_BASE}/private/etc/openldap"
LDAPV_BASE="${LSP_BASE}/private/var/db/openldap"
PREFS_FILE="${LSP_BASE}/Library/Preferences/com.apple.openldap.plist"
PREVIOUS_VERSION="${LSP_BASE}/.previousSystemVersion"

XSAN_PREF_BASE='/Library/Preferences/Xsan'
XSAN_CONFIG="${XSAN_PREF_BASE}/config.plist"
XSAN_AUTH="${XSAN_PREF_BASE}/.auth_secret"
XSAN_FSNAME="${XSAN_PREF_BASE}/fsnameservers"
XSAN_DAEMON='/System/Library/LaunchDaemons/com.apple.xsan.plist'
XSAN_DOMAIN='com.apple.xsan'

SLAPCONFIG_BIN='/usr/sbin/slapconfig'
PROFILES_BIN='/usr/bin/profiles'
LAUNCHCTL_BIN='/bin/launchctl'
XSANCTL_BIN='/System/Library/Filesystems/acfs.fs/Contents/bin/xsanctl'
PLUTIL_BIN='/usr/bin/plutil'


ldapDataPresent()
{
    # Checking to see if the LDAP directories are present and not empty
    if [ "$(ls -A "${LDAP_BASE}")" ] && [ "$(ls -A "${LDAPV_BASE}")" ]; then
        return 0
    else
        return 1
    fi
}

getPreviousSystemVersion()
{
    # Look for file at path that has the previous OS build in it
    if ! [ -f "${PREVIOUS_VERSION}" ] || ! [ $(cat "${PREVIOUS_VERSION}") ]; then
        syslog -s "${PROG_NAME}: Unable to find previous system version"
        return 1
    fi

    # "Return" the file data
    cat "${PREVIOUS_VERSION}"
}

isODMaster()
{
    # No plist --> not an OD master
    if ! [ -f "${PREFS_FILE}" ]; then
        return 1
    fi

    # LDAPREPLICA --> not an OD master
    if "${PLUTIL_BIN}" -extract 'LDAPREPLICA' 'raw' "${PREFS_FILE}"; then
        return 1
    fi

    # LDAPSERVER or OLDLDAPSERVER --> OD master
    if "${PLUTIL_BIN}" -extract 'LDAPSERVER' 'raw' "${PREFS_FILE}" || "${PLUTIL_BIN}" -extract 'OLDLDAPSERVER' 'raw' "${PREFS_FILE}"; then
        return 0
    else
        return 1
    fi
}

migrateOD()
{
    if ! ldapDataPresent; then
        syslog -s "${PROG_NAME}: No ldap data present, no work to do"
        # Not an error so return 0
        return 0
    fi

    syslog -s "${PROG_NAME}: Found ldap data"

    if ! getPreviousSystemVersion; then
        syslog -s "${PROG_NAME}: Unable to migrate ldap data, can't find previous system version"
        return 1
    fi
    previousVersion="$(getPreviousSystemVersion)"

    if ! isODMaster; then
        syslog -s "${PROG_NAME}: Not an OD Master, no work to do"
        # Not an error so return 0
        return 0
    fi

    # Actually do the migration
    if "${SLAPCONFIG_BIN}" '-migrateldapserver' 0 "${LSP_BASE}" / "${previousVersion}" 'os_install' 'en'; then
        syslog -s "${PROG_NAME}: migraldapserver completed"
        # Not an error so return 0
        return 0
    else
        syslog -s "${PROG_NAME}: migrateldapserver failed"
        # Not an error so return 0
        return 1
    fi
}

checkForXsanProfile()
{
    # Get the profileIdentifier of the Xsan profile if it exists
    installedProfiles=$("${PROFILES_BIN}" -C)
    if ! echo "${installedProfiles}" | grep -q "${XSAN_DOMAIN}"; then
        return 1
    fi

    # Return the profileIdentifier
    echo "${installedProfiles}" | grep -o "${XSAN_DOMAIN}.*$"
}

checkIfXsanClient()
{
    if ! [ -f "${XSAN_CONFIG}" ]; then
        return 1
    fi

    if "${PLUTIL_BIN}" -extract 'role' 'raw' "${XSAN_CONFIG}" | grep -iq 'client'; then
        return 0
    else
        return 1
    fi
}

setXsanNeedsActivation()
{
    if ! [ -f "${XSAN_CONFIG}" ]; then
        syslog -s "${PROG_NAME}: failed to set needsActivation, config missing?"
        return 1
    fi

    if ! "${PLUTIL_BIN}" -insert 'needsActivation' -bool 'TRUE' "${XSAN_CONFIG}"; then
        syslog -s "${PROG_NAME}: failed to set needsActivation key in config"
        return 1
    fi
}

enableXsan()
{
    # Seems to always return 0, so can't check result
    "${LAUNCHCTL_BIN}" 'load' -w "${XSAN_DAEMON}"
}

disableXsan()
{
    # Seems to always return 0, so can't check result
    "${LAUNCHCTL_BIN}" 'unload' -w "${XSAN_DAEMON}"
}

if checkForXsanProfile; then
    profileIdentifier=$(checkForXsanProfile)
    if checkIfXsanClient; then
        # Clients don't worry about OD so just do firstBoot
        syslog -s "${PROG_NAME}: enabling Xsan due to existing profile"
        enableXsan
        "${XSANCTL_BIN}" 'firstBoot'
    else
        # Otherwise MDCs should disable Xsan, migrate OD, and have the user
        # manually run `xsanctl activateSan` once update finishes
        syslog -s "${PROG_NAME}: disabling xsan and unloading profile"
        disableXsan
        if setXsanNeedsActivation; then
            "${PROFILES_BIN}" -R -p "${profileIdentifier}"
        else
            syslog -s "${PROG_NAME}: error flagging Xsan for activation"
        fi
        migrateOD
    fi

else
    # Sometimes controller may not have profile installed for some reason or
    # another so try migrating OD and setting activateSan. The tools should
    # behave correctly even if the host is not an MDC
    checkIfXsanClient
    isXsanClient="$?"

    syslog -s "${PROG_NAME}: disabling Xsan"
    disableXsan
    if ! [ "${isXsanClient}" -eq 0 ]; then
        # If we are a controller, add "needsActivation". We set this independent of our seeing an
        # Xsan 3 config (no sanConfigURLs) or an Xsan 4 config (sanConfigURLs). servermgr_san will
        # handle it all correctly
        syslog -s "${PROG_NAME}: flagging for activation"
        setXsanNeedsActivation
        migrateOD
    fi
fi
