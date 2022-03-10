# SPDX-FileCopyrightText: Magenta ApS
#
# SPDX-License-Identifier: MPL-2.0
terraform {
  backend "pg" {
    schema_name = "terraform_state_postgres_keycloak_init"
  }
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.15.0"
    }
  }
}

# Connection parameters
variable "POSTGRES_HOST" {
  type        = string
  description = "PostgreSQL hostname"
}
variable "POSTGRES_PORT" {
  type        = number
  default     = 5432
  description = "PostgreSQL host port"
}
variable "POSTGRES_SSL" {
  type    = string
  default = "require"
}

variable "POSTGRES_USER" {
  type    = string
  default = "postgres"
}
variable "POSTGRES_PASSWORD" {
  type        = string
  sensitive   = true
  description = "PostgreSQL user password"
}

# Database parameters
variable "KEYCLOAK_DB_NAME" {
  type    = string
  default = "keycloak"
}
variable "KEYCLOAK_DB_USER" {
  type    = string
  default = "keycloak"
}
variable "KEYCLOAK_DB_PASSWORD" {
  type      = string
  sensitive = true
}

provider "postgresql" {
  host     = var.POSTGRES_HOST
  port     = var.POSTGRES_PORT
  username = var.POSTGRES_USER
  password = var.POSTGRES_PASSWORD
  sslmode  = var.POSTGRES_SSL
}

resource "postgresql_role" "keycloak_user" {
  name     = var.KEYCLOAK_DB_USER
  login    = true
  password = var.KEYCLOAK_DB_PASSWORD
}

resource "postgresql_database" "keycloak_db" {
  name  = var.KEYCLOAK_DB_NAME
  owner = postgresql_role.keycloak_user.id
}

resource "postgresql_grant" "keycloak_grant" {
  database    = postgresql_database.keycloak_db.id
  role        = postgresql_role.keycloak_user.id
  object_type = "database"
  privileges = ["CREATE", "CONNECT", "TEMPORARY"]  # i.e. "ALL"
}
