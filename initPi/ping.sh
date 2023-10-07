
grep -v $2 ~/.ssh/known_hosts > ~/.ssh/known_hosts.tmp
cp   ~/.ssh/known_hosts.tmp ~/.ssh/known_hosts
chmod 644 ~/.ssh/known_hosts
ssh -o StrictHostKeyChecking=no -i $1 pi@$2.local hostname

