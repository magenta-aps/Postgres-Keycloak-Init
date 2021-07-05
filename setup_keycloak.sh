#!/usr/bin/env bash
set -e

check_keycloak_variables() {
    if [ -n "$KEYCLOAK_DB_NAME" ]; then
        true "${KEYCLOAK_DB_USER:?KEYCLOAK_DB_USER is unset. Error!}"
        true "${KEYCLOAK_DB_PASSWORD:?KEYCLOAK_DB_PASSWORD is unset. Error!}"
    fi
}

setup_keycloak_db() {
    echo "Ensure keycloak db user exists"
    if ! check_user_exists ${KEYCLOAK_DB_USER}; then
        echo "Sessions db user does not exist, creating:"
        psql ${PSQL_ARGS} --dbname=postgres -c "CREATE USER ${KEYCLOAK_DB_USER} WITH ENCRYPTED PASSWORD '${KEYCLOAK_DB_PASSWORD}';"
    fi
    echo ""
    psql ${PSQL_ARGS} --dbname=postgres -c "GRANT ${KEYCLOAK_DB_USER} TO postgres;"

    echo "Ensure keycloak db database exists"
    if ! check_db_exists ${KEYCLOAK_DB_NAME}; then
        echo "Sessions db database does not exist, creating:"
        psql ${PSQL_ARGS} --dbname=postgres -c "CREATE DATABASE ${KEYCLOAK_DB_NAME} OWNER ${KEYCLOAK_DB_USER};"
    fi
    echo ""

    echo "Setting up keycloak db database privileges and settings:"
    psql ${PSQL_ARGS} --dbname=postgres -c "GRANT ALL PRIVILEGES ON DATABASE ${KEYCLOAK_DB_NAME} TO ${KEYCLOAK_DB_USER};"
    echo ""
}

ensure_keycloak_db() {
    if [ -n "$KEYCLOAK_DB_NAME" ]; then
        echo "Starting keycloak db database configuration."
        setup_keycloak_db
    else
        echo "Skipping creation of keycloak db database configuration."
    fi
    echo ""
}
