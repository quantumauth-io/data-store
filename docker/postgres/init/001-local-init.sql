-- Create application database
CREATE DATABASE "quantumauth-db";

-- Create application role (only if it does not exist)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT FROM pg_roles WHERE rolname = 'quantum_auth_service'
  ) THEN
    CREATE ROLE quantum_auth_service
      LOGIN
      PASSWORD 'local_dev_password';
  END IF;
END
$$;

-- Create Yeti role if it does not exist
DO $$
    BEGIN
        IF NOT EXISTS (
            SELECT FROM pg_roles WHERE rolname = 'yeti_app'
        ) THEN
            CREATE ROLE yeti_app
                LOGIN
                PASSWORD 'local_dev_password';
        END IF;
    END
$$;

DO $$
    BEGIN
        IF NOT EXISTS (
            SELECT FROM pg_roles WHERE rolname = 'climbing_app'
        ) THEN
            CREATE ROLE climbing_app
                LOGIN
                PASSWORD 'local_dev_password';
        END IF;
    END
$$;

-- Grant ownership and privileges
ALTER DATABASE "quantumauth-db" OWNER TO quantum_auth_service;
GRANT ALL PRIVILEGES ON DATABASE "quantumauth-db" TO quantum_auth_service;
GRANT CONNECT, CREATE ON DATABASE "quantumauth-db" TO yeti_app;
GRANT CONNECT, CREATE ON DATABASE "quantumauth-db" TO climbing_app;

-- Switch to application database
\connect "quantumauth-db";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Ensure app can create tables / migrations
ALTER SCHEMA public OWNER TO quantum_auth_service;
GRANT USAGE, CREATE ON SCHEMA public TO quantum_auth_service;

-- Create dedicated schema for Yeti
CREATE SCHEMA IF NOT EXISTS yeti AUTHORIZATION yeti_app;

-- Ensure Yeti app can use and manage its own schema
GRANT USAGE, CREATE ON SCHEMA yeti TO yeti_app;

-- Future-proof default privileges for objects created by yeti_app
ALTER DEFAULT PRIVILEGES FOR ROLE yeti_app IN SCHEMA yeti
    GRANT ALL ON TABLES TO yeti_app;

ALTER DEFAULT PRIVILEGES FOR ROLE yeti_app IN SCHEMA yeti
    GRANT ALL ON SEQUENCES TO yeti_app;

-- Create dedicated schema for Climbing.box
CREATE SCHEMA IF NOT EXISTS climbing AUTHORIZATION climbing_app;

GRANT USAGE, CREATE ON SCHEMA climbing TO climbing_app;

ALTER DEFAULT PRIVILEGES FOR ROLE climbing_app IN SCHEMA climbing
    GRANT ALL ON TABLES TO climbing_app;

ALTER DEFAULT PRIVILEGES FOR ROLE climbing_app IN SCHEMA climbing
    GRANT ALL ON SEQUENCES TO climbing_app;