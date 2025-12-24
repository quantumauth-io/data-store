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

-- Grant ownership and privileges
ALTER DATABASE "quantumauth-db" OWNER TO quantum_auth_service;
GRANT ALL PRIVILEGES ON DATABASE "quantumauth-db" TO quantum_auth_service;

-- Switch to application database
\connect "quantumauth-db";

-- Ensure app can create tables / migrations
ALTER SCHEMA public OWNER TO quantum_auth_service;
GRANT USAGE, CREATE ON SCHEMA public TO quantum_auth_service;