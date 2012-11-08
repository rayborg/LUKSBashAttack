LUKSBashAttack
==============

Sudo mount /dev/sda tempDirectory gives us unknown filesystem type ‘crypto_LUKS’ if sda is a LUKS volume. So to mount the
drive with shell we use:  “sudo cryptsetup luksOpen /dev/sda tempDirectory”, this prompts for a password 3 times and if 
the password fails 3 times in a row then it quits. The bash script is based on this command.

The scripts asks the user for the filepath and LUKS device name. The command sudo fdisk –l allows to see the volume device
name from the shell. The script then creates a temporary directory to attempt to mount the LUKS volume to if there is not
one already created.

Finally the script asks for the filepath/filename of a wordlist to try.