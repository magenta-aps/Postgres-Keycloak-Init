#!/usr/bin/env bash
set -e

echo "Checking connection configuration variables"
true "${POSTGRES_HOST:?POSTGRES_HOST is unset. Error!}"
true "${POSTGRES_PASSWORD:?POSTGRES_PASSWORD is unset. Error!}"
if [ -z "${POSTGRES_PORT}" ]; then
    echo "'POSTGRES_PORT' not set, defaulting to '5432'"
    POSTGRES_PORT=5432
fi
if [ -z "${POSTGRES_USER}" ]; then
    echo "'POSTGRES_USER' not set, defaulting to 'postgres'"
    POSTGRES_USER=postgres
fi
echo ""
export PGPASSWORD=${POSTGRES_PASSWORD}

PSQL_ARGS=''
PSQL_ARGS="${PSQL_ARGS} --host=${POSTGRES_HOST}"
PSQL_ARGS="${PSQL_ARGS} --port=${POSTGRES_PORT}"
PSQL_ARGS="${PSQL_ARGS} --username=${POSTGRES_USER}"
# PSQL_ARGS="${PSQL_ARGS} --dbname postgres"
PSQL_ARGS="${PSQL_ARGS} -v ON_ERROR_STOP=1"
if [ -n "${POSTGRES_SSL}" ]; then
    PSQL_ARGS="${PSQL_ARGS} --set=sslmode=${POSTGRES_SSL}"
fi

source /usr/local/bin/setup_common.sh
source /usr/local/bin/setup_keycloak.sh

# Check database specific configurations
echo "Checking database configuration variables"
check_keycloak_variables
echo ""

# Check postgres connection
check_postgres_connection

# Check database configuration
echo "Ensuring databases exist"
ensure_keycloak_db
echo ""

# Update passwords
update_password() {
    if [ -n "$1" ]; then
        psql ${PSQL_ARGS} --dbname postgres -c "ALTER USER $2 WITH ENCRYPTED PASSWORD '$3'"
    fi
}
echo "Updating passwords"
update_keycloak "$DB_NAME" "$DB_USER" "$DB_PASSWORD"
echo ""
