# README-lighttpd.md
lighttpd is the web server software that runs on the Seagate Central.

https://www.lighttpd.net/

The version generated by these instructions has extended capabilities
in the case that you wanted to run extra web services on the 
Seagate Central.

This would be useful if you wanted to establish a "webdav" service on the
Seagate Central or host a webpage.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for notes and procedures specific to "wget2".

## Build Procedure
### Source code download and extraction
This procedure was tested using wget2 v2.0.1. See the download-src-lighttps.sh
script file included in this project for versions of supporting 
libraries tested.

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the tested versions
by running the **download-src-lighttpd.sh** script.

## "lighttpd" basic usage
TODO : Modify /etc/init.d/lighttpd to point at the new deamon
installed in /usr/local/bin rather than the original one in /usr/sbin.






