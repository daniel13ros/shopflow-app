##########################################################################################################################################################
# Follow the instructions below to set up a PostgreSQL database using Docker. This setup includes creating a persistent volume for data storage,         #
# a custom network for container communication, and running the PostgreSQL container with specific environment variables for database configuration.     #
##########################################################################################################################################################


# Creates a persistent volume named "postgres-data" to ensure database data is safely stored and won't be lost even if the container is removed
docker volume create postgres-data

# Lists all Docker volumes to verify that the "postgres-data" volume has been created successfully
docker volume ls

# Creates a custom Docker network named "postgres-network" to allow the PostgreSQL container to communicate with other containers that may be added in the future (e.g., application containers)
docker network create postgres-network

# Lists all Docker networks to confirm that the "postgres-network" has been created and is available for use
docker network ls

# Runs the PostgreSQL container in the background (-d), names it "postgres-db", attaches it to "postgres-network", maps the default port to the host (-p 5432:5432),
# mounts the persistent volume to save files internally (-v postgres-data:/var/lib/postgresql/data), sets a custom database user (-e POSTGRES_USER=admin),
# sets the database password (-e POSTGRES_PASSWORD=admin1234), and uses the official "postgres" image
docker run -d \
  --name postgres-db \
  --restart unless-stopped \
  --network postgres-network \
  -p 5432:5432 \
  -v postgres-data:/var/lib/postgresql/data \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=admin1234 \
  -e POSTGRES_DB=company-database \
  postgres:17

# Lists all Docker containers, including those that are running and those that have been stopped, to verify that the "postgres-db" container is up and running
docker ps -a

# Inspects the "postgres-db" container to view detailed information about its configuration, status, and resource usage, 
# which can be helpful for troubleshooting and ensuring that the container is set up correctly
docker inspect postgres-db


##########################################################################################################################################################
# pgAdmin is a popular open-source administration and development platform for PostgreSQL databases. It provides a graphical interface to manage and interact 
# with PostgreSQL databases, making it easier for users to perform tasks such as querying, designing schemas, and monitoring database performance. To set up pgAdmin 
# in a Docker container, you can use the following command:
# This command runs the pgAdmin container in detached mode, names it "pgadmin", maps the default pgAdmin port to the host, sets environment variables for 
# the default email and password, and uses the official "dpage/pgadmin4" image.
##########################################################################################################################################################

# After pgAdmin install , add new server with the following details:
# Name: My Company Local Database
# Host name/address: 127.0.0.1
# Port: 5432
# Username: admin
# Password: admin1234

# To access the PostgreSQL database container's shell, you can use the following command. 
# This allows you to interact with the container's file system and execute commands directly within the container environment.
docker exec -it postgres-db bash

# Once inside the container, you can use the psql command-line tool to connect to the PostgreSQL database.
# psql -U admin -d company-database

# After connecting to the database using psql, you can execute SQL commands to interact with the database. 
# For example, to retrieve all records from the "employees" table, you would use the following SQL command:
# SELECT * FROM employees;

# Check the persistence of data by exiting the container and then re-entering it. 
# You can do this by typing "exit" to leave the container, and then using the "docker exec" command again to access it.
# After re-entering the container, you can run the same psql command to connect to the database and verify that the data in the "employees" table is still present, 
# confirming that the persistent volume is working correctly.




