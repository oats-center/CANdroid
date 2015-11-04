# CANdroid
CAN/ISOBUS Enabled Android

## NOTE ##
This project is still evovling. Hence, there might be major changes to
different parts of the project coming soon. This README will be updated
frequently to reflect these changes.

## What You Need to Make a CANdroid ##

### Hardware ###
1. One rooted [Nexus 9][N9] 
[N9]:https://www.google.com/nexus/9

### Software ###
1. Android NDK from [Google][ndk]
2. adb and fastboot
3. abootimg
4. Nexus 9 kernel source code repo **tegra** from [Google][tegra]
[ndk]:http://developer.android.com/ndk/downloads/index.html
[tegra]:https://android.googlesource.com/kernel/tegra/

## How to make a CANdroid (tested in Ubuntu) ##

### Preparation ###
1. Root and unlock your Nexus 9
2. Install adb and fastboot
3. Install Android NDK
Download Android NDK and decompress it. What we want is in this directory:
```shellsession
your-android-ndk/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin
```
It has prebuilt compiler for compiling the Android kernel. Make your sure you
add these files to your system path. To verfiy, run:
```shellsession
$ aarch64-linux-android-gcc --version
```
You should get something similar like this:
```shellsession
aarch64-linux-android-gcc (GCC) 4.9 20140827 (prerelease)
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```
4. Install abootimg
5. You may also want to add udev rules for Android devices to your system

### Compiling kernel source code ###
Copy candroid.patch from this repo into tegra repo. Check out **android-tegra
-flounder-3.10-lollipop-mr1** branch and apply the patch:
```shellsession
git am candroid.patch
``` 
NOTE: This patch contains changes for both enabling OTG charging and ISOBUS as
a builtin module.

Then, do:
```shellsession
$ export ARCH=arm64
$ export SUBARCH=arm64
$ export CROSS_COMPILE=aarch64-linux-android-
$ make flounder_defconfig
```
Copy .config from this repo into tegra repo and do:
```shellsession
$ make all -j4
```

This generates a kernel image **Image.gz-dtb** in arch/arm64/boot.

### Making a boot image ###
Using the boot.img.test provided in this repo, run:
```shellsession
$ abootimg -u boot.img.test -k tegra/arch/arm64/boot/Image.gz-dtb
```
If the command gives an error complaining about bootsize, run the above command
with **-c bootsize=VALUE**. VALUE is the larger value given in the error
message.

NOTE: Details on how **boot.img.test** is generated can be found [here][bootimg]
[bootimg]:http://forum.xda-developers.com/nexus-9/general/kernel-source-code-t2930286/page2

### Boot with new kernel image ###
Connect your Nexus 9 into your computer, run:
```shellsession
$ adb devices
```
You should be able to see your device with a serial number if it's properly
connected.

Then, reboot into bootloader:
```shellsession
$ adb reboot bootloader
```
Given that the device is unlocked, in the same directory where
**boot.img.test** is, run:
```shellsession
$ fastboot boot boot.img.test
```
Nexus 9 should boot into the kernel you just compiled. To verify, on Nexus 9,
go to Settings, About tablet, and in Kernel version you should see "candroid"
being appended.

If you think the new kernel image is tested, you can flash the image by
rebooting into the bootloader and then run:
```shellsession
$ fastboot flash boot boot.img.test
```

Now, you should have an Android device that has OTG charging capabilities and
CAN/ISOBUS interfaces.

A simple app that functions as a raw CAN message logger is [here][candroid-app].
Please see README in that repo.
[candroid-app]:https://github.com/wang701/candroid-app

















