# SPDX-FileCopyrightText: Magenta ApS
#
# SPDX-License-Identifier: MPL-2.0
FROM hashicorp/terraform:1.9.6@sha256:3cd3444b117af80bed6aebe946a14f6087f1b69b09b0a139ab801addea4a673e

LABEL org.opencontainers.image.title="Postgres Keycloak OS2mo" \
  org.opencontainers.image.description="A docker image containing Postgres initializer code for Keycloak needs." \
  org.opencontainers.image.vendor="Magenta ApS" \
  org.opencontainers.image.licenses="MPL-2.0" \
  org.opencontainers.image.source="https://git.magenta.dk/rammearkitektur/postgres-keycloak-os2mo"

WORKDIR /app
COPY main.tf .
COPY .terraform.lock.hcl .
COPY run.sh .
ENTRYPOINT [ "sh", "run.sh" ]
