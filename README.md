# vagrant-test

## Task description

1. Create vagrant file having 4 linux machines. (centos)

2. Machines should be provisioned automatically, with chef(preferably, some shell/ruby is ok too) and at the end of "vagrant up" command it should work as following:

- 2 apache servers reporting “I’m server 1”/“I’am server 2” on default page.
- 1 HA proxy balancing 2 apache servers.
- Last machine should run Jenkins server with 1 job, which sends GET towards HA every hour, passing if "server 1”is active , failing if “server 2” is active. 
- Job should run every hour in nights only, from 00:00 to 06:00

## Notes

0. I was unable to quickly setup virtualbox on a remote Debian box so I've tried a Docker but Docker provider for vagrant didn't worked out-of-the-box so I went to installing all stuff on my Mac. Setting up all this env on mac os is real pain compared to Docker experience. Install VirtualBox from cask, install Vagrant, install chefdk. Wait while it will download image for centos, install some creepy vbox addons for proper mounting of host folders (what?), wait while all this stuff will spin up. Didn't liked it.

1. Didn't figured how to properly use chef template variables in Vagrant. That's why I have two identical apache recipes.

2. VM's for apache are only have single difference, thus, it should be possible to configure them as template and then use paramterization?

3. Virtual host names for apache hosts are hardcoded and not taken from Vagrantfile. Didn't figured out how to do this in reasonable time.

4. IP's for haproxy backend hardcoded, but should be passed dynamically from Vagrantfile.

5. Auth should be added for haproxy-stats.

6. Security didn't configured at all. No iptables/ufw, everything is open.

7. Don't know is checking in a cookbooks into the repo is a good practice. Perhaps no?

8. Custom cookbooks are lay in the same place where generic cookbooks have a rest. Doesn't look good for me.

9. TZ for Jenkins will be default.

10. Rubocop should be added to check recipes quality, as well as tests.

11. LB IP is hardcoded to Jenkins job but it shouldn't