# Makefile para tareas comunes del proyecto

.PHONY: up down logs ps psql pgadmin restart clean

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

ps:
	docker compose ps

psql:
	@docker exec -it qa_sql_postgres psql -U qa_user -d qa_practice

pgadmin:
	@echo "Abrir http://localhost:5050 (admin@local.com / admin)"

restart:
	docker compose restart

clean:
	docker compose down -v --remove-orphans
