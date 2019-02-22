# SSH ldap+pam+ssh

## @edt Sergi Muñoz Carmona ASIX M06 2018-2019

Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)

### Imatges en dockerhub:
* **ldap: [ldap ssh](https://cloud.docker.com/repository/docker/sergimc/ldapssh).
* **hostpam: [hostpam](https://cloud.docker.com/repository/docker/sergimc/hostpam) amb tag: 18ssh.

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



