
# Read Password
echo -n Type your password to sign blocks: 
read -s password

echo $password > .secret
echo " "
