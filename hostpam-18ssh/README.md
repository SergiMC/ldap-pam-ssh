# SSH PAM
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
[root@host docker]# ssh pau@172.19.0.4 -p 1022
The authenticity of host '[172.20.0.4]:1022 ([172.20.0.4]:1022)' can't be established.
ECDSA key fingerprint is SHA256:AMbG8pBEoj6Ln1Who3y5Iyw9VUSUihRT2D1gJvu44iQ.
ECDSA key fingerprint is MD5:dd:25:66:5b:c9:8d:1b:34:d7:ba:f2:90:db:93:4e:25.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[172.20.0.4]:1022' (ECDSA) to the list of known hosts.
pau@172.20.0.4's password: 
Creating directory '/tmp/home/pau'.

[pau@sshd ~]$ pwd
/tmp/home/pau

[root@host pam.d]# ssh local01@172.19.0.4 -p 1022
local01@172.20.0.4's password: 

[local01@sshd ~]$ pwd
/home/local01

```



