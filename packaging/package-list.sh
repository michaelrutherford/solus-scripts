#!/bin/bash
#Lists packages available on Solus and their version numbers

#List them out and clean it up
function list1 {
eopkg la > packages.txt
sed -i 's/\ \[01\;37m//' packages.txt
sed -i 's/\ \[32m//' packages.txt
sed -i 's/\ \[0m//' packages.txt
sed -i 's/\s.*$//' packages.txt
sed -i '1,3d' packages.txt
}

#Read file and get version no
function getversion {
while read p; do
  echo $(eopkg info $p | grep Name) | tee -a packages2.txt
done <packages.txt
}

function stripversion {
sed -i 's/Name \: //g' packages2.txt
sed -i 's/version: /\| /g' packages2.txt
sed -i 's/, release.*$//' packages2.txt
sed -i 's/\,//' packages2.txt
}

function addborders {
sed -i 's/^/\| /' packages2.txt
sed -i 's/$/ \|/' packages2.txt
sed -i '1s/^/\| Name \| Version \|\n/' packages2.txt
}

list1
getversion
stripversion
addborders
