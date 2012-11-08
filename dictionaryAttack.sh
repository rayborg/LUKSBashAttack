#! /bin/bash
#Copyright 2012, Raymond C. Borges Hink
#This program is copyright under GNU GENERAL PUBLIC LICENSE Version 3
#
#	This program is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#		~~~End of Copying permission statement~~~
#This is a script performs a dictionary attack on a LUKS encrypted volume

#read input
echo Please enter LUKS volume full path 
echo using format "/dev/device" and press enter:
read path 

echo ""
echo Enter a temporary directory name to
echo "mount" the LUKS volume and press enter:
read tempDir

if [ -d $tempDir ]
then
	echo ""
else
	mkdir $tempDir
fi

echo ""
echo Enter a wordlist path"/"name and press enter:
read words
echo ""
#end read input



#do a while until output reads Key slot 0 unlocked.
# or at least contains the text unlocked

#initilize variables
locked="TRUE"
lineNum=1
numberOfWords=`wc -w $words`

while [[ $locked == "TRUE" ]];
do
try=`sed -n "$lineNum"p $words`
echo Trying $try, $lineNum of $numberOfWords
result=`echo $try | sudo cryptsetup luksOpen $path $tempDir`

if [[ $result =~ "unlocked" ]]
then
	echo ""
	echo SUCCESS"!!!"
	echo password is $try
	let locked="FALSE"
fi

let lineNum=lineNum+1
echo ""

if [[ $try == "" ]]
then
	echo Password not found. 
	let locked="FALSE"
fi
done





