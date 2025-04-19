# 🐳 PromptsPad - Entorno Docker

Este directorio contiene la configuración de Docker necesaria para levantar el entorno completo de desarrollo y pruebas de **PromptsPad**, incluyendo:

- Servidor LDAP (Bitnami OpenLDAP)
- Script de inicialización (`ldap-init`)
- API ASP.NET Core (contenida en `../backend`)
- Generación de certificado HTTPS autofirmado

...

## 📁 Estructura

```
docker/
├── docker-compose.yml
├── .env
├── .env.sample
├── generate-cert.sh
├── https/
│   └── cert.pfx
└── ldap-init/
    ├── Dockerfile
    ├── entrypoint.sh
    └── ldif/
        ├── 01-root.ldif
        └── 02-init.ldif
```

...
