#!/bin/bash
####################################################################
# Script to harden Nutanix controller VMs in a cluster.            #
# Run this on any CVM in the cluster.                              #
#                                                                  #
# Current hardening:                                               #
#   - Run built-in DoD script                                      #
#   - Set password expiration for root and nutanix accts           #
#                                                                  #
# author: @patricksanders                                          #
####################################################################

PASS_TIMEOUT=365

for i in `svm_ips`; do
	echo "Applying DoD settings to CVM $i"
	ssh $i 'sudo /root/dodscript.sh'
	echo "Setting password expirations to $PASS_TIMEOUT on CVM $i"
	ssh $i 'sudo passwd -x $PASS_TIMEOUT root'
	ssh $i 'sudo passwd -x $PASS_TIMEOUT nutanix'
	sleep 5
done

echo "\nComplete."

