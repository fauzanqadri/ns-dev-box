# A Virtual Mechine for Network Simulator version 2.35 projects

## Introduction

**Please note this VM is not designed for developing NS-2.35 core developemt, only doing project that use ns2.35**

This project automates the setup of a development environment for working with network simulator 2.35. Use this virtual machine to execute
NS code.

## Requirements

* [VirtualBox](https://www.virtualbox.com)
* [Vagrant](https://www.vagrantup.com)
* [XQuartz (Mac OS)](http://xquartz.macosforge.org/landing/)
* [Cygwin/X (Windows)](http://x.cygwin.com/)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/fauzanqadri/ns-dev-box.git
    host $ cd ns-dev-box
    host $ vagrant up

that's it

After the installation has finished, you can access the virtual machine
with

    host $ vagrant ssh
    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)
    ...
    vagrant@precise32:~$

hey, wait up. for the first time after the installation has finished.
there's something **IMPORTANT** you have todo before you begin the development. So,
here it is.

1. access your virtual machine
2. edit your $PATH environment on `/home/vagrant/.bashrc` file to have
   something like this

        export PATH=$PATH:/opt/ns-allinone-2.35/bin:/opt/ns-allinone-2.35/tcl8.5.10/unix:/opt/ns-allinone-2.35/tk8.5.10/unix
        export LD_LIBRARY_PATH=/opt/ns-allinone-2.35/otcl-1.14:/opt/ns-allinone-2.35/lib
        export TCL_LIBRARY=/opt/ns-allinone-2.35/tcl8.5.10/library:/opt/ns-allinone-2.35/tk8.5.10/library

meeeh, there you go step by step how to do that

    host $ vagrant ssh
    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)
    ...
    vagrant@precise32:~$ vi ~/.bashrc
    # ~/.bashrc: executed by bash(1) for non-login shells.
    ...
    ## Scroll using arrow-key with your key board until the end of file
    ## then hit i-key on your key board
    ## after that begin to type something like this
    export PATH=$PATH:/opt/ns-allinone-2.35/bin:/opt/ns-allinone-2.35/tcl8.5.10/unix:/opt/ns-allinone-2.35/tk8.5.10/unix
    ...
    ## after finished editing hit esc-key on your keyboard
    ## then type :wq and hit enter-key on your keyboard
    vagrant@precise32:~$ source /home/vagrant/.bashrc

and you ready to go...


## What's In The Box

* Development Tools

* Git

* ns-allione-2.35

## Recommended Workflow

The recommended workflow is

* edit in the host computer and

* execute your code within the virtual machine

just create `projects` directory into `ns-dev-box` directory on the host
computer

    host $ ls
    README.MD    Vagrantfile    puppet    sample_project
    host $ mkdir project

Vagrant mounts that directory as _/vagrant_ within the virtual machine:

    vagrant@precise32:~$ cd /vagrant/projects

We are ready to go to edit in the host, and execute in the virtual machine.

This workflow is convenient because in the host computer you normally
have your editor of choice fine-tuned, Git configured, and SSH keys in
place.

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk
**destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/)
for more information on Vagrant.

## License

Released under the MIT License, Copyright (c) 2012–<i>ω</i> Fauzan Qadri


## Special Thanks

1. The owner of 
   [this](https://vibhanshu86.wordpress.com/2014/06/17/installing-ns2-on-ubuntu-14-04/) blog to make installing NS-2.35 more easy
