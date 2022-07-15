# Copy the conf folder to the container

kubectl cp helm-openldap/conf openldap-openldap-stack-ha-0:/

``` execute the below commands on that container ```

cd /conf

## To adjust the SLAPD database access controls

ldapadd -Y EXTERNAL -H ldapi:/// -f update-mdb-acl.ldif

## To create the organization unit containers for storing users and their group information

ldapadd -Y EXTERNAL -H ldapi:/// -f user-ou.ldif

## To create a user called johndoe in our OpenLDAP database

ldapadd -Y EXTERNAL -H ldapi:/// -f johndoe.ldif

## To set/reset the password for the user

ldappasswd -H ldapi:/// -Y EXTERNAL -S "uid=johndoe,ou=people,dc=wims2,dc=plantsense,dc=ai"

## To verify user’s password

ldapwhoami -h ldap.kifarunix-demo.com -x -D "uid=johndoe,ou=people,dc=wims2,dc=plantsense,dc=ai" -W