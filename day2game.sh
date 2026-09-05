#!/bin/bash
tar -xvf phantom_repo.tar.gz
cat ./drive-download-20251016T220132Z-1-001/phantom_repo/.git/logs/refs/heads/master

echo -n "Cybersecurity Principles" | sha256sum
echo -n "BAB226|20260915|60" | sha256sum
awk '{print $0 " auth1.log"}' auth1.log >> big.log
awk '{print $0 " auth2.log"}' auth2.log >> big.log
awk '{print $0 " auth3.log"}' auth3.log >> big.log
awk '{print $0 " auth4.log"}' auth4.log >> big.log
awk '{print $0 " auth5.log"}' auth5.log >> big.log
awk '{print substr($0,1,3) "-" substr($0,5,2) "-" substr($0,8)}' big.log > clean.log
sort clean.log | grep -i "Failed" | head -30

cat auth1.log | grep -i "failed" | awk -F'\\]: ' '{print $2}' | sort
cat auth1.log | grep -i "failed" | awk -F'\\]: ' '{print $2}' | sort | wc -l

grep -i "Failed" clean.log | awk '{print $NF}' | sort | uniq -c | sort -nr
cat auth3.log | grep -i "sshd" | grep -i "failed" | wc -l
cat auth3.log | grep -i "failed" | grep -i "user" > auth3stats.txt
cat auth3stats.txt | awk -F'\\]: ' '{print $2}' | awk '{print $8, $6}' > auth3IPs.txt
cat auth3.log | grep -i "failed" | grep -i "user" -v > auth3stats2.txt
cat auth3stats2.txt | grep -i "message" -v >  auth3stats3.txt
cat auth3stats2.txt | grep -i "message" >  auth3stats4.txt
cat auth3stats3.txt | awk -F'\\]: ' '{print $2}' | awk '{print $6, $4}' >> auth3IPs.txt
cat auth3stats4.txt | awk -F'\\[ ' '{print $2}' | awk '{print $6, $4}' >> auth3IPs.txt
cat auth3IPs.txt | sort -n | uniq | cut -d " " -f1 | sort -n | uniq -c | sort -nr

cat auth5.log | grep -I ": invalid user" > auth5stats.txt
cat auth5stats.txt | awk -F': invalid user ' '{print $2}' > auth5users.txt
cat auth5users.txt | cut -d" " -f1 | sort | uniq -c | sort -nr | head -30

cat big.log | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | sort -u | wc -l
