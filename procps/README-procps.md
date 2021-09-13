# README-procps.md
procps is a suite of tools including ps, top and kill that
view and manipulate system status. The versions natively
included in the Seagate Central are based on the busybox tool
and are therefore quite crippled and don't use standard command
line parameters that would be familiar to experienced unix
users.

https://gitlab.com/procps-ng/procps/-/wikis/home

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for procps specific notes and procedures.

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of sotware.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* ncurses-0.6.22 - http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz    
* procps-3.3.16 - https://gitlab.com/procps-ng/procps/-/archive/v3.3.16/procps-v3.3.16.tar.bz2

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-procps-src.sh** script.

### Seagate Central libraries and headers
We need to copy over one specific library file from the Seagate
Central to the build host, namely "/usr/lib/libncurses.so.5.0.7", 
so that it can be linked to during the build process.

Create an appropriate sub directory under the base working 
directory to store the library in. By default we use the "sc-libs"
subdirectory to store Seagate Central libraries.

    mkdir -p sc-libs/usr/lib
    
In this example we copy the required library using the scp command. 
You will need to substitute your own username and NAS IP address.
After executing the scp command you'll be prompted for the 
password for that username on the Seagate Central. 

    scp admin@192.0.2.99:/usr/lib/libncurses.so.5.0.7 sc-libs/usr/lib/
       
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
