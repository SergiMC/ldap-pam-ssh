# LDAP
## @edt Sergi Muñoz Carmona ASIX M06-ASO Curs 2018-2019

### Imatge LDAP en Dockerhub:
Podeu trobar les imatges docker al Dockerhub de [sergimc](https://hub.docker.com/u/sergimc/)
* **ldap:** [ldap ssh](https://cloud.docker.com/repository/docker/sergimc/ldapssh)

ASIX M06-ASO Escola del treball de barcelona

* **ldapssh:18base**  servidor ldap amb la base la dades dc=edt,dc=org.
Per posar en funcionament aquest model només es necessita un servidor ldap.


#### Execució

```
docker run --rm --name ldap --hostname ldap --network netssh -d sergimc/ldapssh:18base

```


