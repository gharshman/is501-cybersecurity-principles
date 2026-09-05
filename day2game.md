## Day 2 Game @ https://charcycon.ctfd.io/challenges

<hr />

> [!WARNING]  
> Use this code at your own risk!

<hr />

## OSINT

1. Where's the Witch?

        Answer: IS401_{london}
        Download image
        Google search "Count Orlok's Nightmare Gallery" or Google image search

2. What are you doing here? (Part 1)

        Answer: IS401_{10-23-2014_09:58AM}
        Download image
        View image properties to get the date/time info

3. What are you doing here? (Part 2)

        Answer: IS401_{1600x1077}
        View image properties to get the dimensions

4. What are you doing here? (Part 3)

        Answer: IS401_{Nikon-D4}
        View image properties to get the camera make & model


5. Zombie = Brainrot (Part 1)

        Answer: IS401_{$159.99}
        Download image
        Google image search = "Spirit Halloween Pop-Up Zombie Toilet (2014)"
        Click link for "Spirit Halloween" to see price

6. Zombie = Brainrot (Part 2)

        Answer: IS401_{16.14"H X 22"L X 14.96"W}
        Spirit Halloween website has this info

7. We’ve Got Spirits, Yes We Do! (Part 1)

        Answer: IS401_{Chelsea_Career_and_Technical_Education_High_School}
        Download image
        Google image search = "Village Halloween Parade"
        Google AI gives incorrect answers when asked to identify the building
        Google parade route = "6th Ave from Spring St. to 16th St."
        Google "What high schools are on 6th avenue in Greenwich Village?"
        High school is at the southern terminus of the parade route
        Street view: https://maps.app.goo.gl/kVpXFw5z3m9gg4EQ6

8. Zombie = Brainrot (Part 3)

        Answer: IS401_{Last_Chance_Gas}
        Google "Spirit Halloween experiences"
        Spirit Halloween website calls them "In-Store Experiences (ISE)"
        Spirit Halloween web page for toy shows ISE Appearance = "Last Chance Gas"

9. You're a Wizard DJ

        Answer: IS401_{Gryffindor}
        Google "DJ Hovermale" and click images
        Image on Erudio website shows him wearing a scarlett & gold costume
        Google "Hogwarts houses"
        "Scarlett & gold" = Gryffindor House

10. The Phantom Profile

        Answer: IS401_{found_the_phantom}
        Git commit logs are found in the ".git" subfolder in a repository ("repo")
        Download the file and extract it
        Extract the "phantom_repo.tar.gz" file
        Run "cat ./drive-download-20251016T220132Z-1-001/phantom_repo/.git/logs/refs/heads/master"

<hr />

## Syllabus

1. Where in the World is IS 401/501?

        Answer: IS401_{BAB226}
        Download syllabus in PDF format
        Answer on line 14

2. Establish Comms

        Answer: IS401_{Discord}
        Search syllabus for "comm"
        Answer on Page 3, third line from the bottom

3. Making the Grade

        Answer: IS401_{60}
        Search syllabus for "points", "NCL", or "%"

4. Enter the Dojo

        Answer: IS401_{Google_Fu}
        Search syllabus for "black", "belt", or "black belt"

5. Save the Date

        Answer: IS401_{20260915}
        Search syllabus for "notify"

6. The Charger Cipher

        Answer: IS401_{8_18_9_18}
        Syllabus says "At the end of the syllabus..."
        Go to the last page (page 6) of syllabus
        The four (4) values are "Honor", "Respect", "Integrity", and "Reliability"
        The four (4) first letters are "HRIR"
        H = 8, R = 18, I = 9, R = 18

7. Down the Policy Rabbit Hole

        Answer: IS401_{preponderance_of_the_evidence}
        Google search for "UAH Academic Misconduct Policy"
        Search document for "proof"

8. AI Has Entered the Chat

        Answer: IS401_{39353234}
        Search syllabus for "confidence" = 95%
        Search syllabus for "response" = 24
        Convert 9-5-2-4 to ASCII = 57-53-50-52
        Convert 57-53-50-52 to hex = 39-35-32-34

9. Hash Me Maybe

        Answer: IS401_{5e5f9429633e}
        Official course name in syllabus = "Cybersecurity Principles"
        At CLI, type:
                echo -n "Cybersecurity Principles" | sha256sum
        Output = 5e5f9429633e747a70968a3ad6183c285689f2f292b622c3091661ff72d3ca9d
        Other SHA-256 tools will also work, but ensure letters are lower case

10. The Syllabus Boss Battle

        Answer: IS401_{ab8ddc4792a5e4c0}
        A = BAB226 (#1 above)
        B = 20260915 (#5 above)
        C = 60 (#3 above)
        At CLI, type:
                echo -n "BAB226|20260915|60" | sha256sum
        Output = ab8ddc4792a5e4c0781e8fef0aa9e6318e099b2374ee3e5d4999332bf92fd2ee
        Other SHA-256 tools will also work, but ensure letters are lower case

11. The Boss's Boss

        Answer: IS401_{TH4T!$tr1cky8R0}
        This is a trick question...The answer is not in the syllabus...You have to view the hint.

<hr />

## Incident Response (Log Analysis)

1. What the Hack? (001)

        Answer: IS401_{197.211.46.206}
        Download five (5) log files and perform a little cleaning/ETL.
        Combine the log files into one "big.log" file, putting the original file name at the end
        of each line:
                awk '{print $0 " auth1.log"}' auth1.log >> big.log
                awk '{print $0 " auth2.log"}' auth2.log >> big.log
                awk '{print $0 " auth3.log"}' auth3.log >> big.log
                awk '{print $0 " auth4.log"}' auth4.log >> big.log
                awk '{print $0 " auth5.log"}' auth5.log >> big.log
        Remove whitespace from the date to facilitate "cutting" the file later and keeping the
        date/time in one field. Save as new filename "clean.log".
                awk '{print substr($0,1,3) "-" substr($0,5,2) "-" substr($0,8)}' big.log > clean.log
        Sort the file, search for "failed", and show the first 30 records.  The answer is the
        first record.
                sort clean.log | grep -i "Failed" | head -30

2. But When, Bro? (002)

        Answer: IS401_{Sep 25 at 0625}
        Use same output from question #1.

3. The Fall Guy (003)

        Answer: IS401_{ian}
        Use same output from question #1.

4. Epic Fail (004)

        Answer: IS401_{root}
        The log file "auth1.log" is 1,305 lines ... too long for eyeball scan.
        Run command:
                cat auth1.log | grep -i "failed" | awk -F'\\]: ' '{print $2}' | sort
                cat auth1.log | grep -i "failed" | awk -F'\\]: ' '{print $2}' | sort | wc -l
        Our filtered results are now 332 lines, easier to eyeball scan, and the answer appears
        to be "root".  Grep again shows that "root" makes up 265 lines.

5. Fail Blog (007)

        Answer: IS401_{auth5.log}
        Run command:
                grep -i "Failed" clean.log | awk '{print $NF}' | sort | uniq -c | sort -nr

6. Schizophrenia (009)

        Answer: IS401_{14.199.107.35}
        The log file "auth3.log" is 993 lines long ... too long for eyeball scan.
        "cron" is a service, so we want to filter for just "sshd" and "failed".
                cat auth3.log | grep -i "sshd" | grep -i "failed" | wc -l
        This gets us down to 209 lines. We need to extract the username and the IP address.
        Most lines (181) have the word "user" immediately preceding the username.
        Put these 181 lines (87%) in a new file.
                cat auth3.log | grep -i "failed" | grep -i "user" > auth3stats.txt

        We want fields $6 and $8, but we want the IP address first.
                cat auth3stats.txt | awk -F'\\]: ' '{print $2}' | awk '{print $8, $6}' > auth3IPs.txt
        Now we need to grab the username and IP address from the remaining 29 lines.
        We can use the grep -v flag for "invert selection".
                cat auth3.log | grep -i "failed" | grep -i "user" -v > auth3stats2.txt
        Now we notice that 11 of the 29 lines are different, so we have to handle them separately.
                cat auth3stats2.txt | grep -i "message" -v >  auth3stats3.txt
                cat auth3stats2.txt | grep -i "message" >  auth3stats4.txt
        Now we can pull out fields $4 and $6 from auth3stats3.txt...
                cat auth3stats3.txt | awk -F'\\]: ' '{print $2}' | awk '{print $6, $4}' >> auth3IPs.txt
        And we can pull out fields $4 and $6 from auth3stats4.txt...
                cat auth3stats4.txt | awk -F'\\[ ' '{print $2}' | awk '{print $6, $4}' >> auth3IPs.txt
        Finally, we have a clean list of IPs and usernames that we can pivot...
                cat auth3IPs.txt | sort -n | uniq | cut -d " " -f1 | sort -n | uniq -c | sort -nr

7. The Biggest Loser (011)

        Answer: IS401_{admin}
        Log file auth5.log is the longest at 33,074 lines.
        We are looking for "invalid user" attempts.
                cat auth5.log | grep -I ": invalid user" > auth5stats.txt
                cat auth5stats.txt | awk -F': invalid user ' '{print $2}' > auth5users.txt
                cat auth5users.txt | cut -d" " -f1 | sort | uniq -c | sort -nr | head -30

8. The Second-Biggest Loser (012)

        Answer: IS401_{user}
        Same output from #7 can answer this question.

9. How Big is Their Army? (013)

        Answer: IS401_{380}
        This time we need the "big.log" file from #1 above.
        Since we only need the IP address of the "Failed" lines, we can use a regex filter.
                cat big.log | grep -i "Failed" | grep -oP '(\d{1,3}\.){3}\d{1,3}' | sort -u | wc -l

<hr />

