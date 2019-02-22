# SSH ldap+pam+ssh

## @edt Sergi Muñoz Carmona ASIX M06 2018-2019

### Imatge SSH server en Dockerhub:
Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)
* **ssh:** [ssh server](https://cloud.docker.com/repository/docker/sergimc/sshd)

ASIX M06-ASO Escola del treball de barcelona

### Imatge

* **sergimc/sshd:18server** Servidor SSH que l'utilitzarem per tal d'oferir connexions per usuaris LDAP i locals via SSH.
Requereix de l'ús d'un servidor ldap, hostpam i ssh.


#### Execució

```
docker run --rm --name sshd --hostname sshd -p 1022 --network netssh -it sergimc/sshd:18server

```

### Configuració servidor SSH

-Fitxers:
	Per tal de poder connectar-nos amb usuaris ldap configurarem el server ssh amb els fitxers:
		-nslcd.conf
		-nsswitch.conf
		-ldap.conf

-En aquest cas, implementarem al servidor sshd una directiva de restricció d’accés tipus AllowUsers.

	Fitxer: /etc/ssh/sshd_config
	
Afegim al fitxer:

```
# Example of overriding settings on a per-user basis
#Match User anoncvs
#       X11Forwarding no
#       AllowTcpForwarding no
#       PermitTTY no
#       ForceCommand cvs server

AllowUsers pere local01 local02

```

Una altre manera d'implementar al servidor sshd una directiva de restricció, és amb el mòdul pam_access.so.
Per implementar-ho, hem de configurar el fitxer acces.conf 

-Fitxer:
	/etc/security/access.conf
	
Afegim al fitxer:

```
#Usuaris amb grup localgrp02 poden loguejar-se
- : localgrp02 : ALL
- : pere : ALL

```

Una vegada configurat el fitxer, anem al fitxer pam de sshd i afegim:


```
auth    required        pam_access.so
account required        pam_access.so accessfile=/etc/security/access.conf

```

	
Per últim, una altre manera d'implementar al servidor sshd una directiva de restricció és amb el mòdul pam_listfile.so.

Primer, creem un fitxer amb una llista de noms el qual en aquest cas, voldrem denegar l'accès:
	
	-El creem a /etc/userlist
	
	dins del fitxer posem: marta

Una vegada creat el fitxer, anem al fitxer pam de sshd i afegim el mòdul pam:


```
auth    required    pam_listfile.so onerr=fail item=user sense=deny file=/etc/userfile

```



#### Exemple en el hostpam connectant usuari ldap marta via ssh.
```
[root@sshd docker]# ssh marta@172.19.0.4 -p 1022
The authenticity of host '172.19.0.4 (172.19.0.4)' can't be established.
ECDSA key fingerprint is SHA256:fTqApouvRlbIlBgfMaoLqUbm4VradotAMFGn3lP+7os.
ECDSA key fingerprint is MD5:04:cd:77:90:57:51:d9:3e:67:6c:75:65:98:50:65:10.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.19.0.4' (ECDSA) to the list of known hosts.
marta@172.19.0.4's password: 
Permission denied, please try again.
marta@172.19.0.4's password: 


```



