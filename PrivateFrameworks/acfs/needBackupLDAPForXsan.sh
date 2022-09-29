#!/bin/bash

#
# needBackupLDAPForXsan.sh "<DATA_VOLUME_ROOT>"
#   for e.g. # ./needBackupLDAPForXsan.sh "/System/Volumes/Data"
#
# Called by Migration to determine if LDAP settings need to be backed up
# during OS update for Xsan.
#
# Return 0 if LDAP settings need to be backed up iff the following conditions
# are true:
# 1) LDAP is setup, determined by the presence of the
#    "/Library/Preferences/com.apple.openldap.plist" file.
# 2) System is setup as OD Master, determined by the presence of 'LDAPSERVER'
#    key in the "/Library/Preferences/com.apple.openldap.plist".
# 3) Xsan is setup, determined by the presence of the
#    "/Library/Preferences/Xsan/config.plist" file.
# 3) System is setup as Xsan MDC, determined by the "CONTROLLER" value in the
#    "role" key.
#
# Otherwise, return 1 if any of the above conditions is false.
#

DATA_VOL_ROOT=$1
LDAP_PLIST_FILE="${DATA_VOL_ROOT}/Library/Preferences/com.apple.openldap.plist"
XSAN_PLIST_FILE="${DATA_VOL_ROOT}/Library/Preferences/Xsan/config.plist"

# Check for the presence of LDAP and XSAN plist files
if [[ -f ${LDAP_PLIST_FILE} && -f ${XSAN_PLIST_FILE} ]]; then
    #
    # Next, check if system is setup as OD Master.
    #
    `plutil -p ${LDAP_PLIST_FILE} | grep -q "LDAPSERVER"`
    ret=$?
    if [ $ret -eq 0 ]; then
        #
        # Last, check if system is setup as Xsan MDC.
        #
        `plutil -p ${XSAN_PLIST_FILE} | grep "role" | grep -q "CONTROLLER"`
        ret=$?
        if [ $ret -eq 0 ]; then
            # All conditions are met.
            exit 0
        fi
    fi
fi

# One (or more) conditions are not met.
exit 1
