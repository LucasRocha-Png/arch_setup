#!/bin/bash
# Script de Deploy - Framework de Engenharia (Frappe Ecosystem)
# Desenvolvido para rodar em Arch Linux (Atualizado para Single Containerfile)

set -e

echo "======================================================="
echo " Iniciando deploy do Framework de Engenharia           "
echo "======================================================="

echo -e "\n[1/7] Verificando dependências do Arch Linux..."
sudo pacman -S --needed docker docker-compose docker-buildx git jq
sudo systemctl enable --now docker

DIR_NAME="frappe_engenharia"
echo -e "\n[2/7] Preparando diretório base ($DIR_NAME)..."
if [ -d "$DIR_NAME" ]; then
    echo "Encontrada uma tentativa anterior. Limpando..."
    sudo rm -rf "$DIR_NAME"
fi
git clone https://github.com/frappe/frappe_docker.git "$DIR_NAME"
cd "$DIR_NAME"

echo -e "\n[3/7] Configurando o ecossistema (apps.json)..."
cat <<EOF > apps.json
[
  {"app_name": "erpnext", "repo": "https://github.com/frappe/erpnext", "branch": "version-15"},
  {"app_name": "drive", "repo": "https://github.com/frappe/drive", "branch": "version-15"},
  {"app_name": "insights", "repo": "https://github.com/frappe/insights", "branch": "version-15"},
  {"app_name": "gameplan", "repo": "https://github.com/frappe/gameplan", "branch": "main"},
  {"app_name": "wiki", "repo": "https://github.com/frappe/wiki", "branch": "version-15"},
  {"app_name": "lms", "repo": "https://github.com/frappe/lms", "branch": "version-15"},
  {"app_name": "crm", "repo": "https://github.com/frappe/crm", "branch": "version-15"},
  {"app_name": "helpdesk", "repo": "https://github.com/frappe/helpdesk", "branch": "main"},
  {"app_name": "raven", "repo": "https://github.com/frappe/raven", "branch": "version-15"},
  {"app_name": "print_designer", "repo": "https://github.com/frappe/print_designer", "branch": "main"}
]
EOF

echo -e "\n[4/7] Localizando arquivo de compilação unificado..."
# Procura pelo novo formato (Containerfile ou Dockerfile na pasta custom)
CUSTOM_FILE=$(find . -not -path '*/\.git/*' \( -name 'Containerfile' -o -name 'Dockerfile' \) | grep custom | head -n 1)

if [ -z "$CUSTOM_FILE" ]; then
    echo "Erro fatal: Arquivo de compilação customizado não encontrado."
    exit 1
fi
echo "-> Arquivo mapeado: $CUSTOM_FILE"

echo -e "\n[5/7] Compilando as imagens via multi-stage (Isso vai demorar vários minutos)..."
export APPS_JSON_BASE64=$(base64 -w 0 apps.json)

echo "--- Construindo Worker (Backend) ---"
docker buildx build \
  --target=backend \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=version-15 \
  --build-arg=PYTHON_VERSION=3.11 \
  --build-arg=NODE_VERSION=18 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=frappe-engenharia-worker:latest \
  --file=$CUSTOM_FILE .

echo "--- Construindo Nginx (Frontend) ---"
docker buildx build \
  --target=frontend \
  --build-arg=FRAPPE_BRANCH=version-15 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=frappe-engenharia-nginx:latest \
  --file=$CUSTOM_FILE .

echo -e "\n[6/7] Subindo a infraestrutura de containers..."
cat <<EOF > .env
FRAPPE_VERSION=version-15
WORKER_IMAGE=frappe-engenharia-worker:latest
NGINX_IMAGE=frappe-engenharia-nginx:latest
DB_PASSWORD=admin
ROUTER=traefik
EOF

docker compose -f pwd.yml up -d

echo "Aguardando 15 segundos para inicialização segura do MariaDB..."
sleep 15

SITE_NAME="tesla.localhost"
echo -e "\n[7/7] Configurando o banco de dados e instalando módulos no site: $SITE_NAME..."

docker compose -f pwd.yml exec backend bench new-site $SITE_NAME \
  --admin-password=admin \
  --install-app erpnext \
  --install-app drive \
  --install-app insights \
  --install-app gameplan \
  --install-app wiki \
  --install-app lms \
  --install-app crm \
  --install-app helpdesk \
  --install-app raven \
  --install-app print_designer

echo "======================================================="
echo " Deploy Finalizado com Sucesso!                        "
echo "                                                       "
echo " Acesse localmente: http://$SITE_NAME                  "
echo " Usuário: Administrator                                "
echo " Senha:   admin                                        "
echo "======================================================="
