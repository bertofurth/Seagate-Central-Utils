# README-diskus.md
**diskus** is a tool written in Rust that calculates disk usage
faster than the standard "du" tool.

https://github.com/sharkdp/diskus/

The "du" tool is the most popular way to tally disk usage on the
command line however it can take a long time for the tool to
catalog a complicated file system with thousands of files and
directories. 

By making use of multiple threads, the "diskus" tool speeds up
the process. My own tests on the Seagate Central indicate that
"diskus" is almost twice as fast as "du".

The main reason the cross compilation of this particular tool is
documented is because it a "Rust" based utility. Hopefully the
cross compilation procedure in this project will apply equally
well to other Rust based software.

Since this project uses Rust, the build instructions in the main
**README.md** file are not really relevant. It is only strictly 
necessary to refer to the instructions below for the Rust specific
cross compilation for this project.

This cross compilation procedure is based on the information at

https://github.com/japaric/rust-cross

## Prerequisites
### Required software on build host
#### gcc cross compiler
Even though we are building Rust based software it is still
necessary to have a gcc based cross compilation toolsuite for Seagate 
Central available because the Rust compiler makes use of the gcc
linker program.

We recommend using the **Seagate-Central-Toolchain** project at the
following link to generate a GCC cross compilation toolchain suitable
for the Seagate Central.

https://github.com/bertofurth/Seagate-Central-Toolchain

#### Rust compiler
There are a number of ways to install a Rust compiler however these
instructions are based on the "Rust Up" tool.

https://rust-lang.github.io/rustup/index.html

Install "Rust up" as a normal user by downloading and invoking the
installation process as follows

    curl https://sh.rustup.rs -sSf | sh

Restart your shell session to apply the changes to the PATH that the
above command has automatically made for you.

Install the appropriate cross compilation "crate" for the arm 32 based 
Seagate Central.

    rustup target add arm-unknown-linux-gnueabi

#### Other prerequisites
Refer to the following sections in the main **README.md** file for
details about other prerequisites.
* su/root access on the Seagate Central.
* Know how to copy files between your host and the Seagate Central
* Do not perform these procedures as the root user on the build machine
* Optional - Add /usr/local/... to Seagate Central PATH

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of software.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* diskus-0.6.0 - https://github.com/sharkdp/diskus/archive/refs/tags/v0.6.0.tar.gz

Download the required source code archives for each component to 
the src subdirectory of the base working directory and extract them.
This can be done automatically for the versions listed above by running 
the **download-src-diskus.sh** script as follows

     ./download-src-diskus.sh

### Build the Rust based software
Before building the Rust based software, you will need to make a note of
the full path location of the "arm-XXX-linux-gnueabi-gcc" cross compiling
tool that is a part of the Seagate Central cross compilation toolset.
In the examples given below this tool is located at

    $HOME/Seagate-Central-Toolchain/cross/tools/bin/arm-sc-linux-gnueabi-gcc

Set an environment variable telling the Rust cross compiler the location 
of this version of gcc

    export CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABI_LINKER=$HOME/Seagate-Central-Toolchain/cross/tools/bin/arm-sc-linux-gnueabi-gcc

We also need to supply a linker parameter for Rust to pass to the gcc
compiler which specifies the location of the "sysroot" of the libraries
belonging to the cross compilation toolkit.

    export CARGO_TARGET_ARM_UNKNOWN_LINUX_GNUEABI_RUSTFLAGS="-C link-arg=--sysroot=$HOME/Seagate-Central-Toolchain/cross/sysroot/"
    
Finally, change to the source directory associated with the tool being built
and issue the following "cargo build" command in the source code directory to
cross compile the software.

    cd src/diskus-0.6.0/
    cargo build --target arm-unknown-linux-gnueabi

The generated binary executable will be located in the 
"target/arm-unknown-linux-gnueabi/debug" subdirectory.

You can optionally also specify the "--target-dir directory-name" parameter
to "cargo build" to specify a different base directory for the generated
build products.

Finally, if you don't plan to build any more rust projects in the
near future then you can now uninstall "rustup" and the associated
tools as they consume quite a large amount of disk space.

     rustup self uninstall
     
## Installation
Change to the directory containing the generated "diskus" cross compiled 
binary

     cd src/diskus-0.6.0/target/arm-unknown-linux-gnueabi/debug

### Optional - Strip the binary (Recommended)
The generated binary is quite large because it contains a large amount of
debugging data. "stripping" the binary will reduce its size by up to 90%
so it is highly recommended.

     strip diskus
     
### Transfer cross compiled binary to the Seagate Central
Since there's only one binary executable file being transferred to the
Seagate Central there's no need to create a tar archive as per the other
installation procedures.

This single binary executable file can be copied to the Seagate Central
in the same way that other files are normally copied to the NAS. 

In the following example we use the scp command to transfer the file.
You will need to substitute your own username and NAS IP address. After
executing the scp command you'll be prompted for the user's password.

    scp diskus admin@192.0.2.99:
    
### Login to the Seagate Central
Establish an ssh session to the Seagate Central.

The commands after this point in the procedure must be executed with
root privileges on the Seagate Central. This can be done by either
prepending **sudo** to each command or by issuing the **su** command
and becoming the root user.

### Install the new software
Install the new binary to the /usr/local/bin directory as follows.

    install -D -o root -m 755 diskus /usr/local/bin/diskus
     
Perform a sanity check to make sure the new tool is executable
by running the following command to check the version of the utility
that has been installed.

     diskus -V
     
Note that if the system PATH has not been modified accordingly then
you may need to specify the full path name when running a newly
installed executable.

## Basic "diskus" usage
Show total disk usage of the current directory and subdirectories

    diskus
     
Show total disk usage of multiple directories (e.g. /Data/admin and
/Data/Public)

    diskus /Data/admin /Data/Public

Only use 1 cpu thread (slower but less CPU resources)

    diskus -j1
    
Show "help" 

    diskus --help

