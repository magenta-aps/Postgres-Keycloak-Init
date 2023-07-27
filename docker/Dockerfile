# SPDX-FileCopyrightText: Magenta ApS
#
# SPDX-License-Identifier: MPL-2.0
FROM hashicorp/terraform:1.5.4@sha256:59e3356a9ebc05e73d6bf89d2ae8a05372024c3971064b199708afb4b5d19e4e

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
