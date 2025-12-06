CREATE DATABASE IF NOT EXISTS quantum_auth;

CREATE USER IF NOT EXISTS quantum_auth_service;

GRANT ALL ON DATABASE quantum_auth TO quantum_auth_service WITH GRANT OPTION;

