# vagrant-test

## Task description

1. Create vagrant file having 4 linux machines. (centos)

2. Machines should be provisioned automatically, with chef(preferably, some shell/ruby is ok too) and at the end of "vagrant up" command it should work as following:

- 2 apache servers reporting “I’m server 1”/"I’am server 2” on default page.
- 1 HA proxy balancing 2 apache servers.
- Last machine should run Jenkins server with 1 job, which sends GET towards HA every hour, passing if "server 1”is active , failing if “server 2” is active. 
- Job should run every hour in nights only, from 00:00 to 06:00
