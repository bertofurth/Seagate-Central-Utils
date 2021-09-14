### BERTO stop doesn't work
# README-minidlna.md
miniDLNA (AKA ReadyMedia) is a lightweight DLNA media server
that is compatible with a wide range of media players including 
Smart televisions, DVD players, BluRay players, and PVRs.

https://sourceforge.net/projects/minidlna/

miniDLNA can be used to replace the proprietary and resource
hungry Twonky DLNA server originally included on the Seagate
Central. Please see the section at the end of this document 
called "Comparison of miniDLNA and Twonky" for more details.

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

The most important part of this configuration file is the **media_dir**
configuration lines that specify where the media folders that should
be scanned for content are located. 

Content directories can optionally be prefixed with any combination of
"A" "P" and "V" followed by a comma (,) to indicate that the folder 
should be indexed only for Audio, Pictures and/or Video content. No
prefix means all media content will be indexed. For example

    media_dir=A,/Data/Public/Music
    media_dir=PV,/Data/Public/Photos
    media_dir=/Data/Public/Videos

After editing the "minidlna.conf" file, transfer it to the Seagate Central.
Install the file in the "/etc/" directory as per the following example.

    install -o root -m 544 minidlna.conf /etc

#### Create "minidlna" user
The miniDLNA service will be run using a dedicated userid called 
"minidlna". This is more secure than simply running the service as 
"root" because it means that if the miniDLNA service suffers a fault,
or if any currently unknown security issue is exploited in the 
miniDLNA software, the damage will be limited to only the miniDLNA
service rather than the rest of the system.

The easiest way to create a new user is to use the Seagate Central Web
Management interface as follows.

Login to the Seagate Central Web Management interface as an admin
user.

Select the "Users" tab and then click on the "Add a new user" button.

Enter "minidlna" for the "Username" and enter a password. 

There is no need to fill in the "Remote Access" field with an email
address.

Do NOT select the "Administrator" checkbox. There is no need to make
the "minidlna" user a system administrator.

Finally click on the "Save" button.

#### /etc/init.d/minidlna-init.sh
In order for miniDLNA to run at system startup, an init script starting 
the server is required. We have included a custom startup script in this
project called "minidlna-init.sh".

As mentioned above, this script is setup to assume that there is a user
called "minidlna" that will be running the minidlna service. 

The "minidlna-init.sh" script needs to be transferred to the Seagate
Central and then installed into the "/etc/init.d/" directory as follows.

    install -o root -m 755 minidlna-init.sh /etc/init.d
    
Finally, generate the symbolic links that will cause the script to be
invoked at system startup as follows.

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
to your satisfaction and if you have decided to disable Twonky
you can save disk space by deleting the caches data previously 
generated by Twonky. This may take up a significant amount of
disk space if you have a large media library.

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
### Client issues
Client media players will display the old Twonky service as "SCSS DLNA 
Server: NAS-name" whereas the new miniDLNA service will appear as
"NAS-name: minidlna".

Some clients may take up to 15 minutes or so to recognize that the
old Twonky service has shutdown and the new minidlna service is
operational.

It may be that some clients with a weak implementation of the DLNA
client service might even need to be rebooted in order to recognize the
new service.

### Logs
The log file for miniDLNA is located at "/var/log/minidlna.log" however
the default log settings are such that not much ever appears in this log
unless something goes very wrong.

By modifying the "log_level" configuration option in "/etc/minidlna.conf"
or by invoking the server with the "-v" argument, many more
logs can be generated.

### miniDLNA status webpage
The miniDLNA server provides a simple status webpage accesible by browsing
to using the Seagate Central's ip address on port 8200. For example

    http://192.0.2.99:8200/

This status page shows brief statistics about what types of media has been
cataloged and what clients are connected.

There is also a useful indicator as to whether the process of building the
media database and cache is active by displaying a message reading "Media scan
in progress".

### High CPU during initial indexing
The very first time miniDLNA is started it performs an initial indexing
of the media library. This once off process can take a very long time and
generate a high CPU. Once the media database is built the server
will return to running with minimal CPU usage. This should only happen
once and not on each system reboot.

After activating miniDLNA for the first time, it is reccommended to 
waiting until miniDLNA has completely built it's media database before
trying to access the service from a client media player.

Use the miniDLNA status webpage referenced above to monitor the status
of the scanning process.

### Force a content rescan or database rebuild
Under normal circumstances miniDLNA should automatically detect any changes
to media added or removed and adjust it's database accordingly.

If for some reason media is not being scanned autmatically then miniDLNA
can be commanded to perform a manual scan of it's configured content
folders with the following sequence of commands issued with root
privileges.

    /etc/init.d/minidlna-init.sh stop
    /etc/init.d/minidlna-init.sh rescan
     
If a more severe problem occurs where the miniDLNA database becomes 
corrupted the database can be forced to be rebuilt with the following
sequence of commands.

    /etc/init.d/minidlna-init.sh stop
    /etc/init.d/minidlna-init.sh rebuild

Once final troubleshooting step in this regard would be to stop the
minidlna service, manually delete the database, then restart the
service which would then rebuild the database automatically

    /etc/init.d/minidlna-init.sh stop
    rm -rf /Data/minidlna/files.db
    /etc/init.d/minidlna-init.sh start

BERTO
## Comparison of miniDLNA and Twonky
### Open Source
miniDLNA is an open source product whereas Twonky is proprietary
and closed source. There's no guarantee that Twonky will continue
to support future formats of media files whereas new versions of
miniDLNA and it's associated libraries will continue to be updated,
or other open source alternatives will emerge to take it's place.

### Performance and resource usage
I performed some very brief tests on a Seagate Central system
containing a large media library of approximately 100,000 Photos,
3,000 Audio files and 5,000 short videos.

miniDLNA used much less CPU resources than Twonky and up to 5
times less memory during normal operation. 

Every time the system boots Twonky seems to spend about 15 minutes
performing some kind of index check that consumes the most of the
system's CPU resources however miniDLNA starts without any significant
CPU utilization.

As per the Troubleshooting section, miniDLNA does take a long time
to perform the initial indexing of media content but this occurs once
when the service is first activated and not on each system reboot.

The disk space used by the miniDLNA database was less than half that
of the Twonky database covering the same media content.

### Categorization of content
miniDLNA seems to collate slightly less categorization fields than
Twonky does. This could partially explain why miniDLNA is much
more efficient in terms of disk usage than Twonky.

The only glaring example that I found to be slightly inconvinient
was that miniDLNA did not categorize Video content by date of creationg
whereas Twonky does.

TODO : Develop a patch for miniDLNA to categorize Video by date. 
It shouldn't be hard because it's already done for Pictures.

### Configuration
miniDLNA has a very simple text configuration file in 
"/etc/minidna.conf" that must be manually edited to change service
parameters. Some more sophisticated DLNA servers have modern
GUI interfaces however these tools consume far more resources
than miniDLNA.

The version of Twonky installed on the Seagate Central has no
documented or obvious interface that can be used for configuration or
optimization. 

While the miniDLNA configuration file provides options that allow
for targeted scanning of particular folders for particular types of
content, Townky on the Seagate Central is setup to blindly catalog
everything in the Public folder regardless of whether it's 
appropriate to share to media players on the network.

