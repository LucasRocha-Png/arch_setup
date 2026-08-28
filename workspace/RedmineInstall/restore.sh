#!/bin/bash
echo "================================================="
echo "       RESTAURANDO DADOS DO REDMINE"
echo "================================================="
echo "Certifique-se de que o sistema está rodando (docker compose up -d)"
echo "e que os arquivos backup_db.sql e backup_files.tar estão nesta pasta."
read -p "Deseja continuar e sobrescrever o sistema atual? (s/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    exit 1
fi

echo "[1/3] Restaurando Banco de Dados..."
cat backup_db.sql | docker exec -i redmine-postgres-1 psql -U redmine

echo "[2/3] Restaurando Arquivos e Documentos..."
docker run --rm --volumes-from redmine-redmine-1 -v $(pwd):/backup ubuntu bash -c "rm -rf /usr/src/redmine/files/* && tar xf /backup/backup_files.tar -C /"

echo "[3/3] Reiniciando servidor para aplicar alterações..."
docker compose restart redmine

echo "================================================="
echo "SUCESSO! O Redmine foi restaurado perfeitamente."
echo "================================================="
