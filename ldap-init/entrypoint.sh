#!/bin/bash
set -e

echo "⏳ Esperando a que slapd esté disponible..."

# ✅ Usamos DN completo del admin
until ldapwhoami -x -H ldap://ldap:1389 -D "cn=admin,dc=prodrigu,dc=local" -w adminpassword > /dev/null 2>&1
do
    echo "⌛ Esperando..."
    sleep 2
done

echo "✅ LDAP está disponible. Aplicando LDIFs..."

for file in $(ls /ldif/*.ldif | sort); do
    echo "🟢 Aplicando $file..."
    ldapadd -x -H ldap://ldap:1389 -D "cn=admin,dc=prodrigu,dc=local" -w adminpassword -f "$file" || echo "⚠️ Fallo al aplicar $file (posiblemente ya existe)"
done

echo "🏁 Finalizado"
