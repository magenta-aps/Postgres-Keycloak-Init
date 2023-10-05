# SPDX-FileCopyrightText: Magenta ApS
#
# SPDX-License-Identifier: MPL-2.0
FROM hashicorp/terraform:1.6.0@sha256:31d726f53451d156fc9cf252d1e3985af204d70e1ee5cff7305af123162ba79a

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
