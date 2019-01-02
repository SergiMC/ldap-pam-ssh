#! /bin/bash
# @edt Sergi Muñoz ASIX M06 2018-2019
# startup.sh (Pràctica SSH)
# -------------------------------------

/opt/docker/install.sh && echo "Install Ok"
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"
/usr/sbin/sshd && echo "sshd Ok"
/bin/bash
