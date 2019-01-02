# SSH ldap+pam+ssh

## @edt Sergi Muñoz Carmona ASIX M06 2018-2019

Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)

ASIX M06-ASO Escola del treball de barcelona

### Imatge

* **sergimc/hostpam:18ssh** Servidor PAM que l'utilitzarem per connectar-nos via ssh al servidor ssh mitjançant usuaris LDAP i locals.
Requereix de l'ús d'un servidor ldap, hostpam i ssh.


#### Execució

```
docker run --rm --name host --hostname host --network netssh --privileged -it sergimc/hostpam:18ssh

```

#### Exemple en el hostpam connectant usuari ldap i local via ssh.
```
[root@host docker]# ssh pere@172.19.0.4
The authenticity of host '172.19.0.4 (172.19.0.4)' can't be established.
ECDSA key fingerprint is SHA256:fTqApouvRlbIlBgfMaoLqUbm4VradotAMFGn3lP+7os.
ECDSA key fingerprint is MD5:04:cd:77:90:57:51:d9:3e:67:6c:75:65:98:50:65:10.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.19.0.4' (ECDSA) to the list of known hosts.
pere@172.19.0.4's password: 
Creating directory '/tmp/home/pere'.

[pere@sshd ~]$ pwd
/tmp/home/pere

[pere@sshd ~]$ ssh local01@172.19.0.4
The authenticity of host '172.19.0.4 (172.19.0.4)' can't be established.
ECDSA key fingerprint is SHA256:fTqApouvRlbIlBgfMaoLqUbm4VradotAMFGn3lP+7os.
ECDSA key fingerprint is MD5:04:cd:77:90:57:51:d9:3e:67:6c:75:65:98:50:65:10.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.19.0.4' (ECDSA) to the list of known hosts.
local01@172.19.0.4's password: 

[local01@sshd ~]$ pwd
/home/local01

```



