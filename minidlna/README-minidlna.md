# README-minidlna.md
miniDLNA (AKA ReadyMedia) is a lightweight DLNA media server using
that is compatible with a wide range of media players including 
Smart televisions, DVD players, BluRay players, and PVRs.

https://sourceforge.net/projects/minidlna/

miniDLNA can be used to replace the proprietary and often resource
hungry Twonky DLNA server originally included on the Seagate Central. 

Brief testing on my own Seagate Central NAS system containing 
approximately 100,000 Photos and 10,000 videos shows that miniDLNA
uses much less CPU time and up to 5 times less memory during normal
operation than Twonky. 

miniDLNA offers more granular and intelligent categorization of
content than the version of Twonky included on the Seagate Central.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for miniDLNA specific notes and procedures.

## Prerequisites
### Required software on build host
In addition to the prerequisites listed in the README.md document,
the following software packages need to be installed on the build
machine in order to compile this software

* tcl

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of sotware.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* libexit-0.6.22 - https://github.com/libexif/libexif/archive/refs/tags/libexif-0_6_22-release.tar.gz
* libjpeg-turbo-2.1.1 - https://downloads.sourceforge.net/project/libjpeg-turbo/2.1.1/libjpeg-turbo-2.1.1.tar.gz
* zlib-1.2.11 - https://zlib.net/zlib-1.2.11.tar.xz
* libid3tag-0.15.1b - https://downloads.sourceforge.net/project/mad/libid3tag/0.15.1b/libid3tag-0.15.1b.tar.gz
* libogg-1.3.5 - https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.5.tar.xz
* flac-1.3.3 - https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.3.3.tar.xz
* libvorbis-1.3.7 - https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.tar.xz
* sqlite-3.36.0 - https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz
* ffmpeg-4.4 - http://ffmpeg.org/releases/ffmpeg-4.4.tar.xz
* minidlna-1.3.0 - https://downloads.sourceforge.net/project/minidlna/minidlna/1.3.0/minidlna-1.3.0.tar.gz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-minidlna-src.sh** script.

## Installation
### Optional - Reducing the software size
#### Optional - Remove or strip static libraries (Strongly reccomended)
The static libraries generated while building minidlna take up a
particularly large amount of disk space. For this reason it is **very**
strongly reccommended that the static libraries be deleted, or at the
very least "stripped" as per the instructions in the **README.md** file.

### Install the new software
In addition to transferring and installing the cross compiled software,
the following extra steps need to be implemented for miniDLNA
installation.

#### /etc/minidlna.conf
miniDLNA uses a configuration file located at "/etc/minidlna.conf" to
govern it's operation. We have included a basic "minidlna.conf" 
configuration file in this project.

The most important aspect of this file is the **media_dir** configuration
lines that specify where the media folders that should be scanned
for content are located.

Edit then transfer the "minidlna.conf" file to the Seagate Central. Install
the file in the "/etc/" directory as per the following example.

    install -o root -m 544 minidlna.conf /etc

#### /etc/init.d/minidlna-init.sh
In order for miniDLNA to run at system startup, an init script starting 
the server is required. We have included a custom startup script in this
project called "minidlna-init.sh".

This script is setup to assume that there is a user called "minidlna"
that will be running the minidlna service. For this reason you should
create a user "minidlna" on the Seagate Central. 

We suggest that you create the user with the command line "adduser"
tool on the Seagate Central as follows. This will create the user
and a home directory where the minidlna cache and index can be stored, 
but no samba share will be put in place and this user will not be allowed
to login to the Seagate Central via ssh.

    adduser -h /Data/minidlna -s /bin/false minidlna

Alternativly the "minidlna" user can be created using the Seagate Central
Web Management interface, however this will mean that a new samba share 
directory will be created for "minidlna" which is probably unecessary.

If you wish to specify a different user to run the miniDLNA service then
edit the "minidlna-init.sh" script accordingly.

The "minidlna-init.sh" script needs to be transferred to the Seagate
Central and copied into the "/etc/init.d/" directory as follows.

    install -o root -m 755 minidlna-init.sh /etc/init.d
    
Finally, generate the startup links that will invoke the script at system
startup as follows.

    update-rc.d minidlna-init.sh defaults 76    
    
#### Disable Twonky DLNA server
While it is theoretically possible to run both the old Twonky DLNA
server and the new miniDLNA server at the same time, it would most 
likely be a waste of resources.

The easiest way to disable the Twonky DLNA service is to use the
Seagate Central Web Management interface. Under the "Services" tab
select the "DLNA" icon. Deselect the "Enable" check box on the right
hand side of the display then click the "Done" button to disable
the Twonky DLNA server.

#### Optional - Free up disk space used by Twonky data files
After you have confirmed that the new miniDLNA server is working
to your satisfaction you can save disk space by deleting the index
and cache data previously generated by Twonky. This may take up a
significant amount of disk space if you have a large media library.

    rm -rf /Data/TwonkyData/twonkycache
    rm -rf /Data/TwonkyData/twonkydb    

Removing this cache does not stop Twonky from working again in the
future. It only means that if Twonky is re-enabled, it will have to
rebuild the cache from scratch.

## Troubleshooting Building / Compilation 
### minidlna "in tree" building
The compilation process for miniDLNA is a little bit unique in that
the miniDLNA component itself does not seem to work well using the normal
"out of tree" build method. This means that binaries and object files 
need to be generated inside the same directory as the source code.

If for some reason you need to re-compile the minidlna component, you 
will likely need to delete the minidlna-X.X.X source code sub-directory 
then re-extract the source archive before building it again.

The other components of this project work properly with "out of tree"
building.
     
## Troubleshooting Installation
### Logs
The log file for miniDLNA is located at "/var/log/minidlna.log" however
the default log level settings are such that not much ever appears
in this log unless something goes very wrong.

By modifying the "log_level" configuraion option in "/etc/minidlna.conf"
or by invoking the server with the "-v" argument, many more
logs can be generated.

### Initial indexing
On it's initial run, miniDLNA took a very long time to index the existing
media library however, once this initial indexing was complete the system 
ran smoothly.

### miniDLNA status webpage
The miniDLNA server provides a brief status webpage accesible via the 
Seagate Central's ip address on port 8200. For example

    http://192.0.2.99:8200/



