
roll(){
echo ""
echo "Do you want to perform another operation? yes/no"
echo ""
read ops
ops=${ops^^}
if [[ "$ops" == "YES" ]]
then
	. MtnSecurity.sh
	Master
elif [[ "$ops" == "NO" ]]
then
	echo "Aborting Operation.."
	echo "Operation Aborted"
else
	echo "Please enter Either yes/no to continue"
fi
}

