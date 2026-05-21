# Legacy Users — Pipeline CI/CD con Terraform en AWS

## Descripción de la Arquitectura CI/CD

Este proyecto implementa una arquitectura DevOps completa para la aplicación `legacy-users` (Grupo C, puerto 8000), siguiendo el ciclo CI/CD con GitOps.

### Integración Continua (CI)
- **Trigger:** push o pull_request a la rama `develop`
- **Workflow:** `.github/workflows/ci.yml`
- **Pasos:** Checkout → Node.js 20 → npm install → npm test → empaquetado de artefacto
- **Resultado:** Validación automática de las pruebas nativas de Node.js

### Despliegue Continuo (CD)
- **Trigger:** push o merge a la rama `main`
- **Workflow:** `.github/workflows/cd.yml`
- **Pasos:** Checkout → Credenciales AWS (Access Key, Secret Key, Session Token) → Terraform 1.9.8 → init → plan → apply
- **Resultado:** Aprovisionamiento automático de infraestructura en AWS

### Infraestructura como Código (IaC)
Arquitectura modular en Terraform con backend remoto S3:

```
terraform/
├── main.tf            # Orquestador de módulos
├── providers.tf       # AWS provider + backend S3
├── variables.tf       # Variables globales
├── outputs.tf         # IP pública de salida
└── modules/
    ├── network/       # Security Groups
    └── compute/       # EC2 + user_data
```

### Backend Remoto
- **Bucket S3:** `legacy-users-terraform-josealfredo`
- **Region:** `us-east-1`
- **Key:** `terraform.tfstate`

### Aprovisionamiento
- **AMI:** Amazon Linux 2023 (obtenida dinámicamente con data source)
- **Instancia:** `t3.micro` (escalada desde t2.micro tras Evento Imprevisto)
- **IAM Instance Profile:** `LabInstanceProfile`
- **Gestor de paquetes:** `dnf` (Amazon Linux 2023)
- **User Data:** instala Node.js, configura Express y arranca la app en puerto 8000

### Seguridad (GitOps post Evento Imprevisto)
- Security Group restringe el acceso entrante a la IP pública del desarrollador (`/32`)
- Reglas: SSH (22) y App (8000), ambas con origen `/32`
- Cambio aplicado 100% vía pipeline (no manual en consola AWS)

## URL de Validación

La aplicación está desplegada y respondiendo en:

**http://44.220.133.2:8000**

Respuesta esperada:
​```json
{"status":"ONLINE","app":"legacy-users","port":8000}
​```

## Evidencias

Carpeta `evidencias/` contiene:
- `hito1_ci_ok.png` — Pipeline CI verde en develop
- `hito1_log.txt` — Log completo de GitHub Actions
- `hito2_backend.txt` — Configuración backend S3 en providers.tf
- `hito2_plan.png` — Captura de terraform plan exitoso
- `hito3_cd_actions.png` — Pipeline CD verde en main
- `hito3_aws_security.png` — Security Group con IP /32 en consola AWS

## Autor

José Alfredo Zambrana — Universidad Católica Boliviana "San Pablo"  
Computación en la Nube — Laboratorio Evaluativo Unidad 2