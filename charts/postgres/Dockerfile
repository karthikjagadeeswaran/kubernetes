# syntax=docker/dockerfile:1
FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

# RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update

# Install all dependencies
RUN apt-get install -y wget

RUN apt-get install gnupg2 software-properties-common curl git unzip -y

# Import the repository signing key:
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Update the package lists:
RUN apt-get update

# Install the latest version of PostgreSQL.
# If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
RUN apt-get -y install postgresql-12

# add timescaledb repo to container
RUN add-apt-repository ppa:timescale/timescaledb-ppa -y

# install timescaledb
RUN apt-get install timescaledb-postgresql-12 -y

# configure timescaledb
RUN timescaledb-tune --quiet --yes

RUN psql -V

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
RUN    /etc/init.d/postgresql start &&\
    psql --command "alter user postgres with password 'postgres';"

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/12/main/pg_hba.conf

# # # And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf

# # Expose the PostgreSQL port
EXPOSE 5432

# # Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# RUN /etc/init.d/postgresql stop

# RUN sleep 5

# CMD /etc/init.d/postgresql start

CMD ["/usr/lib/postgresql/12/bin/postgres", "-D", "/var/lib/postgresql/12/main", "-c", "config_file=/etc/postgresql/12/main/postgresql.conf"]

# RUN systemctl stop postgresql.service

# RUN systemctl status postgresql.service

# RUN systemctl start postgresql.service

# # Set the default command to run when starting the container
# CMD ["/usr/lib/postgresql/9.5/bin/postgres", "-D", "/var/lib/postgresql/9.5/main", "-c", "config_file=/etc/postgresql/9.5/main/postgresql.conf"]

# FROM ubuntu

# RUN apt-get update

# RUN apt-get install -y python python-pip wget

# RUN pip install Flask

# COPY systemctl /bin/

# ADD server.py /home/hello.py

# WORKDIR /home

# RUN mkdir /etc/postgresql

# RUN mkdir /var/lib/postgresql

# COPY ./etc/postgresql/ /etc/postgresql/

# COPY ./var/lib/postgresql/ /var/lib/postgresql/

# COPY postgresql.service /usr/lib/systemd/system/

# COPY postgresql@.service /usr/lib/systemd/system/

# COPY systemctl /bin/

# COPY pg_ctlcluster /usr/bin/

# COPY true /bin/

# COPY psql /bin/

# EXPOSE 5432

# CMD [ "/bin/systemctl start /usr/lib/systemd/system/postgresql.service" ]
