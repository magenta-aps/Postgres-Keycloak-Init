# SPDX-FileCopyrightText: Magenta ApS
#
# SPDX-License-Identifier: MPL-2.0
FROM hashicorp/terraform:1.8.4@sha256:bf3358bfd052954ddc5b4ed033f9b5bfc1993e146f398a0adebd5dd622cbbca9

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
