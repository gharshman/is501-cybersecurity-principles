#!/bin/bash

echo -e "\n\n\n"
echo -e "=================================================="
echo -e "Fall 2026 NCL Gymnasium, Log Analysis"
echo -e "=================================================="
echo -e "\n\n"
echo -e "SSH (Easy)"
echo -e "--------------------"
echo -e "Download file 'auth.log'"

cat auth.log | awk '{print $4}' | sort -u
cat auth.log | sort | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | uniq | head -5
cat auth.log | sort | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | uniq | head -5
cat auth.log | sort | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | uniq | head -5
cat auth.log | sort | grep -i "Failed" | awk '{print $9}' | sort -u
cat auth.log | sort | grep -i "Accepted" | awk '{print $11}' | sort -u


echo -e "\n\n"
echo -e "Login (Easy)"
echo -e "--------------------"
echo -e "Download file 'login.log'"

cat login.log | wc -l
cat -A login.log
cat login.log | tr '^I' ' ' | awk '{print $NF}' | sort -u | wc -l
cat login.log | tr '^I' ' ' | awk '{print $NF}' | sort | uniq -c | sort -nr | head
cat login.log | awk '{print $1}' | sort | uniq -c | sort -nr
cat login.log | tr '^I' ' ' | awk '{print $NF, $3}' | sort -u > attempts.txt
cat attempts.txt | awk '{print $1}' | sort | uniq -c | sort -nr | head


echo -e "\n\n"
echo -e "VSFTPD (Easy)"
echo -e "--------------------"
echo -e "Download file 'vsftpd.log'"

cat vsftpd.log | sort | grep -i "ftpuser" | grep "OK LOGIN" | head -1 > temp1.txt
cat temp1.txt | grep -oP '(\d{1,3}\.){3}\d{1,3}'
cat vsftpd.log | sort | grep -i "ftpuser" | grep "OK MKDIR" | head -1 > temp2.txt
cat temp2.txt | tr "\"" " " | awk '{print $NF}'
cat vsftpd.log | sort | grep -i "ftpuser" | grep "OK MKDIR" | tail -1 > temp3.txt
cat temp3.txt | tr "\"" " " | awk '{print $NF}'
cat vsftpd.log | grep "OK UPLOAD" | tr '\"' ' ' > temp4.txt
cat temp4.txt | grep -Po '\b\/[\w\-.]+\.\K[a-zA-Z0-9]{2,5}\b' | sort | uniq -c | sort -nr
cat vsftpd.log | grep "\] \[" | awk '{print $8}' | tr '[' ' ' | tr ']' ' ' | sort -u
cat vsftpd.log | grep "\[jimmy\]" | tr '"' ' ' | awk '{print $12}' | sort -u
cat vsftpd.log | grep "\[jimmy\]" | grep "UPLOAD" | tr '"' ' ' | awk '{print $(NF-2)}' > temp5.txt
cat temp5.txt | awk '{sum += $1} END {print sum}'
cat vsftpd.log | grep "\[ftpuser\]" | grep "UPLOAD" | tr '"' ' ' | awk '{print $(NF-2)}' > temp6.txt
cat temp6.txt | awk '{sum += $1} END {print sum}'
cat vsftpd.log | grep "\[ftpuser\]" | grep "DOWNLOAD" | tr '"' ' ' | awk '{print $(NF-2)}' > temp7.txt
cat temp7.txt | awk '{sum += $1} END {print sum}'
cat vsftpd.log | grep -oP '(\d{1,3}\.){3}\d{1,3}' | sort -n | uniq -c | sort -nr
cat -n vsftpd.log | grep "10\.3\.0\.6"


echo -e "\n\n"
echo -e "NGinX (Medium)"
echo -e "--------------------"
echo -e "Download file 'access.log'"

cat access.log | awk '{print $1}' | sort -n | uniq | wc -l
cat access.log | grep " 200 " | wc -l
cat access.log | grep " 400 " | wc -l
cat access.log | grep "bell" | awk '{print $1}'
cat access.log | grep "Googlebot" | awk '{print $(NF-1)}' | tr ';' ' ' | tr '/' ' ' | sort -u
cat access.log | grep "bash" | awk '{print $1}' | sort -u
cat access.log | grep "fox" | awk -F 'Firefox' 'NF>1 {print $2}' | tr '"' ' ' | tr '/' ' ' > temp09.txt
cat temp09.txt | awk '{print $1}' | sort -n | uniq -c | sort -nr
cat access.log | awk -F '] "' '{print $2}' | tr '"' ' ' | awk '{print $1}' | sort | uniq -c | sort -nr


echo -e "\n\n"
echo -e "History (Medium)"
echo -e "--------------------"
echo -e "Download file 'browser.sqlite'"

echo -e "\n\n *** For this section, you have to enter SQL commands into SQLite ***\n\n" 

echo -e "SELECT url, title FROM moz_places WHERE url LIKE '%search%' AND url LIKE '%craig%';"

echo -e "SELECT url, title FROM moz_places WHERE url LIKE '%$%' OR title LIKE '%$%';"
echo -e "SELECT url, title FROM moz_places
             WHERE url LIKE '%buy%' or url LIKE '%sell%'
              or title LIKE '%buy%' or title LIKE '%sell%';"
echo -e "SELECT url, title FROM moz_places WHERE url LIKE '%mail%' OR title LIKE '%mail%';"
echo -e "SELECT url, title FROM moz_places WHERE url LIKE '%trans%' OR title LIKE '%trans%';"


echo -e "\n\n"
echo -e "Squid (Hard)"
echo -e "--------------------"
echo -e "Download file 'squid-access.log'"

cat squid_access.log | sort | awk '{print $1}' | head -1 | xargs -I {} date -d @{}
cat squid_access.log | awk '{print $2}' | sort -n | head -1
cat squid_access.log | awk '{print $2}' | sort -nr | head -1
cat squid_access.log | awk '{print $3}' | sort -u | wc -l
cat squid_access.log | grep "GET" | wc -l
cat squid_access.log | grep "POST" | wc -l
cat squid_access.log | grep "virus"


echo -e "\n\n"
echo -e "Payments (Hard)"
echo -e "--------------------"
echo -e "Download file 'payments.log'"

sudo apt update && sudo apt install xq
xq payments.log | less
cat payments.log | grep "PPAPIService: Response" | wc -l
xq payments.log | grep -oP '(?<=<ebl:OrderTotal currencyID="USD">).*?(?=</ebl:OrderTotal>)' > temp1.txt
cat temp1.txt | sort -n | tail -1
xq payments.log | grep -oP '(?<=<ebl:StateOrProvince>).*?(?=</ebl:StateOrProvince>)' > temp2.txt
cat temp2.txt | sort | uniq -c | sort -nr | head -1


echo -e "\n\n"
echo -e "Custom File Format (Hard)"
echo -e "-----------------------------"
echo -e "Download file 'Custom File Format.sky'"
echo -e "Copy the file and rename the copy to 'custom.sky' (No spaces in filenames!)"
mv 'Custom File Format.sky' custom.sky
hexdump -s 17 -n 14 -v -e '1/1 "%02x"' custom.sky | xxd -r -p
hexdump -s 35 -n 20 -v -e '1/1 "%02x"' custom.sky | xxd -r -p | base64 --decode
HEX_VAL=$(hexdump -s 9 -n 4 -v -e '1/1 "%02x"' custom.sky)
echo "@$((0x$HEX_VAL))" | xargs -I {} date -u -d {} "+%Y-%m-%d"
hexdump -s 55 -n 4 -v -e '1/1 "%02x"' custom.sky | awk '{print strtonum("0x"$1)}'
tail -c +60 custom.sky | hexdump -v -e '4/1 "%02x" " " 4/1 "%02x" " " 4/1 "%02x" " " 4/1 "%02x" "\n"' | awk '
function hex2ip(hex) {
    return strtonum("0x" substr(hex,1,2)) "." \
           strtonum("0x" substr(hex,3,2)) "." \
           strtonum("0x" substr(hex,5,2)) "." \
           strtonum("0x" substr(hex,7,2))
}
NF==4 {
    print hex2ip($1), hex2ip($2), strtonum("0x"$3), strtonum("0x"$4)
}' > entries.txt
cat entries.txt | awk '{sum += $4} END {print sum}'

cat entries.txt | awk '{print $1}' >> ipaddrs.txt
cat entries.txt | awk '{print $2}' >> ipaddrs.txt
cat ipaddrs.txt | sort | uniq | wc -l
cat entries.txt | awk '{print $1, $4}' | awk '{bytes[$1] += $2} END {for (ip in bytes) print bytes[ip], ip}' | sort -rn
cat entries.txt | awk '{print $3, $4}' | awk '{$1 = strftime("%Y-%m-%d", $1, 1); print}' | sort > dates.txt
cat dates.txt | awk '{bytes[$1] += $2} END {for (dts in bytes) print bytes[dts], dts}' | sort -rn

echo -e "\n\n\n==================================================\n"
echo -e "Done!\n\n\n"
