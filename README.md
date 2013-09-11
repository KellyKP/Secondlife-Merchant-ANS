Secondlife Merchant ANS
=======================

This is OpenSource scripts in php and LSL for helping to keep control of all sources of your Second Life transaction logs onto your own server (requires MySQL and PHP)

All of this was originally started by me studying PHP (i'm a noob) and studying the tutorial Sassy Romano put up on the Secondlife Forums

Sassy Romano's tutorial: http://community.secondlife.com/t5/Merchants/Setting-up-Marketplace-to-use-ANS-and-log-to-an-external/td-p/1107297

updated the info to SL wiki info :http://wiki.secondlife.com/wiki/Direct_Delivery_and_Automatic_Notification_System

this so far includes:

1. the main ANS PHP script
2. basic in-world vendor script
3. SQL file for database

Don't have a web server?
=======================
If you don't have a web server, and want one, there is free hosting at http://x10hosting.com/ This is the host I use.
If you use this host, the MySQL host for the php scripts will be localhost.

Instructions
=======================
1. import the sql table
2. open ans.php and translog.php in you favorite test editing app, then enter your server info, replacing "Username", "Password",and "Database" with your database info.
3. upload ans.php and translog.php to your server, anywhere you like.
4. copy-paste ANSVendor.lsl into a script in SL and save it, setting the object description for price, and placing an object alongside the new script.
5. change ANS info on marketplace to URL of where your ans.php is located
6. test a sale in-world and on marketplace, if all goes well, you are done.