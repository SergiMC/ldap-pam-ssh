# SSH ldap+pam+ssh

## @edt Sergi Muñoz Carmona ASIX M06 2018-2019

Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)

ASIX M06-ASO Escola del treball de barcelona

### Imatges:

* **sergimc/ldapssh:18base** Servidor ldap amb les dades de la base de dades dc=edt,dc=org Requereix de l'ús d'un 
servidor ldap.

* **sergimc/hostpam:18ssh** Servidor PAM que l'utilitzarem per connectar-nos via ssh al servidor ssh mitjançant usuaris LDAP i locals.
Requereix de l'ús d'un servidor ldap, hostpam i ssh.

* **sergimc/sshd:18server** Servidor SSH que l'utilitzarem per tal d'oferir connexions per usuaris LDAP i locals via SSH.
Requereix de l'ús d'un servidor ldap, hostpam i ssh.

### Arquitectura

Per implementar un host i connectar-nos amb usuaris unix  via ssh de un 
servidor de disc extern cal:

  * **netssh** Una xarxa propia per als containers implicats.

  * **sergimc/ldapssh:18base** Un servidor ldap en funcionament amb els usuaris de xarxa.

  * **sergimc/hostpam:18ssh** Un servidor PAM per connectar-nos via ssh al servidor ssh mitjançant usuaris LDAP i locals.
  
  * **sergimc/sshd:18server** Un servidor SSH que l'utilitzarem per tal d'oferir connexions per usuaris LDAP i locals via SSH.

Contindrà:


    * *Usuaris unix* SSH requereix la existència de usuaris unix. Caldrà disposar dels usuaris unix,
	poden ser locals o de xarxa via LDAP.El servidor ssh ha d'estar configurat amb nscd i nslcd per
	poder accedir al ldap. Utilitzarem l'ordre getent per poder llistar tots els usuaris i grups de xarxa.
	Haurem de crear els usuaris locals dins del servidor SSH.

    * *homes* Es necessita que els usuaris tinguin un directori home. Els usuaris unix local ja en tenen quan es creen
	,però els usuaris LDAP no. Cal crear el directori home dels usuaris ldap , utilitzarem el modul pam_mkhomedir.so .


#### Execució

```
docker network create netssh

docker run --rm --name ldap --hostname ldap --network netssh -d sergimc/ldapssh:18base

docker run --rm --name host --hostname host --network netssh --privileged -it sergimc/hostpam:18ssh

docker run --rm --name sshd --hostname sshd --network netssh -it sergimc/sshd:18server
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



