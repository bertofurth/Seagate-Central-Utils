# README-motion.md
Motion monitors video signals from a range of network and
USB based cameras. Motion can be used to monitor activity 
and view live streams.

https://motion-project.github.io/

In order for Motion to work with a USB camera connected to
the Seagate Central, the kernel must be upgraded and customized
to include support for any connected USB camera as per

See TODO BERTO BERTO GET THE KERNEL STUFF WORKING

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
"TLDNR" instructions in the main README.md file however, the in depth
configuration of motion once it is installed is beyond what a TLDNR can
cover. Please see the installation instructions below for more details. BERTO

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
* motion-4.3.2 - https://github.com/Motion-Project/motion/archive/refs/tags/release-4.3.2.tar.gz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-motion.sh** script as follows.

    ./download-src-motion.sh

BERTO BERTO

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


### BERTO Configuration 

## With a USB cam

## With a network cam


## Mention about CPU load




