# README-coreutils.md
coreutils is a set of utilities providing some of the basic
core commands of a modern GNU base unix system. 

https://www.gnu.org/software/coreutils/![image](https://user-images.githubusercontent.com/53927348/133438365-71bf5616-1bf5-4462-a3dd-dd1bafd2a9b2.png)

Most basic unix commands are already implemented on the Seagate
Central however many are provided by the "busybox" tool which
has a focus on saving disk space as opposed to providing full 
functionality. Other coreutils are simply not included on
the Seagate Central.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for "coreutils" specific notes and procedures.

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of software.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* gmp-6.2.1 - http://mirrors.kernel.org/gnu/gmp/gmp-6.2.1.tar.xz
* acl-2.3.1 - http://download.savannah.gnu.org/releases/acl/acl-2.3.1.tar.xz
* coreutils-8.32 - http://mirrors.kernel.org/gnu/coreutils/coreutils-8.32.tar.xz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-coreutils-src.sh** script.

### Seagate Central libraries and headers
We need to copy over some specific library files and headers from the
Seagate Central to the build host so that they can be used during the
build process.

Create the appropriate sub directories under the base working 
directory to store the libraries and headers in. By default we use the
"sc-libs" subdirectory to store Seagate Central libraries and headers.

    mkdir -p sc-libs/usr/lib
    mkdir -p sc-libs/usr/include
    
The following commands show the required libraries and headers required
being copied by using the scp command. You will need to substitute your own 
username and NAS IP address.  

    scp admin@192.0.2.99:/usr/lib/libcap.so.2 sc-libs/usr/lib/libcap.so
    scp admin@192.0.2.99:/usr/lib/libattr.so.1 sc-libs/usr/lib/libattr.so.1
    ln -s libattr.so.1 sc-libs/usr/lib/libattr.so
    scp -r admin@192.0.2.99:/usr/include/attr sc-libs/usr/include/
    scp -r admin@192.0.2.99:/usr/include/sys sc-libs/usr/include/
       
After executing the scp command you'll be prompted for the password
for that username on the Seagate Central.

## Installation
The entire suite of coreutils commands are built by the build scripts
in this project directory, however it may not be necessary to install
all of them on the Seagate Central.

We would suggest only installing the specific utilities where you are
genuinely not happy with the version provided on the Seagate Central.

For your reference here is a full list of the coreutils commands built 
by these instructions.

b2sum, base32, base64, basename, basenc, cat, chacl, chcon, chgrp, 
chmod, chown, chroot, cksum, comm, cp, csplit, cut, date, dd, df, dir, 
dircolors, dirname, du, echo, env, expand, expr, factor ,false, fmt, 
fold, getfacl, groups, head, hostid, id, install, join, kill, link,
ln, logname, ls, md5sum, mkdir, mkfifo, mknod, mktemp, mv, nice, nl, 
nohup, nproc, numfmt, od, paste, pathchk, pinky, pr, printenv, printf,
ptx, pwd, readlink, realpath, rm, rmdir, runcon, seq, setfacl, 
sha1sum, sha224sum, sha256sum ,sha384sum, sha512sum, shred, shuf, 
sleep, sort, split, stat, stdbuf, stty, sum, sync, tac, tail, tee, 
test, timeout, touch, tr, true, truncate, tsort, tty, uname, unexpand,
uniq, unlink, uptime, users, vdir, wc, who, whoami, yes

