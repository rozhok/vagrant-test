# vagrant-test

## Exam

1. Create vagrant file having 4 linux machines. (centos)

2. Machines should be provisioned automatically, with chef(preferably, some shell/ruby is ok too) and at the end of "vagrant up" command it should work as following:

- 2 apache servers reporting “I’m server 1”/“I’am server 2” on default page.
- 1 HA proxy balancing 2 apache servers.
- Last machine should run Jenkins server with 1 job, which sends GET towards HA every hour, passing if "server 1”is active , failing if “server 2” is active. 
- Job should run every hour in nights only, from 00:00 to 06:00 

## Solution

### Assumptions

- securing things is not required and out of scope
- HTTPS is out of scope

### Prerequisites

- `vagrant plugin install vagrant-berkshelf`
- VirtualBox as Vagrant provider
- `vagrant plugin install vagrant-vbguest`

### Some details

0. VirtualBox Vagrant provider is used and hardcoded into Vagrantfile.
1. LB running on [http://192.168.100.103](http://192.168.100.103). Round-robin balancing is used.
2. Jenkins running on [http://192.168.100.104:8080](http://192.168.100.104:8080)
3. Solution cookbooks are placed in `cookbooks/apache-blue`, `cookbooks/apache-green`, `cookbooks/haproxy-lb` and `cookbooks/jenkins-nice` respectively. ~~I've should used Berksfile for proper dependency management but I've realised it when I've done everything.~~

## Notes and code smells

0. I was unable to quickly setup virtualbox on a remote Debian box so I've tried a Docker but Docker provider for vagrant didn't worked out-of-the-box so I went to installing all stuff on my Mac. Setting up all this env on mac os is real pain compared to Docker experience. Install VirtualBox from cask, install Vagrant, install chefdk. Wait while it will download image for centos, install some creepy vbox addons for proper mounting of host folders (what?), wait while all this stuff will spin up. Didn't liked it.

1. Didn't figured how to properly use chef template variables in Vagrant. That's why I have two identical apache recipes.

2. VM's for apache are only have single difference, thus, it should be possible to configure them as template and then use paramterization?

3. Virtual host names for apache hosts are hardcoded and not taken from Vagrantfile. Didn't figured out how to do this in reasonable time.

4. IP's for haproxy backends hardcoded, but should be passed dynamically from Vagrantfile.

5. Auth should be added for haproxy-stats.

6. Security didn't configured at all. No iptables/ufw, everything is open.

7. ~~Don't know is checking in a cookbooks into the repo is a good practice. Perhaps no?~~

8. ~~Custom cookbooks are lay in the same place where generic cookbooks have a rest. Doesn't look good for me.~~

9. TZ for Jenkins will be default.

10. Rubocop should be added to check recipes quality, as well as tests.

11. LB IP is hardcoded to Jenkins job but it shouldn't.

12. Jenkins password is hardcoded to cookbook.

13. I've spent around of 5 hours of doing this, most of the time figuring out how to properly make Chef and Vagrant work together and waiting for `vagrant reload` and `vagrant provision` on my old laptop. I guess it could be done in way way easier using docker-compose. Cookbooks and integration between Chef and Vagrant are very poorly documented, as for me. They may be good for power users, but not for newcomers who have no idea of how to use those "recipes".

14. Jenkins is not secured at all.

15. Network design is poor.

16. Jenkins plugin installation took a huge time and proved to be errorneus sometimes ([https://github.com/chef-cookbooks/jenkins/issues/534](https://github.com/chef-cookbooks/jenkins/issues/534) and related issues)

17. Vagrant boxes are not ephemeral (or I didn't figured how to make them so), and if installation (for Jenkins) was screwed, you have to do `vagrant reload` and `vagrant provision` again and again. Took a huge chunk of time just to watch at the outputs.

18. LB IP hardcoded to Jenkins job xml. Templating could be used here.

19. Jenkins plugins list is hardcoded to the recipe because chef can't properly install plugins dependencies.