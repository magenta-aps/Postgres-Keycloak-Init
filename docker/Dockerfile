ARG POSTGRES_VERSION

FROM postgres:${POSTGRES_VERSION} as production

LABEL org.opencontainers.image.title="Postgres Keycloak OS2mo" \
  org.opencontainers.image.description="A docker image containing Postgres initializer code for Keycloak needs." \
  org.opencontainers.image.vendor="Magenta ApS" \
  org.opencontainers.image.licenses="MPL-2.0" \
  org.opencontainers.image.source="https://git.magenta.dk/rammearkitektur/postgres-keycloak-os2mo"

COPY docker-entrypoint.sh /usr/local/bin/
COPY setup_common.sh /usr/local/bin/
COPY setup_keycloak.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["exit"]
