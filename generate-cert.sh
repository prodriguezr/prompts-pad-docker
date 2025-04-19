#!/bin/bash
set -e

CERT_DIR="./https"
CERT_NAME="cert.pfx"

# Cargar variables de entorno si existen
if [ -f .env ]; then
  source .env
fi

PASSWORD="${CERT_PASSWORD:-changeme}" # Por defecto: 'changeme'
FORCE=0

# Parsear flags
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --force) FORCE=1 ;;
  esac
  shift
done

mkdir -p "$CERT_DIR"
cd "$CERT_DIR"

if [ -f "$CERT_NAME" ] && [ "$FORCE" -ne 1 ]; then
  read -p "⚠️  Ya existe $CERT_NAME. ¿Deseas sobrescribirlo? [s/N]: " confirm
  if [[ ! "$confirm" =~ ^[sS]$ ]]; then
    echo "❌ Cancelado. No se generó ningún certificado."
    exit 0
  fi
fi

echo "🔐 Generando clave y certificado autofirmado..."
openssl req -x509 -newkey rsa:4096 -sha256 -nodes \
  -keyout key.pem -out cert.pem -days 365 \
  -subj "/CN=localhost"

echo "📦 Empaquetando en formato .pfx..."
openssl pkcs12 -export \
  -out "$CERT_NAME" \
  -inkey key.pem \
  -in cert.pem \
  -passout pass:$PASSWORD

echo "🧹 Limpiando archivos temporales..."
rm key.pem cert.pem

echo "✅ Certificado generado: $CERT_DIR/$CERT_NAME"
