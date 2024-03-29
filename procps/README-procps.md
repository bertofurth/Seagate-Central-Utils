# README-procps.md
procps is a suite of tools including ps, top and kill that
view and manipulate system status.

https://gitlab.com/procps-ng/procps/-/wikis/home

sysstat contains a number of tools to monitor system cpu and io 
performance. These include iostat, pidstat and mpstat.

https://github.com/sysstat/sysstat

The versions natively included in the Seagate Central are based
on the busybox tool or are very old and are therefore quite crippled
and don't always use standard command line parameters that would be
familiar to experienced unix users.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for procps specific notes and procedures.

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of software.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* ncurses-6.2 - http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz    
* procps-3.3.16 - https://gitlab.com/procps-ng/procps/-/archive/v3.3.16/procps-v3.3.16.tar.bz2
* sysstat-12.6.0 - http://pagesperso-orange.fr/sebastien.godard/sysstat-12.6.0.tar.xz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-procps.sh** script.

### Troubleshooting Installation
#### UNKNOWN version     
When checking the version of procps tools using the "--version" command
parameter the version may appear as UNKNOWN as per the following
example.

     # ps --version
     ps from procps-ng UNKNOWN

This is a known issue in some recent versions of the procps tools. As
long as the tool is reporting as being part of "props-ng" and not 
"busybox" then there is nothing to worry about.
