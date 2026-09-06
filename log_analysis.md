## National Cyber League, Fall 2026 Gymnasium
# Log Analysis - SSH (Easy)

<hr />

> [!WARNING]  
> Use this code at your own risk!

<hr />

# SSH (Easy)
### **_Download file "auth.log"_**

**1. What is the hostname of the ssh server that was compromised?**

        Answer: "myraptor"

```bash
cat auth.log | awk '{print $4}' | sort -u
```

**2. What was the first IP address to attack the server?**

        Answer: "169.139.243.218"

```bash
cat auth.log | sort | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | uniq | head -5
```

**3. What was the second IP address to attack the server?**

        Answer: "56.13.188.38"

```bash
cat auth.log | sort | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | uniq | head -5
```

**4. What was the third IP address to attack the server?**

        Answer: "30.167.206.91"

```bash
cat auth.log | sort | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | uniq | head -5
```

**5. Which user was targeted in the attack?**

        Answer: "harvey"

```bash
cat auth.log | sort | grep -i "Failed" | awk '{print $9}' | sort -u
```

**6. From which IP address was the attacker able to successfully log in?**

        Answer: "30.167.206.91"

```bash
cat auth.log | sort | grep -i "Accepted" | awk '{print $11}' | sort -u
```

<hr />

# Login (Easy)
### **_Download file "login.log"_**

**1. How many total login attempts were made in this log?**

        Answer: "6063"

```bash
cat login.log | wc -l
```

**2. How many unique usernames appear in this log?**

        Answer: "1879"

When "cut" and "awk" give us problems, we should check for non-printing special characters.  The file uses a
combination of tabs and spaces (no standard), so we clean it first.

```bash
cat -A login.log
cat login.log | tr '^I' ' ' | awk '{print $NF}' | sort -u | wc -l
```

**3. What is the username with the most login attempts?**

        Answer: "ntory"

```bash
cat login.log | tr '^I' ' ' | awk '{print $NF}' | sort | uniq -c | sort -nr | head
```

**4. How many attempts were made for the username with the most login attempts?**

        Answer: "124"

Same command as #3 above.

**5. What is the date with the most login attempts?**

        Answer: "2011-03-23"

```bash
cat login.log | awk '{print $1}' | sort | uniq -c | sort -nr
```

**6. What is the username that had logins from the most unique IP addresses?**

        Answer: "wlfla0190"

This one requires us to extract username ($NF) and IP address ($3).  Then you isolate unique name-IP combos,
extract name alone and count.

```bash
cat login.log | tr '^I' ' ' | awk '{print $NF, $3}' | sort -u > attempts.txt
cat attempts.txt | awk '{print $1}' | sort | uniq -c | sort -nr | head
```

<hr />

# VSFTPD (Easy)
### **_Download file "vsftpd.log"_**

**1. What IP address did "ftpuser" first log in from?**

        Answer: "10.0.0.123"

```bash
cat vsftpd.log | sort | grep -i "ftpuser" | grep "OK LOGIN" | head -1 > temp1.txt
cat temp1.txt | grep -oP '(\d{1,3}\.){3}\d{1,3}'
```

**2. What is the first directory that ftpuser created?**

        Answer: "/home/ftpuser/TreeSizeFree"

```bash
cat vsftpd.log | sort | grep -i "ftpuser" | grep "OK MKDIR" | head -1 > temp2.txt
cat temp2.txt | tr "\"" " " | awk '{print $NF}'
```

**3. What is the last directory that ftpuser created?**

        Answer: "/home/ftpuser/110D300S"

```bash
cat vsftpd.log | sort | grep -i "ftpuser" | grep "OK MKDIR" | tail -1 > temp3.txt
cat temp3.txt | tr "\"" " " | awk '{print $NF}'
```

**4. What file extension was the most used by ftpuser?**

        Answer: "JPG"

```bash
cat vsftpd.log | grep "OK UPLOAD" | tr '\"' ' ' > temp4.txt
cat temp4.txt | grep -Po '\b\/[\w\-.]+\.\K[a-zA-Z0-9]{2,5}\b' | sort | uniq -c | sort -nr
```

**5. What is the username of the other user in this log?**

        Answer: "jimmy"

```bash
cat vsftpd.log | grep "\] \[" | awk '{print $8}' | tr '[' ' ' | tr ']' ' ' | sort -u
```

**6. What IP address did this other user log in from?**

        Answer: "10.0.0.214"

```bash
cat vsftpd.log | grep "\[jimmy\]" | tr '"' ' ' | awk '{print $12}' | sort -u
```

**7. How many total bytes did this other user upload?**

        Answer: "105750628"

```bash
cat vsftpd.log | grep "\[jimmy\]" | grep "UPLOAD" | tr '"' ' ' | awk '{print $(NF-2)}' > temp5.txt
cat temp5.txt | awk '{sum += $1} END {print sum}'
```

**8. How many total bytes did ftpuser upload?**

        Answer: "13980839165"

```bash
cat vsftpd.log | grep "\[ftpuser\]" | grep "UPLOAD" | tr '"' ' ' | awk '{print $(NF-2)}' > temp6.txt
cat temp6.txt | awk '{sum += $1} END {print sum}'
```

**9. How many total bytes did ftpuser download?**

        Answer: "6008032"

```bash
cat vsftpd.log | grep "\[ftpuser\]" | grep "DOWNLOAD" | tr '"' ' ' | awk '{print $(NF-2)}' > temp7.txt
cat temp7.txt | awk '{sum += $1} END {print sum}'
```

**10. Identify the IP address of the suspicious login (the login with no subsequent activity)**

        Answer: "10.3.0.6"

```bash
cat vsftpd.log | grep -oP '(\d{1,3}\.){3}\d{1,3}' | sort -n | uniq -c | sort -nr
cat -n vsftpd.log | grep "10\.3\.0\.6"
```

<hr />

# NGinX (Medium)
### **_Download file "access.log"_**

**1. How many different IP addresses reached the server?**

        Answer: "47"

```bash
cat access.log | awk '{print $1}' | sort -n | uniq | wc -l
```

**2. How many requests yielded a 200 status?**

        Answer: "19"

```bash
cat access.log | grep " 200 " | wc -l
```

**3. How many requests yielded a 400 status?**

        Answer: "38"

```bash
cat access.log | grep " 400 " | wc -l
```

**4. What IP address rang at the doorbell?**

        Answer: "186.64.69.141"

```bash
cat access.log | grep "bell" | awk '{print $1}'
```

**5. What version of the Googlebot visited the website?**

        Answer: "2.1"

```bash
cat access.log | grep "Googlebot" | awk '{print $(NF-1)}' | tr ';' ' ' | tr '/' ' ' | sort -u
```

**6. Which IP address attempted to exploit the shellshock vulnerability?**

        Answer: "61.161.130.241"

```bash
cat access.log | grep "bash" | awk '{print $1}' | sort -u
```

**7. What was the most popular version of Firefox used for browsing the website?**

        Answer: "31.0"

```bash
cat access.log | grep "fox" | awk -F 'Firefox' 'NF>1 {print $2}' | tr '"' ' ' | tr '/' ' ' > temp09.txt
cat temp09.txt | awk '{print $1}' | sort -n | uniq -c | sort -nr
```

**8. What is the most common HTTP method used?**

        Answer: "GET"

```bash
cat access.log | awk -F '] "' '{print $2}' | tr '"' ' ' | awk '{print $1}' | sort | uniq -c | sort -nr
```

**9. What is the second most common HTTP method used?**

        Answer: "CONNECT"

Same command as #8 above.

**10. How many requests were for \x04\x01\x00P\xC6\xCE\x0Eu0\x00?*8

        Answer: "6"

Same command as #8 above.

<hr />

# History (Medium)
### **_Download file "browser.sqlite"_**
### Kali Linux includes "sqlitebrowser" app for viewing database structure

**1. What did the user search for on craigslist?**

        Answer: "bitcoin"

We need to know the structure of the database: table names, etc.  We can browse many databases and run SQL queries
using sqlitebrowser (comes pre-installed on Kali).  Review "Database Structure" and find where browser history is
stored: "moz_places".  Switch to the "Execute SQL" tab to run queries.

```bash
sqlitebrowser browser.sqlite      # for graphical program, or
sqlite3 browser.sqlite            # for terminal interface
```

```sql
SELECT url, title FROM moz_places WHERE url LIKE '%search%' AND url LIKE '%craig%';
```

**2. What was the current price of bitcoin when the user was browsing?**

        Answer: "$239.50"

```sql
SELECT url, title FROM moz_places WHERE url LIKE '%$%' OR title LIKE '%$%';
```

**3. What Bitcoin exchange did the user log in to?**

        Answer: "coinbase"

Searching the word "exchange" does not turn up any results, so browsing the data helps. Exchange = buy & sell.

```sql
SELECT url, title FROM moz_places
   WHERE url LIKE '%buy%' or url LIKE '%sell%'
    or title LIKE '%buy%' or title LIKE '%sell%';
```

**4. What is the email that was used to log into the exchange?**

        Answer: "b1gbird@gmail.com"
        
```sql
SELECT url, title FROM moz_places WHERE url LIKE '%mail%' OR title LIKE '%mail%';
```

**5. What was the ID of the Bitcoin transaction that the user looked at?**

        Answer: "5274cfba585a4b5681527a37f95c76340428916bb7480cef6c545f0a28dcd2d7"

```sql
SELECT url, title FROM moz_places WHERE url LIKE '%trans%' OR title LIKE '%trans%';
```

**6. What was the total BTC of all the inputs of the Bitcoin transaction?**

        Answer: "0.22616302"

The answer is not in the database.  If you Google the question, Google AI tells you that it can tell you the total
BTC if you know the transaction ID (TXID).  Enter the TXID from question #6 above into Google AI chat.

**7. Which bitcoin address received the majority of the Bitcoin in the transaction?**

        Answer: "18z6bTFjxkXCmhfp8YBetR2wgmoVjXGJZz"

The answer is not in the database.  If you continue the Google AI conversation from above and enter the question,
Google AI tells you the answer.

<hr />

# Squid (Hard)
### **_Download file "squid-access.log"_**

**1. In what year was this log saved?**

        Answer: "2010"

```bash
cat squid_access.log | sort | awk '{print $1}' | head -1 | xargs -I {} date -d @{}
```

**2. How many milliseconds did the fastest request take?**

        Answer: "5"

There are no headers or column labels, so assume that column 2 is response time.

```bash
cat squid_access.log | awk '{print $2}' | sort -n | head -1
```

**3. How many milliseconds did the longest request take?**

        Answer: "41762"

```bash
cat squid_access.log | awk '{print $2}' | sort -nr | head -1
```

**4. How many different IP addresses did the proxy service in this log?**

        Answer: "4"

```bash
cat squid_access.log | awk '{print $3}' | sort -u | wc -l
```

**5. How many GET requests were made?**

        Answer: "35"

```bash
cat squid_access.log | grep "GET" | wc -l
```

**6. How many POST requests were made?**

        Answer: "78"

```bash
cat squid_access.log | grep "POST" | wc -l
```

**7. What company created the antivirus used on the host at 192.168.0.224?**

        Answer: "symantec"

```bash
cat squid_access.log | grep "virus"
```

**8. What url is used to download an antivirus update?**

        Answer: "http://liveupdate.symantecliveupdate.com/streaming/norton$202009$20streaming$20virus$20definitions
                 _1.0_symalllanguages_livetri.zip"

Same as #7 above

<hr />

# Payments (Hard)
### **_Download file "payments.log"_**

**1. How many transactions are contained in the log?**

        Answer: "192"

This log file is in XML format, so it helps to have an XML viewer.  You can see that the log contains Requests and
Responses, so you have to count one or the other.

```bash
sudo apt update && sudo apt install xq
xq payments.log | less
cat payments.log | grep "PPAPIService: Response" | wc -l
```

**2. What is the transaction ID of the largest purchase made in the log?**

        Answer: "998.60"

The question asks for transacation ID but the system accepts the dollar value.

```bash
xq payments.log | grep -oP '(?<=<ebl:OrderTotal currencyID="USD">).*?(?=</ebl:OrderTotal>)' > temp1.txt
cat temp1.txt | sort -n | tail -1
```

**3. Which state made the greatest number of purchases?**

        Answer: "MA"

```bash
xq payments.log | grep -oP '(?<=<ebl:StateOrProvince>).*?(?=</ebl:StateOrProvince>)' > temp2.txt
cat temp2.txt | sort | uniq -c | sort -nr | head -1
```

<hr />

# Custom File Format (Hard)
### **_Download file "Custom File Format.sky"_**

#### Rename the downloaded file to "custom.sky" (No spaces in filenames!)

```bash
mv 'Custom File Format.sky' custom.sky
```

#### Deconstructing the file

- Perform a binary dump
- For the header:
    - Extract "magicbytes" = 8 bytes or 64 bits
    - Extract "version"    = 1 byte or 8 bits
    - Extract "creation"   = 4 bytes or 32 bits
    - Extract "hostlen"    = 4 bytes or 32 bits
    - Extract "hostname"   = Convert hostlen to bit length (ex. 4 bytes = 32 bits)
    - Extract "flaglen"    = 4 bytes or 32 bits
    - Extract "flagname"   = Convert flaglen to bit length (ex. 4 bytes = 32 bits)
    - Extract "records"    = 4 bytes or 32 bits
- For each record:
    - Extract "srcip"      = 4 bytes or 32 bits
    - Extract "destip"     = 4 bytes or 32 bits
    - Extract "stamp"      = 4 bytes or 32 bits
    - Extract "xferd"      = 4 bytes or 32 bits

**1. What is the hostname of the server?**

        Answer: "sky-server-711"

The first 8 bytes of the binary file are the header.  There is one byte for the version, always = 1.  Then four bytes
for the creation date/time of the file. Then four bytes for the hostname size = 14 (in decimal).  So the hostname
begins at byte #18, which means byte #17 when you start from zero.  So to get the hostname, we need to start at
byte #17 and collect 14 bytes, then convert to ASCII.

```bash
hexdump -s 17 -n 14 -v -e '1/1 "%02x"' custom.sky | xxd -r -p
```

**2. What is the plaintext flag in the log file?**

        Answer: "SKY-PARS-7325"

After the hostname, four bytes determine the flag length = 20 (in decimal).  So to get the flag, we need to start
at byte #35 and collect 20 bytes.  Convert the hex to ASCII, then pass it through a "base64 --decode".

```bash
hexdump -s 35 -n 20 -v -e '1/1 "%02x"' custom.sky | xxd -r -p | base64 --decode
```

**3. On what date was the file created (in UTC)?**

        Answer: "2018-03-03"

Grab bytes 9 - 12.  Add the "0x" prefix for hexidecimal and pipe to date command.

```bash
HEX_VAL=$(hexdump -s 9 -n 4 -v -e '1/1 "%02x"' custom.sky)
echo "@$((0x$HEX_VAL))" | xargs -I {} date -u -d {} "+%Y-%m-%d"
```

**4. How many entries are in the log file?**

        Answer: "162"

After the flag, bytes 55-58 give the number of log entries. (0x000000a2 = 162 in decimal)

```bash
hexdump -s 55 -n 4 -v -e '1/1 "%02x"' custom.sky | awk '{print strtonum("0x"$1)}'
```

**5. How many total transferred bytes were recorded in the log?**

        Answer: "811167"

After the header, the body is very standardized format: four fields of four bytes each.  We can extract everything
from byte #59 to the end & convert it to the correct format: two columns of IP addresses (source & destination)
and two columns of integers (timestamp & transferred bytes).  After that, it's simply a matter of passing
column $4 to awk and summing the values.

```bash
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
```

**6. How many unique IP addresses (both senders and receivers) are recorded?**

        Answer: "13"

We need to send columns $1 and $2 to a file, then run sort, uniq and wc.

```bash
cat entries.txt | awk '{print $1}' >> ipaddrs.txt
cat entries.txt | awk '{print $2}' >> ipaddrs.txt
cat ipaddrs.txt | sort | uniq | wc -l
```

**7. Which IP address sent the most amount of data?**

        Answer: "229.212.21.212"

We need to create an associative array (aka "dictionary" in Python or "map" in C++) in order to keep track of bytes
per IP address.

```bash
cat entries.txt | awk '{print $1, $4}' | awk '{bytes[$1] += $2} END {for (ip in bytes) print bytes[ip], ip}' | sort -rn
```

**8. How many total bytes were sent by the above IP address that sent the most amount of data?**

        Answer: "145048"

Same command output as #7 above.

**9. What was the busiest day (day with the most bytes transferred)? (Answer format is yyyy-mm-dd)**

        Answer: "2018-03-28"

When converting dates, you have to tell Linux if you want to use UTC dates/times.  By default, it will convert
dates/times to local time.

```bash
cat entries.txt | awk '{print $3, $4}' | awk '{$1 = strftime("%Y-%m-%d", $1, 1); print}' | sort > dates.txt
cat dates.txt | awk '{bytes[$1] += $2} END {for (dts in bytes) print bytes[dts], dts}' | sort -rn
```

<hr />
