README
======

Introduction
------------

This is an app mocks twitter. It allows user registrations, manage posts and comments and chatting with other usres. The app is stored on Amazon 
EC2 and can be accessed [here][1].

[1] http://54.235.204.89

Build
-----
Build on top of rails and use MYSQL database. The images/videos are stored on Amazon S3. Real-time chatting function is implemented by 
faye messaging system and private_pub gem.

Todo
----
1. Background image processing
2. The information collection and website subscription module