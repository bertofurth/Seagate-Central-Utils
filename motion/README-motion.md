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
instructions below for motion specific notes and procedures.

## TLDNR
The quick "TLDNR" instructions for building motion are the same as the
"TLDNR" instructions in the main README.md file. 

The installation of motion on the Seagate Central and the configuration
of motion are too complicated to cover in a TLDNR however the basic
process is

* Customize the **motion.conf** and other configuration files.
* Install the configuration files to "/usr/local/etc/motion/"
* Create the "motion" user and add it to the "video" group.
* Install the **motion-init.sh** startup script
* Start the "motion" service manually or reboot

Please see the installation instructions below for more details.

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
When building the supporting libraries for motion, a wide range
of utilities related to image and video processing are generated.

These extra tools take quite a lot of disk space and they are 
not likely to be used on the Seagate Central.

For this reason, the "trim-build-motion.sh" script will remove
these extra utilities from the finished product.

If you'd prefer to keep these extra utilities then modify the
"trim-build-motion.sh" script accordingly.

### Install the new software
In addition to transferring and installing the cross compiled 
"motion" software on the Seagate Central, the following extra steps
need to be implemented to get "motion" running.

#### Configuration files - "/usr/local/etc/motion/..."
Motion uses configuration files that govern it's operation.
By default, these are stored in the "/usr/local/etc/motion/"
directory.

We have included a few sample configuration files in this
project that have been tailored for use on a Seagate 
Central. They were created with the goal of reducing CPU
load as much as possible.

**These configuration files must be modified before they
will work on your system!!!**

The sample configuration files contain comments and examples
that I hope will be useful but for detailed instructions
please refer to the documentation on the motion website.

https://motion-project.github.io/motion_config.html

##### motion.conf
This is the main "motion" configuration file that specifies
global parameters applying to all cameras being monitored
by "motion".

The main parameters this global configuration sets are to do
with the web management interface and the streaming service.

By default the motion web interface is available on port
8080 of the Seagate Central. For example.

     http://192.0.2.99:8080
     
The streaming service is activated on port 8081 and can
be accessed using a URL similar to the following where
"101" needs to be replaced by the "camera_id".

http://nas-1.lan:8081/101/stream

The example configuration has both of these services 
password protected with username "admin" and password "admin".
**Change these passwords before activating motion**

Many motion users disable both of these services or
make sure that they are well protected by a firewall
because they are not particularly secure.

##### camera-usb.conf
This is a sample configuration file that sets up motion to
monitor a locally connected USB camera registered as
"/dev/video0".

It saves captured images to the "/Data/Public/Motion/NAS-USB/"
directory.

##### camera-net.conf
This is a sample configuration file that sets up motion to 
monitor a remote net connected camera on an rtsp stream.

This file needs to be tailored to point to the IP address
of a real network camera in order to be effective. You
may also need to tailor the "netcam_url" parameter to
reflect the streaming service URL for your camera.

#### Create "motion" user and add to "video" group
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

You will then need to copy the group configuration file to the 
backup configuration otherwise the changes will be overwritten on
the next system reboot.

    cp /etc/group /usr/config/backupconfig/etc/group
     
#### Startup script - /etc/init.d/motion-init.sh
In order for "motion" to run at system startup, an init script starting 
the server is required. We have included a custom startup script in this
project called "motion-init.sh" which gets installed into the
"/usr/local/etc/motion" directory but it needs to be moved from here.

This startup script is setup to assume that there is a user called
"motion" that will be running the motion service. 

The "motion-init.sh" script needs to be copied to the
"/etc/init.d/" directory as follows.

    install -o root -m 755 motion-init.sh /etc/init.d
    
Generate the symbolic links that will cause the script to be invoked
at system startup as follows.

    update-rc.d motion-init.sh defaults 77    
    
#### Start the motion service
The "motion" service can be manually started with the following command
issued with root privileges.

     /etc/init.d/motion-init.sh start
     
The service will also be started automatically at system startup.

## Troubleshooting
Here are some of the issues I personally encountered when setting
up "motion" to work with a Seagate Central. They mostly relate
to the pitfalls of running "motion" on a low end system where
CPU resources are at a premium, and where you're using a low
end, low resolution USB or network camera.

### CPU load.
Image processing is a CPU intensive task. Since the Seagate Central 
is not a particularly powerful system, performing complicated image
processing and manipulation can take its toll on system resources.

I would suggest configuring "motion" to process frames at a very
low rate. My tests show that when motion is monitoring a single
camera using 640 x 480 resolution at 1 frame per second, the motion
process will consume between 10 - 20% of one CPU in the idle state.

If the frame rate is increased to 2 frames per second this goes 
up to between 30 - 50% of one CPU.

In general, the lower the frame rate, and the less pixels per
image that need to be processed, the lower the CPU load will be.
Therefore, the goal should be to configure motion to use the lowest
frame rate and the lowest picture resolution that is available.

### Movies
In addition to storing still images showing motion events, "motion"
has the ability to generate movie files. I would suggest *not* enabling
this feature as it consumes a great deal of CPU.

When the CPU is overloaded, motion will deliberately "cut" frames
from a generated movie file which means that a generated movie
might just be the first still frame of an event shown for the entire
length of the video!

### False positives
You will likely need to dedicate a significant amount of time
tuning the settings in the motion configuration files in
/usr/local/etc/motion/ to suit your environment.

The most persistant problem I faced was "False positives", meaning
that motion would start recording pictures when nothing was
obviously moving!

The main issue I had was with bright, white surfaces in the frame
of view. Even though according to my human eyes these surfaces
looked to be unchanging, "motion" was detecting some kind
of rapid changes in the pixels on these objects. This is apparently
called "flaring".

Below are some of the configuration options you can use while
troubleshooting this kind of problem.

#### locate_motion_mode on
Display a box around any areas that are supposedly moving. This
will at the very least indicate what motion "thinks" is changing.

#### text_changes on
Show the number of pixels motion thinks have changed in the top
right hand corner of each image.

#### picture_output_motion on
Periodically generate an extra image with the "m" suffix that
just displays which pixels motion thinks have changed. This
is particularly useful when you're looking at a "before" and
"after" image but just can't see any difference.

#### threshold (frames)
The most obvious parameter to change is the threshold which
indicates the number of pixels that have to change in order to
trigger an event, however it's crucial to also set the parameter
below as well.

#### noise_level (1 - 255)
This is the absolute amount of **brightness** that a pixel has to
change in order to get counted against the threshold value. That is,
if a pixel's brightness changes, but by less than "noise_level",
then it won't be counted.

This is particulaly useful for systems where the camera is "noisy"
or "crackles". In addition it is useful where an frame of view
is getting a lot of relfected light or shadows.

#### lightswitch_percent 10  / lightswitch_frames 1
If you have an environment where the light might be subtly increasing
over time (say if a cloud passes over), or if your USB camera
is trying to automatically compensate for light conditions by self
adjusting it's brightness settings then the "lightswitch" parameters
may help.

The main idea behind this parameter is to stop events being logged
with a sudden change in lighting condititons, such as a light being
turned on. However, I have found it more useful in conditions where
the light in a room changes subtly, such as when the monitored space
is a room that is partially lit by outside light sources but people
are moving outside the window and only slightly impacting lighting
conditions.

#### despeckle_filter EedDl / EeEedDdDl / EeEeEedDdDdDl  etc
I won't go into the details of how the despeckle filter works
but if you have a "noisy" environment then it may be worth trying
the above settings. The more "Ee" and "dD" commands that are
fed to this parameter, the more effective it is at eliminating
false positives generated by noise.

The problem with this feature is that it slightly increases CPU
utilization, however this is usually worth it to avoid false
positives.

### Manually take a picture with a USB camera
While "motion" is **not** running, the following "ffmpeg" command
will take a picture using the USB camera on /dev/video0. 

    ffmpeg -f v4l2 -i /dev/video0 -frames 1 out.jpg

The "ffmpeg" utility is included in the tools built alongside "motion".

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



