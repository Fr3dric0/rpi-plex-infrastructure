Raspberry PI4 Plex mediaserver
===

Simple declarative infrastructure to setup Plex media server, with the help of ansible.
We do not set a static IP but instead use an announced hostname, such as `raspberrypi.local`.

> This is tested with a Raspberry PI 4, but should work with previous versions as well.
> If you're using an older version and has an external HDD, please ensure that this HDD has its own powersource. Older Raspberry PIs does not have enough power to run both itself and an external HDD.

## Tasks

1. Install plexmediaserver
2. Setup basic firewall rules
3. Mount external HDD to system, and give user `pi` ownership of it

## Prerequisites

1. Setup raspberry PI with Raspbian (preferably lite), 
   and to be accessible over ssh (Simply add the empty file `ssh` to the root of the SD card partition).

   We expect to connect to it on host `raspberrypi.local`, which is the default host for a new raspberry pi. However, you can and should change this to something else in `hosts`.
2. Your public key `id_rsa.pub` has been copied to `~/.ssh/authorized_keys` (you might have to create the file first) on the raspberry pi. 

    Ensure the key does not require a password.
3. Ansible `>= 2.8.1` installed and can run `ansible-playbook` in your terminal

## Setup

1. Update the external drive's `UUID` in `rpi-plexserver.yaml`, task: "Mount External HDD to server".
   
   > You might also need to change the fstype, to the correct type (see: https://docs.ansible.com/ansible/latest/modules/mount_module.html).
2. Optional: Change the mount path to somewhere else. We have chosen /home/pi/wdpassport
3. Run `./run_ansible.sh` and wait.
4. Visit http://raspberrypi.local:32400/ and do the expected configurations to load your libraries


## Common pitfalls

### Plex fail to read my external drive

Firstly ensure that the drive has actually been mounted.

Then ensure that the owner of the drive is `pi` and that plexmediaserver runs as user `pi`
(Should have been set automatically, when we copied `files/plexmediaserver` to the host).

It is probably a ownership issue where the plexmediaserver cannot get access to the drive.
You should ensure that the drive's entry in `/etc/fstab` does properly give ownership to the user `pi`.
`uid` should equal `id -u pi` and `gid` should equal `id -g pi`.


