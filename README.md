# gosu-entrypoint
Simple shell script to set user and optionally chown paths leveraging gosu

## Usage
Script is intended for use in a dockerfile that has gosu installed. The script automates changing directory ownership
and switching to that user:group prior to docker CMD execution. This is especially useful when dealing with volume mounts
that are owned by users other than those configured during Docker image build.

The following Dockerfile snippet is an example of integrating the script:

```
# Specify any standard chown format (uid, uid:gid), default to root:root
ENV GOSU_USER 0:0

# Specify any space delimited directories that should be chowned to GOSU_USER
#ENV GOSU_CHOWN /tmp

COPY gosu-entrypoint.sh /

RUN chmod +x /gosu-entrypoint.sh

ENTRYPOINT ["/gosu-entrypoint.sh"]
```

This can then be overridden using the following docker run command syntax:

```
docker run -e GOSU_USER=123:456 -e GOSU_CHOWN=/tmp gosu-entry sh -c 'ls /tmp && id'
```
