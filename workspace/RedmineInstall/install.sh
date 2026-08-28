#!/bin/bash
# Script para INSTALAR todo o ecossistema Redmine PLM/ERP do ZERO.
# Basta criar uma pasta vazia, colocar este arquivo dentro, e rodá-lo!

echo "=========================================="
echo " Instalador Automatizado: Redmine PLM/ERP "
echo "=========================================="

echo "[1/4] Criando arquivos de ambiente (Dockerfile e docker-compose.yml)..."

cat << 'EOF' > docker-compose.yml
services:
  redmine:
    build: .
    restart: always
    ports:
      - "3000:3000"
    environment:
      REDMINE_DB_POSTGRES: postgres
      REDMINE_DB_USERNAME: redmine
      REDMINE_DB_PASSWORD: redmine_password
      REDMINE_DB_DATABASE: redmine
      REDMINE_SECRET_KEY_BASE: supersecretkeybase_producao
      REDMINE_PLUGINS_MIGRATE: 1
    volumes:
      - redmine_data:/usr/src/redmine/files
      - ./plugins:/usr/src/redmine/plugins
    depends_on:
      - postgres

  postgres:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_USER: redmine
      POSTGRES_PASSWORD: redmine_password
      POSTGRES_DB: redmine
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  redmine_data:
  postgres_data:
EOF

cat << 'EOF' > custom-entrypoint.sh
#!/bin/bash
chmod -R o-w /usr/local/bundle || true
chmod +t /usr/local/bundle/extensions/x86_64-linux/* || true
exec /docker-entrypoint.sh "$@"
EOF
chmod +x custom-entrypoint.sh

cat << 'EOF' > Dockerfile
FROM redmine:latest
USER root
RUN apt-get update && apt-get install -y \
    libxapian-dev uuid-dev xpdf poppler-utils antiword catdoc build-essential zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
RUN rm -rf /usr/local/bundle/gems/ox-2.14.29 || true
RUN rm -rf /usr/local/bundle/gems/xapian-ruby-1.4.27 || true
RUN rm -rf /usr/local/bundle/extensions/x86_64-linux/4.0.0/xapian-ruby-1.4.27 || true
COPY custom-entrypoint.sh /custom-entrypoint.sh
RUN chmod +x /custom-entrypoint.sh
RUN echo "gem 'pstore'" >> /usr/src/redmine/Gemfile.local
ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
EOF

echo "[2/4] Criando diretório de plugins e baixando o pacote PLM..."
mkdir -p plugins
cd plugins

# Kanban/Agile
git clone https://github.com/jirutka/redmine_agile.git
# ERPmine (Timesheet, Manufatura, BOM)
git clone https://github.com/dhanasingh/redmine_wktime.git
# DMSF (Gestão de Documentos CAD/PDF)
git clone https://github.com/danmunn/redmine_dmsf.git
# Correção do model_object para Rails 7
find redmine_dmsf/app/controllers -name "*.rb" -exec sed -i 's/^\( *\)model_object \(.*\)/\1self.model_object = \2/' {} +

# Checklists de Qualidade
git clone https://github.com/jirutka/redmine_checklists.git


cd ..

echo "[3/4] Construindo o contêiner customizado e subindo os serviços..."
docker compose up -d --build

echo "=========================================="
echo "[4/4] Finalizado! O sistema fará as migrações automaticamente por baixo dos panos."
echo "Como são muitos plugins, o primeiro boot (após baixar as imagens) leva cerca de 2 minutos."
echo "Após isso, acesse: http://localhost:3000 (admin / admin)"
echo "=========================================="
