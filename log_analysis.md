## National Cyber League, Fall 2026 Gymnasium
# Log Analysis - SSH (Easy)

<hr />

> [!WARNING]  
> Use this code at your own risk!

<hr />

# SSH (Easy)
### **_Download file "auth.log"_**

1. What is the hostname of the ssh server that was compromised?

        Answer: "myraptor"

        cat auth.log | awk '{print $4}' | sort -u


2. What was the first IP address to attack the server?

        Answer: "169.139.243.218"

        cat auth.log | sort | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | uniq | head -5

3. What was the second IP address to attack the server?

        Answer: "56.13.188.38"

        cat auth.log | sort | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | uniq | head -5

4. What was the third IP address to attack the server?

        Answer: "30.167.206.91"

        cat auth.log | sort | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | uniq | head -5
     
5. Which user was targeted in the attack?

        Answer: "harvey"

        cat auth.log | sort | grep -i "Failed" | awk '{print $9}' | sort -u

6. From which IP address was the attacker able to successfully log in?

        Answer: "30.167.206.91"

        cat auth.log | sort | grep -i "Accepted" | awk '{print $11}' | sort -u

<hr />

# Login (Easy)
### **_Download file "login.log"_**

1. How many total login attempts were made in this log?

        Answer: "6063"
        cat login.log | wc -l

2. How many unique usernames appear in this log?

        Answer: "1879"
        When "cut" and "awk" give us problems, we should check for non-printing special characters.
        cat -A login.log
        The file uses a combination of tabs and spaces (no standard), so we clean it first.
        cat login.log | tr '^I' ' ' | awk '{print $NF}' | sort -u | wc -l

3. What is the username with the most login attempts?

        Answer: "ntory"
        cat login.log | tr '^I' ' ' | awk '{print $NF}' | sort | uniq -c | sort -nr | head

4. How many attempts were made for the username with the most login attempts?

        Answer: "124"

        Same command as #3 above.

5. What is the date with the most login attempts?

        Answer: "2011-03-23"

            cat login.log | awk '{print $1}' | sort | uniq -c | sort -nr

6. What is the username that had logins from the most unique IP addresses?

        Answer: "wlfla0190"
        This one requires us to extract username ($NF) and IP address ($3).
        cat login.log | tr '^I' ' ' | awk '{print $NF, $3}' | sort -u > attempts.txt
        Then you isolate unique name-IP combos, extract name alone and count.
        cat attempts.txt | awk '{print $1}' | sort | uniq -c | sort -nr | head

<hr />

# VSFTPD (Easy)
### **_Download file "vsftpd.log"_**

1. What IP address did "ftpuser" first log in from?

        Answer: "10.0.0.123"
        cat vsftpd.log | sort | grep -i "ftpuser" | grep "OK LOGIN" | head -1 > temp1.txt
        cat temp1.txt | grep -oP '(\d{1,3}\.){3}\d{1,3}'

2. What is the first directory that ftpuser created?

        Answer: "/home/ftpuser/TreeSizeFree"
        cat vsftpd.log | sort | grep -i "ftpuser" | grep "OK MKDIR" | head -1 > temp2.txt
        cat temp2.txt | tr "\"" " " | awk '{print $NF}'

3. What is the last directory that ftpuser created?

        Answer: "/home/ftpuser/110D300S"
        cat vsftpd.log | sort | grep -i "ftpuser" | grep "OK MKDIR" | tail -1 > temp3.txt
        cat temp3.txt | tr "\"" " " | awk '{print $NF}'

4. What file extension was the most used by ftpuser?

        Answer: "JPG"
        cat vsftpd.log | grep "OK UPLOAD" | tr '\"' ' ' > temp4.txt
        cat temp4.txt | grep -Po '\b\/[\w\-.]+\.\K[a-zA-Z0-9]{2,5}\b' | sort | uniq -c | sort -nr

5. What is the username of the other user in this log?

        Answer: "jimmy"
        cat vsftpd.log | grep "\] \[" | awk '{print $8}' | tr '[' ' ' | tr ']' ' ' | sort -u

6. What IP address did this other user log in from?

        Answer: "10.0.0.214"
        cat vsftpd.log | grep "\[jimmy\]" | tr '"' ' ' | awk '{print $12}' | sort -u

7. How many total bytes did this other user upload?

        Answer: "105750628"
        cat vsftpd.log | grep "\[jimmy\]" | grep "UPLOAD" | tr '"' ' ' | awk '{print $(NF-2)}' > temp5.txt
        cat temp5.txt | awk '{sum += $1} END {print sum}'

8. How many total bytes did ftpuser upload?

        Answer: "13980839165"
        cat vsftpd.log | grep "\[ftpuser\]" | grep "UPLOAD" | tr '"' ' ' | awk '{print $(NF-2)}' > temp6.txt
        cat temp6.txt | awk '{sum += $1} END {print sum}'

9. How many total bytes did ftpuser download?

        Answer: "6008032"
        cat vsftpd.log | grep "\[ftpuser\]" | grep "DOWNLOAD" | tr '"' ' ' | awk '{print $(NF-2)}' > temp7.txt
        cat temp7.txt | awk '{sum += $1} END {print sum}'

10. Identify the IP address of the suspicious login (the login with no subsequent activity)

        Answer: "10.3.0.6"
        cat vsftpd.log | grep -oP '(\d{1,3}\.){3}\d{1,3}' | sort -n | uniq -c | sort -nr
        cat -n vsftpd.log | grep "10\.3\.0\.6"

<hr />

# NGinX (Medium)
### **_Download file "access.log"_**

1. How many different IP addresses reached the server?

        Answer: "47"
        cat access.log | awk '{print $1}' | sort -n | uniq | wc -l

2. How many requests yielded a 200 status?

        Answer: "19"
        cat access.log | grep " 200 " | wc -l

3. How many requests yielded a 400 status?

        Answer: "38"
        cat access.log | grep " 400 " | wc -l

4. What IP address rang at the doorbell?

        Answer: "186.64.69.141"
        cat access.log | grep "bell" | awk '{print $1}'

5. What version of the Googlebot visited the website?

        Answer: "2.1"
        cat access.log | grep "Googlebot" | awk '{print $(NF-1)}' | tr ';' ' ' | tr '/' ' ' | sort -u

6. Which IP address attempted to exploit the shellshock vulnerability?

        Answer: "61.161.130.241"
        cat access.log | grep "bash" | awk '{print $1}' | sort -u

7. What was the most popular version of Firefox used for browsing the website?

        Answer: "31.0"
        cat access.log | grep "fox" | awk -F 'Firefox' 'NF>1 {print $2}' | tr '"' ' ' | tr '/' ' ' > temp09.txt
        cat temp09.txt | awk '{print $1}' | sort -n | uniq -c | sort -nr

8. What is the most common HTTP method used?

        Answer: "GET"
        cat access.log | awk -F '] "' '{print $2}' | tr '"' ' ' | awk '{print $1}' | sort | uniq -c | sort -nr

9. What is the second most common HTTP method used?

        Answer: "CONNECT"
        Same command as #8 above.

10. How many requests were for \x04\x01\x00P\xC6\xCE\x0Eu0\x00?

        Answer: "6"
        Same command as #8 above.

<hr />
