#!/bin/bash
echo "================================================="
echo "       SISTEMA DE BACKUP DO REDMINE PLM"
echo "================================================="
echo "Escolha o tipo de backup:"
echo "1) Backup LEVE (Apenas Banco e Arquivos CAD - Ideal para Nuvem/Google Drive)"
echo "2) Backup COMPLETO (Sistema Inteiro - Ideal para migrar para outro PC/Orange Pi)"
echo "3) Sair"
read -p "Opção: " opcao

DATE=$(date +%Y-%m-%d)

if [ "$opcao" == "1" ]; then
    echo "Preparando arquivos para a nuvem..."
    mkdir -p Backup_Leve
    docker exec -t redmine-postgres-1 pg_dumpall -c -U redmine > Backup_Leve/banco_de_dados.sql
    docker cp redmine-redmine-1:/usr/src/redmine/files Backup_Leve/arquivos_anexos
    zip -r Backup_Redmine_GDrive_$DATE.zip Backup_Leve/ > /dev/null
    rm -rf Backup_Leve
    echo "SUCESSO! Arquivo 'Backup_Redmine_GDrive_$DATE.zip' gerado."

elif [ "$opcao" == "2" ]; then
    echo "Iniciando pacote completo de migração..."
    docker exec -t redmine-postgres-1 pg_dumpall -c -U redmine > backup_db.sql
    docker run --rm --volumes-from redmine-redmine-1 -v $(pwd):/backup ubuntu tar cf /backup/backup_files.tar /usr/src/redmine/files
    cd ..
    tar -czf Backup_Redmine_Migracao_$DATE.tar.gz Redmine/
    # Limpa os arquivos residuais
    rm Redmine/backup_db.sql Redmine/backup_files.tar
    echo "SUCESSO! Arquivo 'Backup_Redmine_Migracao_$DATE.tar.gz' gerado na Área de Trabalho (fora desta pasta)."

else
    echo "Cancelado."
    exit 0
fi
