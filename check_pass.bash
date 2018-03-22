#/bin/bash


URL="https://api.pwnedpasswords.com/range/"
OS=$(uname -s)
case $OS in
	Linux) HASH=sha1sum;;
	Darwin) HASH=shasum;;
	*) HASH=sha1sum;;
esac


echo -n "Enter password to check: "
read -s PASS 
echo

SHA1PASS=$(echo -n $PASS | $HASH | cut -d ' ' -f 1 | tr '[a-f]' '[A-F]')
PASS=''
HEADSHA="${SHA1PASS:0:5}"
TAILSHA="${SHA1PASS:5:39}"

REQUEST=${URL}${HEADSHA}
curl -s $REQUEST | grep "$TAILSHA" | cut -d : -f 2 | xargs echo Found occurences: 

