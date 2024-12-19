# SPDX-FileCopyrightText: Magenta ApS
#
# SPDX-License-Identifier: MPL-2.0
FROM hashicorp/terraform:1.10.3@sha256:460267841b38628514b75c6b0eb1cebb2d2fb5d6b596087a9c277551c801e5f1

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
