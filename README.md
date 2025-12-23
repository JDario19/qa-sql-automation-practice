# QA SQL Automation Practice

This repository is a complete, self-contained guide to set up PostgreSQL locally with Docker, connect with pgAdmin, create SQL schemas, and prepare an SQL project for QA Automation / SDET roles.

---

## 🎯 Purpose

- Practice SQL using a real database
- Run PostgreSQL locally with Docker
- Use pgAdmin as a professional database UI
- Version schemas and queries on GitHub
- Prepare a portfolio-ready project

---

## 🧰 Technologies

- PostgreSQL 16
- pgAdmin 4
- Docker Desktop (macOS)
- SQL
- Git & GitHub
- Visual Studio Code

---

## Project structure

qa-sql-automation-practice/
├── docker-compose.yml
├── README.md
├── schema/
│   └── 01_create_tables.sql
├── seeds/
└── queries/
    ├── basic/
    ├── intermediate/
    └── advanced/

---

## How to use this repository

I split the instructions into two flows for clarity:

1) When you have nothing configured (from scratch)
2) When you've already cloned the repository (quick setup)

---

A — If you have nothing configured (from scratch)

Follow these steps if you start from a machine without Docker or any database installed.

1. Install Docker Desktop (macOS)
   - Visit: https://www.docker.com/products/docker-desktop/
   - Download the version for your CPU (Intel or Apple Silicon)
   - Install and open Docker Desktop. Wait until it shows "Docker Desktop is running".

2. Verify Docker

```bash
docker --version
```

3. Create the project folder (optional)

```bash
cd ~/Documents/GitHub
mkdir -p qa-sql-automation-practice
cd qa-sql-automation-practice
```

4. Create files and folders (if you haven't already)

```bash
mkdir -p schema seeds queries/{basic,intermediate,advanced}
touch docker-compose.yml README.md .gitignore
```

5. Open in Visual Studio Code

```bash
code .
```

(If you don't have the `code` command, open VS Code → Cmd+Shift+P → "Shell Command: Install 'code' command in PATH")

6. Configure Docker Compose

- Open `docker-compose.yml` and review environment variables (user, password and database name).

7. Start the containers

```bash
docker compose up -d
```

8. Verify containers

```bash
docker ps
```

You should see containers like `qa_sql_postgres` and `qa_sql_pgadmin`.

9. Open pgAdmin in the browser

- URL: http://localhost:5050
- Email: `admin@local.com`
- Password: `admin`

10. Connect pgAdmin to PostgreSQL

- In pgAdmin → Right-click Servers → Register → Server
  - General: Name = QA PostgreSQL
  - Connection:
    - Host name/address: `postgres`
    - Port: `5432`
    - Maintenance database: `qa_practice`
    - Username: `qa_user`
    - Password: `qa_pass`
    - Check "Save password"

Note: the host is `postgres` because containers share the Docker network, not `localhost`.

11. Create tables (example)

In pgAdmin → select the `qa_practice` database → Query Tool → paste and run the SQL from `schema/01_create_tables.sql` or use this example:

```sql
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  full_name VARCHAR(150) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
```

12. Save the schema in the repository

- Create `schema/01_create_tables.sql` and add your CREATE TABLE statements there for versioning.

13. Initialize Git and first commit

```bash
git init
git add .
git commit -m "Initial Dockerized PostgreSQL setup"
```

14. Create the repository on GitHub (via web)

- Suggested name: `qa-sql-automation-practice`
- Public
- DO NOT add README or .gitignore via the web UI (you already have them locally)

15. Push to remote

```bash
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/qa-sql-automation-practice.git
git push -u origin main
```

---

B — If you've already cloned the repository (quick setup)

If you already have the repository on your machine (cloned), these are the minimum steps to start and test everything.

1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/qa-sql-automation-practice.git
cd qa-sql-automation-practice
```

2. Verify Docker is installed and running

```bash
docker --version
open -a Docker
```

3. Start services

```bash
docker compose up -d
```

4. Verify containers

```bash
docker ps
```

5. Open pgAdmin: http://localhost:5050 (admin@local.com / admin)
6. Register the server in pgAdmin with the same values: host `postgres`, database `qa_practice`, user `qa_user`, password `qa_pass`.
7. Run the SQL from `schema/01_create_tables.sql` (open the file and copy/paste into Query Tool) or use the GUI to apply the script.

8. If you make changes, commit and push:

```bash
git add .
git commit -m "Describe change"
git push
```

---

If you want, I can:
- Review and improve `docker-compose.yml` to ensure it matches the instructions.
- Add a startup script (Makefile / npm script) to simplify commands.

End.
