FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y ldap-utils && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY ldif/ /ldif/

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
