#!/bin/bash

requirements=(
docker
docker-compose
)

../utils/pacman_ip.sh "${requirements[@]}"


log() {
    echo -e "\n[InvenTree Docker Install] $1"
}

INSTALL_DIR="${PWD}/inventree-docker"

if [ -d "$INSTALL_DIR" ]; then
    log "Diretório $INSTALL_DIR já existe. Usando este diretório!"
else
    log "Criando diretório de instalação em $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
fi

cd "$INSTALL_DIR" || exit 1

log "Baixando arquivos de configuração (docker-compose.yml, .env, Caddyfile)..."
curl -sO https://raw.githubusercontent.com/inventree/inventree/aa934214dae44c059690c6d9ef1fcf4ab0027cfd/contrib/container/docker-compose.yml
curl -sO https://raw.githubusercontent.com/inventree/inventree/aa934214dae44c059690c6d9ef1fcf4ab0027cfd/contrib/container/.env
curl -sO https://raw.githubusercontent.com/inventree/inventree/aa934214dae44c059690c6d9ef1fcf4ab0027cfd/contrib/container/Caddyfile

if [ ! -f "docker-compose.yml" ] || [ ! -f ".env" ] || [ ! -f "Caddyfile" ]; then
    log "Erro ao baixar algum dos arquivos essenciais!"
    exit 1
fi

log "Arquivos baixados com sucesso!"

# 4) Editar .env conforme necessário (opcional)
log "Você pode editar o arquivo .env para configurar variáveis como volumes e credenciais."
echo "Pressione ENTER para continuar após revisar .env (ou Ctrl+C para cancelar)"
read -r

# 5) Criar volume de dados persistente
log "Criando volume de dados persistente..."
mkdir -p data/media data/static
log "Diretórios de dados e mídia criados."

# 6) Executar configuração inicial do banco
log "Configurando o banco de dados e migrando esquemas..."
docker compose run --rm inventree-server invoke update
if [ $? -ne 0 ]; then
    log "Erro durante a configuração do banco!"
    exit 1
fi

# 7) Criar superusuário admin (opcional)
log "Agora você pode criar um usuário administrador."
echo "Se quiser criar agora, pressione ENTER (você será guiado) ou Ctrl+C para pular."
read -r
docker compose run inventree-server invoke superuser

# 8) Subir os containers
log "Subindo os containers (modo detached)..."
docker compose up -d

log "Instalação concluída! O InvenTree deve estar acessível no endereço configurado em .env."
