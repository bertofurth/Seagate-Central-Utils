# README-motion.md
Motion monitors video streams from a range of network and
USB based cameras. Motion can be used to record activity 
and view live footage.

https://motion-project.github.io/

In order for Motion to work with a USB camera connected to
the Seagate Central, the Linux kernel on the unit must be
upgraded and installed **with appropriate driver modules**
as per the instructions seen in the
**Seagate-Central-Slot-In-v5.x-Kernel** project at

https://github.com/bertofurth/Seagate-Central-Slot-In-v5.x-Kernel

Specifically refer to **README_USB_DEVICE_MODULES.md** for
details on including support for new USB devices on the
Seagate Central.

https://github.com/bertofurth/Seagate-Central-Slot-In-v5.x-Kernel/blob/main/README_USB_DEVICE_MODULES.md

Motion can work with external, network based cameras without
any kernel modification.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for procps specific notes and procedures.

## TLDNR
The quick "TLDNR" instructions for building motion are the same as the
"TLDNR" instructions in the main README.md file however, the installation
and configuration of motion is beyond what a TLDNR can cover. Please 
see the installation instructions below for more details.

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of software.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* libjpeg-turbo-2.1.1 - https://downloads.sourceforge.net/project/libjpeg-turbo/2.1.1/libjpeg-turbo-2.1.1.tar.gz
* zlib-1.2.11 - https://zlib.net/zlib-1.2.11.tar.xz
* ffmpeg-4.4 (libav*) - http://ffmpeg.org/releases/ffmpeg-4.4.tar.xz
* tiff-4.3.0 - https://download.osgeo.org/libtiff/tiff-4.3.0.tar.gz
* libpng-1.6.37 - https://download.sourceforge.net/libpng/libpng-1.6.37.tar.xz
* libwebp-1.2.1 - https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.2.1.tar.gz
* gmp-6.2.1 - http://mirrors.kernel.org/gnu/gmp/gmp-6.2.1.tar.xz
* nettle-3.7.3 - http://mirrors.kernel.org/gnu/nettle/nettle-3.7.3.tar.gz
* libtasn1-4.17.0 - http://mirrors.kernel.org/gnu/libtasn1/libtasn1-4.17.0.tar.gz
* gnutls-3.6.16 - https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.16.tar.xz
* libmicrohttpd-0.9.73 - http://mirrors.kernel.org/gnu/libmicrohttpd/libmicrohttpd-0.9.73.tar.gz
* alsa-lib-1.2.5 - https://www.alsa-project.org/files/pub/lib/alsa-lib-1.2.5.tar.bz2
* v4l-utils-1.20.0 - https://www.linuxtv.org/downloads/v4l-utils/v4l-utils-1.20.0.tar.bz2
* libx264 latest "stable" - https://code.videolan.org/videolan/x264/-/archive/stable/x264-stable.tar.bz2
* motion-4.3.2 - https://github.com/Motion-Project/motion/archive/refs/tags/release-4.3.2.tar.gz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-motion.sh** script as follows.

    ./download-src-motion.sh

## Installation
### Optional - Reducing the software size (Strongly recommended)
By default, motion is built to include a wide range of tertiary
utilities related to image and video processing. In particular the
ffmpeg suite of tools.

These extra tools take quite a lot of disk space. While they are
intellectually interesting, they are not likely to be used in a typical
installation of "motion".

For this reason, the "trim-build-motion.sh" scrip will remove
these extra utilities from the finished product.

If you'd prefer to keep these extra utilities then modify the
"trim-build-motion.sh" script accordingly.

### Install the new software
In addition to transferring and installing the cross compiled software,
the following extra steps need to be implemented for "motion"
installation.

#### Configuration files - "/usr/local/etc/motion/..."
Motion uses configuration files that govern it's operation.
By default, these are stored in the "/usr/local/etc/motion/"
directory.

We have included a few sample configuration files in this
project. 

**These configuration files need to be tailored to your 
system configuration before motion will work.**

The detailed configuration of motion is beyond the scope
of this project however hopefully the comments in the sample
configuration files are insightful enough to be a useful
guide. 

##### motion.conf
This is the main "motion" configuration file that specifies
global parameters applying to all cameras being monitored
by "motion".

The sample included in this project is setup to save pictures
from monitored cameras to the "/Data/Public/Motion" directory.

Bear in mind that any folders you specify in the configuration
files to be used for storing pictures or videos will need to be
writeable by the "motion" user. (See below)

This file is setup to use the USB camera configured in the
"camera-usb.conf" configuration file referenced below.

This file is setup so that the motion web interface is available
on port 8080 of the Seagate Central and the streaming service
is available on port 8081. Both are protected with the
username admin with password admin. Obviously this is something
that needs to be changed before the configuraion is put into place.

##### camera-usb.conf
This is a sample configuration file that sets up motion to
monitor a locally connected USB camera registered as
"/dev/video0".

##### camera-net.conf
This is a sample configuration file that sets up motion to 
monitor a remote net connected camera on an rtsp stream.

This file needs to be tailored to point to a real network
camera in order to be effective.

After the relevant files have been customized, transfer them to the
Seagate Central and install them in the "/usr/local/etc/motion"
directory.

#### Create "motion" user
The "motion" service will be run by a dedicated user called "motion".
This is more secure than simply running the service as "root" because 
it means that if the "motion" service suffers a fault, or if any
currently unknown security issue is exploited in the "motion" software,
the damage will be limited to only the "motion" service rather than the
rest of the system.

The easiest way to create a new user is to use the Seagate Central Web
Management interface as follows.

Login to the Seagate Central Web Management interface as an admin
user.

Select the "Users" tab and then click on the "Add a new user" button.

Enter "motion" for the "Username" and enter a password. 

There is no need to fill in the "Remote Access" field with an email
address.

Do NOT select the "Administrator" checkbox. There is no need to make
the "motion" user a system administrator.

Finally click on the "Save" button.

If you plan to connect USB cameras to the Seagate Central the new
"motion" user needs to be added to the "video" group in order to have
permission to access and manipulate attached USB cameras. Add "motion"
to the "video" group by running the following command as root.

    usermod -a -G video motion

#### Startup script - /etc/init.d/motion-init.sh
In order for "motion" to run at system startup, an init script starting 
the server is required. We have included a custom startup script in this
project called "motion-init.sh".

As mentioned above, this script is setup to assume that there is a user
called "motion" that will be running the motion service. 

The "motion-init.sh" script needs to be transferred to the Seagate
Central and then installed into the "/etc/init.d/" directory as follows.

    install -o root -m 755 motion-init.sh /etc/init.d
    
Finally, generate the symbolic links that will cause the script to be
invoked at system startup as follows.

    update-rc.d motion-init.sh defaults 77    
    
#### Start the motion service
The "motion" service can be manually started with the following command
issued with root privileges.

     /etc/init.d/motion-init.sh start
     
The service will also be started automatically at system startup.

## Troubleshooting
### CPU load.
Since the Seagate Central is not a particularly powerful system,
performing complicated image processing and manipulation can take its
toll on system resources.

I would suggest configuring "motion" to process frames at a very
low rate. My tests show that when motion is monitoring a single
camera using 640 x 480 resolution at 1 frame per second, the motion
process will consume between 10 - 20% of one CPU in the idle state.

If the frame rate is increased to 2 frames per second this goes 
up to between 30 - 50%.

In general the lower the frame rate, and the less pixels per
image that need to be processed, the lower the CPU load will be.

In addition to storing still images showing motion events, "motion"
has the ability to generate movie files. I would suggest not enabling
this feature as it consumes a great deal of CPU.

### Multiple /dev/videoX entries
Some USB cameras can generate two or more /dev/videoX entries. Only
the first one is a valid source of video streaming for motion. The 
others provide metadata. See

https://unix.stackexchange.com/questions/512759/multiple-dev-video-for-one-physical-device

### Removing persistent /dev/videoX entries
If you connect multiple USB cameras to the Seagate Central, the
unit will remember them and assign them each new /dev/videoX identities.

You can clear the cache of these identities by deleting the 
"/etc/dev.tar" file and rebooting the unit.
