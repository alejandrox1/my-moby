# Running a container


## Getting started
Early Docker was essentially a wrapper for [LXC](https://linuxcontainers.org/).

The source code in this subdir come from the very first commit of Docker (now
Moby) project:
```
 $ git log --reverse
commit a27b4b8cb8e838d03a99b6d2b30f76bdaf2f9e5d
Author: Andrea Luzzardi <aluzzardi@gmail.com>
Date:   Fri Jan 18 16:13:39 2013 -0800

    Initial commit
```

To get the tests working you will also need to get LXC installed. 
In Ubuntu you can simly do
```
sudo apt install -y lxc
```
and you are set.


## Getting started with LXC
In order to get a better idea of what's going on wit early Docker we will need
to first get a hang for LXC and how it works.
For a more detailed explanation of the commands we will be using here please
reference [LXC basic usage](https://help.ubuntu.com/lts/serverguide/lxc.html).

Our first step will be to create a Bionic Beaver container for amd64 arch:
```
 $ sudo lxc-create -t download -n c1 -- -d ubuntu -r bionic -a amd64
[sudo] password for user: 
Using image from local cache
Unpacking the rootfs

---
You just created an Ubuntu bionic amd64 (20180719_08:51) container.

To enable SSH, run: apt install openssh-server
No default root or user password are set by LXC.
```

To double check, we will see all the containers in our system by doing the
following:
```
 $ sudo lxc-ls -f
NAME STATE   AUTOSTART GROUPS IPV4 IPV6 UNPRIVILEGED
c1   STOPPED 0         -      -    -    false
```

LXC will write store our newly created container in `/var/lib/c1`. 
Let's see what we find there...
```
 $ sudo -i
[sudo] password for user:
root@hostname:~# cd /var/lib/lxc/c1/
root@hostname:/var/lib/lxc/c1# ls
config  rootfs
```
So noteworthy here, we have the config file we generated via the `lxc-create`
command (the template used to create it resides `/usr/share/lxc/templates`).
More importantle, `rootfs` is (as the name implies) the root filesystem of the
container.

```
root@hostname:/var/lib/lxc/c1# ls -l rootfs/
total 76
drwxr-xr-x  2 root root 4096 Jul 19 03:52 bin
drwxr-xr-x  2 root root 4096 Apr 24 03:34 boot
drwxr-xr-x  4 root root 4096 Jul 19 03:51 dev
drwxr-xr-x 61 root root 4096 Jul 24 18:59 etc
drwxr-xr-x  3 root root 4096 Jul 19 03:52 home
drwxr-xr-x 11 root root 4096 Jul 19 03:52 lib
drwxr-xr-x  2 root root 4096 Jul 19 03:51 lib64
drwxr-xr-x  2 root root 4096 Jul 19 03:51 media
drwxr-xr-x  2 root root 4096 Jul 19 03:51 mnt
drwxr-xr-x  2 root root 4096 Jul 19 03:51 opt
drwxr-xr-x  2 root root 4096 Apr 24 03:34 proc
drwx------  2 root root 4096 Jul 19 03:51 root
drwxr-xr-x  2 root root 4096 Jul 19 03:53 run
drwxr-xr-x  2 root root 4096 Jul 19 03:52 sbin
drwxr-xr-x  2 root root 4096 Jul 19 03:51 srv
drwxr-xr-x  2 root root 4096 Apr 24 03:34 sys
drwxrwxrwt  2 root root 4096 Jul 19 03:52 tmp
drwxr-xr-x 10 root root 4096 Jul 19 03:51 usr
drwxr-xr-x 11 root root 4096 Jul 19 03:51 var
```
