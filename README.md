# ansible-samba-ad-dc


this ansible script installs Samba AD on debian buster, with:
  - bind9

Prepare plain debian buster instance
------------

  - install tasksel
  - add your ssh key to the instance
  - allow ssh root login
  - start ssh service

Modify the project to fit your needs
------------

smb.conf is configured to use the AD backend.
Therefore we need 

  - uidNumber
  - gidNumber

for each new user.

Furthermore there is a posibility to place a powershell login-script <username>.ps1 for each user at:

  - /var/lib/samba/sysvol/solarsystem.mind-galaxy.net/scripts

Samba is preconfigured to set roaming profiles for new users.
Just set the parameter, when creating users

Example of creating a new user:

```bash
samba-tool user create test --surname='test' --given-name='user' --profile-path='\\\\{{ vars_name_sambamember }}\\profiles\\test' --home-drive='H:' --home-directory='\\\\{{ vars_name_sambamember }}\\users\\test' --script-path='login.bat' --nis-domain={{ vars_workgroup }} --login-shell='/bin/bash/' --unix-home='/home/test' --uid-number=10010 --gid-number={{ vars_DomainUsersGroup_gid }} s3cr3tPWforTEST
```

Before you can use this project, you habe to set your configs in:
  - hosts
  - group_vars/homeserver/vars.yml
  - group_vars/homeserver/vault.yml

secure yourself and encrypt the vault.yml:
  - ansible-vault encrypt group_vars/homeserver/vault.yml

Build your own Samba-ad-dc server
------------

finaly run:
  - ansible-playbook -i hosts domaincontroller.yaml --ask-vault-pass

