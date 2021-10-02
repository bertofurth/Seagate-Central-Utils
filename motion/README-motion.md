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

Specifically refer to **README_USB_DEVICE_MODULES.md** in
the Seagate-Central-Slot-In-v5.x-Kernel project for
details on including support for new USB devices on the
Seagate Central.

https://github.com/bertofurth/Seagate-Central-Slot-In-v5.x-Kernel/blob/main/README_USB_DEVICE_MODULES.md

Motion can work with external, network based cameras without
any extra kernel modules.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for motion specific notes and procedures.

## TLDNR
The quick "TLDNR" instructions for building motion are the same as the
"TLDNR" instructions in the main README.md file. 

The basic process for installation and configuration of "motion" on
the Seagate Central is 

* Customize **motion.conf** and other configuration files.
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
* ffmpeg-4.4 (libav*) - http://ffmpeg.org/releases/ffmpeg-4.4.tar.xz
* motion-4.3.2 - https://github.com/Motion-Project/motion/archive/refs/tags/release-4.3.2.tar.gz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-motion.sh** script as follows.

    ./download-src-motion.sh

## Installation
### Optional - Reducing the software size 
When building the supporting libraries for motion, a wide range
of utilities related to image and video processing are generated.

These extra tools are not normally used however they may be useful
for troubleshooting. 

If you are concerned about disk usage, it might be prudent to go
through the cross/usr/local/bin directory and delete any tools that
you do not plan on using before you upload the cross compiled data
to the Seagate Central. At a bare minimum, only the "motion" executable
itself is required to run motion.

We suggest you **do not** delete any of the shared libraries in the
"cross/usr/local/lib" directory. The vast majority of these are needed
by "motion".

### Install the new software
In addition to transferring and installing the cross compiled 
"motion" software on the Seagate Central, the following extra steps
need to be implemented to get "motion" running.

#### Configuration files - "/usr/local/etc/motion/..."
Motion uses configuration files that govern it's operation.

The main configuration file is stored at 
"/usr/local/etc/motion/motion.conf"

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

##### motion.conf.sample
This is the main "motion" configuration file that specifies
global parameters applying to all cameras being monitored
by "motion".

The main parameters this global configuration sets are to do
with the web management interface and the streaming service.

By default, the "motion" web interface is available on port
8080 of the Seagate Central. For example.

     http://192.0.2.99:8080

Many users disable the web interface on port 8080 or make sure
that it is well protected by a network firewall because it is
not particularly secure.

The streaming service is activated on port 8081 and can
be accessed using a URL similar to the following where
"101" needs to be replaced by the "camera_id". For
example

    http://192.0.2.99:8081/101/stream

The example configuration has both of these services 
password protected with username "admin" and password "admin".

**Change these passwords before activating motion**

##### camera-usb.conf.sample
This is a sample configuration file that sets up motion to
monitor a locally connected USB camera registered as
"/dev/video0".

It saves captured images to the "/Data/motion/NAS-USB/"
directory.

##### camera-net.conf.sample
This is a sample configuration file that sets up motion to 
monitor a remote network connected camera generating an rtsp
style video stream.

You will need to tailor the IP address and streaming service
URL to suit your network camera.

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

If you plan to connect USB cameras to the Seagate Central, the new
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

### CPU load
Image processing is a CPU intensive task. Since the Seagate Central 
is not a particularly powerful system, performing complicated image
processing and manipulation can take its toll on system resources.

I would suggest configuring "motion" to process frames at a very
low rate. Set the "minimum_frame_time" parameter to the number of
seconds between each frame. 

In addition, using a smaller resolution for pictures ("width" and 
"height") can also help with CPU load.

I personally found the best compromise between CPU load and
picture quality was using "minimum_frame_time 1" and a picture
resolution of "width 640" and "height "480".

I would also strongly advise going to the effort of correctly
configuring the camera stream type as per the **Stream characteristics**
and **Raw image stream** sections below to potentially save 
signficant CPU resources.

In general, the lower the frame rate, and the less pixels per
image that need to be processed, the lower the CPU load will be.
Therefore, the goal should be to configure motion to use the lowest
frame rate and the lowest picture resolution that is acceptable.

#### Stream characteristics
In order to let motion run efficiently it is important to
make sure the "width" and "height" settings within the camera
specific configuration file match one of the available stream
profiles of the camera in use. 

The "ffprobe" command is built by default as part of generating
the "motion" tool. It can be used to determine the image dimensions 
that an attached camera is capable of producing. Note that it can
only be run while "motion" is not running and using the video device. 

For example, the following command will show the range of available
stream characteristics of the device using /dev/video0.

    ffprobe /dev/video0 -list_formats all

If you are using a network stream then the characteristics of
the stream should be configurable on the network camera
itself.

#### Raw image stream (Advanced but important)
This parameter is difficult to get right but it can save
very significant CPU resources if configured correctly.

By default, "motion" may try to use a JPEG or compressed stream
coming from an attached USB camera as the source for it's image
stream. This will add significant processing load to "motion"
because it will need to spend CPU cycles decompressing each
received JPEG image in order to analyse it and detect
a motion event.

It is much better if motion can receive images in a raw
and uncompressed format from the camera.

Try to use the ffprobe tool (see above) to see what kinds of
raw or uncompressed streams your camera supports. 

The stream format for an attached USB camera can then be configured
using the "v4l2_palette" motion configuration file parameter to
match one of the available profiles seen in the ffprobe command
output.

See the "motion" documentation for details of what types of
streams can be accepted by motion.

https://motion-project.github.io/motion_config.html#v4l2_palette

If a stream type (v4l2_palette) is not explicitly configured then
motion may default to using a compressed/JPEG style stream from the
camera which might cause extra CPU load.

Check the "motion" log file while using a "log_level" of 7 to see
what image stream parameters are being used by motion as it
starts up.

#### Movies
"motion" has the ability to generate movie files of detected events.
I would suggest *not* enabling this feature as it consumes a great
deal of CPU.

When the CPU is overloaded, motion will deliberately "cut" frames
from a generated movie file which means that a generated movie
might end up being just one "still" frame shown for the entire
length of the video!

#### mask settings
It's possible to block out portions of the field of view in motion
by using the mask_file, mask_privacy and smart_mask_speed settings.
These features consume significant CPU resources. If possible, try to
avoid turning these on.

### False positives
You will likely need to dedicate a significant amount of time
tuning the settings in the motion configuration files in
/usr/local/etc/motion/ to suit your environment.

The most persistant problem I faced was "False positives", meaning
that motion would start recording pictures when nothing was
obviously moving.

The main issue I had was with bright, white surfaces in the frame
of view. Even though, according to my human eyes, these surfaces
looked to be unchanging, "motion" was detecting some kind
of rapid changes in the pixels on these objects. This is apparently
called "flaring".

Below are some of the configuration options you can modify while
troubleshooting "False positives".

#### locate_motion_mode on
Draw a box around any areas that are supposedly moving. This
will at the very least indicate what motion "thinks" is changing.

#### text_changes on
Show the number of pixels motion thinks have changed in the top
right hand corner of each image.

#### picture_output_motion on
With each image generated, also generate an extra image with 
the "m" suffix that just displays which pixels motion thinks
have changed. This is particularly useful when you're looking 
at images generated by an event and you just can't see any
difference.

#### threshold (frames)
The most obvious parameter to change when troubleshooting 
"False Positives" is the threshold which indicates the number of
pixels that have to change in order to trigger an event.

Setting this value too low will mean that "False postives" will
be generated. Setting it too high will mean that events will not be
triggered as desired. 

Note that you need to take the total number of pixels in an image
into account when setting this value. (i.e. check "width" times 
"height")

#### noise_level (1 - 255)
This is the absolute amount of **brightness** that a pixel has to
change in order to get counted as "changed". That is,
if a pixel's brightness changes, but by less than "noise_level",
then it won't be counted against the "threshold" parameter.

This is particulaly important for systems where the camera produces
a "noisy" image. In addition it is useful where an frame of view
is getting a lot of reflected light or shadows.

#### lightswitch_percent / lightswitch_frames 
If you have an environment where the light might be subtly increasing
over time (say if a cloud passes over), or if your USB camera
is trying to automatically compensate for light conditions by self
adjusting it's brightness settings then the "lightswitch" parameters
may help.

The main idea behind these parameters is to stop events being logged
with a sudden change in lighting condititons, such as a light being
turned on. However, I have found it more useful in conditions where
the light in a room changes subtly. For example, when the monitored space
is a room that is partially lit from the outside and a cloud passes
over, or when objects move past a door or window causing the light
level to slightly change.

#### despeckle_filter EedDl / EeEedDdDl / EeEeEedDdDdDl 
I won't go into the details of how the despeckle filter works
but if you have a "noisy" environment then it may be worth trying
the above settings. The more "Ee" and "dD" commands that are
fed to this parameter, the more effective it is at eliminating
false positives generated by noise.

The problem with this feature is that it very slightly increases 
CPU utilization, however this is usually worth it to avoid false
positives.

### Manually take a picture with a USB camera
While "motion" is **not** running, the following "ffmpeg" command
will take a picture using the USB camera on /dev/video0. 

    ffmpeg -i /dev/video0 -frames 1 out.jpg

The "ffmpeg" utility is included in the tools built alongside "motion".

Doing this can be useful to check that the camera is indeed
working independantly of motion. 

### Multiple /dev/videoX entries
Some USB cameras can generate two or more /dev/videoX device entries.
Only the lowest numbered one is a valid source of video streaming for motion.
The others provide metadata. See

https://unix.stackexchange.com/questions/512759/multiple-dev-video-for-one-physical-device

### Removing persistent /dev/videoX entries
If you connect multiple USB cameras to the Seagate Central, the
unit will remember them and assign them each a new /dev/videoX identity.

You can clear the cache of these identities by deleting the 
"/etc/dev.tar" file and rebooting the unit.

### Failed to set UVC probe control
Sometimes while starting and stopping the "motion" service multiple
times, perhaps during initial setup, the software can stop working and
an error message as follows might appear in the system logs

    uvcvideo 1-1:1.1: Failed to set UVC probe control : -110 (exp. 26).
    
Unfortunately the only workaround I could find was to reboot
the unit.

The issue only seemed to occur when the motion service was being
forced to stop and restart many times. I did not see this issue
while "motion" was running in a stable and uninterupted manner.

## Notes
### Optional patches for motion
There are two optional patches for "motion" that might be of help
but only in corner cases.

#### 0001-motion-NTP-update-snapshot.patch
This patch solves a rare issue where if the NTP client service,
which gets invoked every 30 minutes on the Seagate Central, sets the
system clock backwards by more than 1 second then the "snapshot"
feature of motion may errantly generate an image at that time.
That is, on the Seagate Central, a "snapshot" could be taken
every 30 minutes instead of the configured "snapshot_interval".

     patch -i 0001-motion-NTP-update-snapshot.patch src/motion-release-4.3.2/src/motion.c

This has been logged as an enhancement request for "motion".

https://github.com/Motion-Project/motion/issues/1414

#### 0002-motion-light-switch-low-frame-rate.patch
Sometimes when using motion in a very low frame rate configuration, as
we are doing on the Seagate Central, it can take a few seconds before
an object is recognized as being part of the "static" background. This
patch can speed up this process (I think).

     patch -i 0002-motion-light-switch-low-frame-rate.patch src/motion-release-4.3.2/src/alg.c

### Use ffmpeg to generate a network stream (Interesting note)
The "ffmpeg" tool that comes built with "motion" has a rudimentary web 
server built in that may improve in quality in future ffmpeg releases. 

The following command can be used to setup a "temporary" mjpeg style 
network stream from a video source on /dev/video0

    ffmpeg -framerate 1 -input_format mjpeg -i /dev/video0 -c copy -listen 1 -f mjpeg http://[::]:9999
    
If you use a tool like VLC that is capable of listening to an mjpeg style
network stream then you may enter a network stream URL similar to

    http://192.0.2.99:9999
    
and you will be able to see the stream from the attached video camera.

Since the ffmpeg command has been directed to "copy" the mjpeg stream
from the camera and pass it along largely unmodifed, this "simple" streaming
service does not consume much CPU at all!

Note that only one client can connect at a time, and once the client has
disconnected the "ffmpeg" command will exit. Also note that this does not
work at the same time as "motion" is using the specified /dev/videoX device.

### Use a "by-id" device rather than /dev/videoX
UPDATE : THIS DOESN'T ALWAYS WORK!!!! USE WITH CAUTION!!!

It may be wiser to use a "by-id" device name rather than /dev/videoX to
specify an attached video camera device if you are using more than one
USB video camera. This way, even if the device number changes, you will
still be assured of connecting to the right device.

For example, on my system I have a USB camera on /dev/video0 but I also
have the following "by-id" device name that will be permanently assigned
to this device.

    /dev/v4l/by-id/usb-046d_0809_AFB3B233-video-index0

I can then specify this unique device name in the motion configuration
file instead of using /dev/video0.

Check the /dev/v4l/by-id/ directory on your system once your camera is
connected in order to determine it's unique ID.

### mjpg-streamer
An alternative to "motion" is to simply setup the Seagate Central as a
streaming device that does no analysis. This can be accomplished using
the "mjpg-streamer" tool from

https://github.com/jacksonliam/mjpg-streamer

The build script for this tool is located in the TODO subdirectory. It
needs to be executed anytime after libjpeg-turbo has been built.

See the build script for instructions and further details.
