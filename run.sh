#!/bin/sh
# SPDX-FileCopyrightText: Magenta ApS
#
# SPDX-License-Identifier: MPL-2.0

terraform init -backend-config="conn_str=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/postgres?sslmode=${POSTGRES_SSL}"

echo "" > args.tfvars

if [[ -n "${POSTGRES_HOST}" ]]; then
    echo "POSTGRES_HOST=\"${POSTGRES_HOST}\"" >> args.tfvars
fi
if [[ -n "${POSTGRES_PORT}" ]]; then
    echo "POSTGRES_PORT=${POSTGRES_PORT}" >> args.tfvars
fi
if [[ -n "${POSTGRES_SSL}" ]]; then
    echo "POSTGRES_SSL=\"${POSTGRES_SSL}\"" >> args.tfvars
fi
if [[ -n "${POSTGRES_USER}" ]]; then
    echo "POSTGRES_USER=\"${POSTGRES_USER}\"" >> args.tfvars
fi
if [[ -n "${POSTGRES_PASSWORD}" ]]; then
    echo "POSTGRES_PASSWORD=\"${POSTGRES_PASSWORD}\"" >> args.tfvars
fi

if [[ -n "${KEYCLOAK_DB_NAME}" ]]; then
    echo "KEYCLOAK_DB_NAME=\"${KEYCLOAK_DB_NAME}\"" >> args.tfvars
fi
if [[ -n "${KEYCLOAK_DB_USER}" ]]; then
    echo "KEYCLOAK_DB_USER=\"${KEYCLOAK_DB_USER}\"" >> args.tfvars
fi
if [[ -n "${KEYCLOAK_DB_PASSWORD}" ]]; then
    echo "KEYCLOAK_DB_PASSWORD=\"${KEYCLOAK_DB_PASSWORD}\"" >> args.tfvars
fi

terraform apply -auto-approve -input=false -var-file="args.tfvars"
