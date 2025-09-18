# nequi-techlead-technical-test-iac

[![Terraform](https://img.shields.io/badge/Terraform-1.6+-blue?logo=terraform&logoColor=white)](https://terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-ECS%20Fargate-orange?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![MongoDB Atlas](https://img.shields.io/badge/MongoDB-Atlas-green?logo=mongodb&logoColor=white)](https://www.mongodb.com/atlas)
[![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-blue?logo=github&logoColor=white)](https://github.com/features/actions)

Infraestructura como código (IaC) para la prueba técnica del rol **Líder Técnico** en Nequi.

Este repositorio contiene la configuración de Terraform necesaria para desplegar una arquitectura completa en AWS, incluyendo:

- **ECS Fargate** - Servicio de contenedores completamente administrado
- **Application Load Balancer (ALB)** - Balanceador de carga para distribución de tráfico
- **Amazon ECR** - Registro de contenedores Docker
- **AWS Secrets Manager** - Gestión segura de credenciales y configuraciones
- **CloudWatch** - Monitoreo, logs y observabilidad
- **MongoDB Atlas** - Base de datos NoSQL en la nube
- **GitHub Actions** - Pipeline de CI/CD automatizado

---

## Estructura del repositorio

```
nequi-techlead-technical-test-iac/
├── .github/
│   └── workflows/
│       └── terraform.yml                 # Pipeline de CI/CD con GitHub Actions
├── terraform-transversal/                # Infraestructura AWS principal
│   ├── main.tf                          # Recursos principales (ECS, ALB, ECR)
│   ├── provider.tf                      # Configuración de proveedores AWS
│   ├── variables.tf                     # Variables de entrada
│   ├── locals.tf                        # Variables locales y tags
│   └── outputs.tf                       # Outputs de la infraestructura
├── terraform-atlas/                      # Configuración MongoDB Atlas
│   ├── main.tf                          # Recursos de MongoDB Atlas
│   ├── provider.tf                      # Proveedores AWS y MongoDB Atlas
│   ├── variables.tf                     # Variables para Atlas
│   ├── locals.tf                        # Configuración local de Atlas
│   └── data.tf                          # Sources de datos
└── README.md                            # Este archivo
```

---

## Arquitectura desplegada

La infraestructura desplegada incluye:

### AWS ECS Fargate

- **Cluster ECS**: Entorno de contenedores administrado
- **Task Definition**: Configuración del contenedor de la aplicación
- **Service**: Gestión automática de tareas y auto-scaling
- **Security Groups**: Configuración de red y seguridad

### Application Load Balancer (ALB)

- **Load Balancer**: Distribución de tráfico HTTP/HTTPS
- **Target Groups**: Configuración de health checks
- **Listeners**: Enrutamiento de peticiones

### Amazon ECR

- **Repository**: Registro privado para imágenes Docker
- **Lifecycle Policy**: Gestión automática de versiones de imágenes

### MongoDB Atlas

- **Project**: Proyecto dedicado para la aplicación
- **Cluster M0**: Instancia gratuita para desarrollo/testing
- **Database User**: Usuario de aplicación con permisos específicos
- **IP Access List**: Configuración de acceso de red

### Observabilidad

- **CloudWatch Logs**: Centralización de logs de la aplicación
- **AWS Secrets Manager**: Almacenamiento seguro de credenciales

---

## Requisitos previos

### Herramientas necesarias

- **Terraform** >= 1.6.6
- **AWS CLI** configurado con credenciales válidas
- **Cuenta MongoDB Atlas** con API Keys

### Credenciales requeridas

#### AWS

```bash
aws configure
```

- AWS Access Key ID
- AWS Secret Access Key
- Región (recomendado: `us-east-1`)

#### MongoDB Atlas

- **Organization ID**: ID de tu organización en Atlas
- **API Public Key**: Clave pública de API
- **API Private Key**: Clave privada de API

---

## Configuración y despliegue

### 1. Clonar el repositorio

```bash
git clone https://github.com/EdisonArias/nequi-techlead-technical-test-iac.git
cd nequi-techlead-technical-test-iac
```

### 2. Configurar variables de entorno

Crear archivo `terraform.tfvars` en cada directorio:

#### terraform-transversal/terraform.tfvars

```hcl
aws_region         = "us-east-1"
name_prefix        = "nequi-techlead"
ecr_repo_name      = "nequi-techlead-app"
container_port     = 8080
desired_count      = 1
health_check_path  = "/actuator/health"
mongodb_uri        = "mongodb+srv://user:password@cluster.mongodb.net/nequiTechnicalTest"
```

#### terraform-atlas/terraform.tfvars

```hcl
aws_region          = "us-east-1"
atlas_org_id        = "your-atlas-org-id"
atlas_public_key    = "your-atlas-public-key"
atlas_private_key   = "your-atlas-private-key"
atlas_project_name  = "nequi-techlead"
atlas_cluster_name  = "Cluster0"
db_user            = "nequi_app"
db_password        = "your-secure-password"
db_name            = "nequiTechnicalTest"
```

### 3. Desplegar MongoDB Atlas

```bash
cd terraform-atlas
terraform init
terraform plan
terraform apply
```

### 4. Desplegar infraestructura AWS

```bash
cd ../terraform-transversal
terraform init
terraform plan
terraform apply
```

### 5. Verificar despliegue

Una vez completado el despliegue, obtendrás:

```bash
# Outputs importantes
alb_dns_name = "nequi-techlead-alb-xxxxxxxxx.us-east-1.elb.amazonaws.com"
ecr_repository_url = "xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/nequi-techlead-app"
```

---

## CI/CD con GitHub Actions

### Configuración de Secrets

En tu repositorio de GitHub, configura los siguientes secrets:

#### AWS Credentials

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

#### MongoDB Atlas Credentials

- `ATLAS_ORG_ID`
- `ATLAS_PUBLIC_KEY`
- `ATLAS_PRIVATE_KEY`
- `DB_PASSWORD`

### Pipeline automatizado

El workflow `.github/workflows/terraform.yml` permite:

1. **Despliegue automático** en push a `main`
2. **Validación** en pull requests
3. **Destrucción manual** de infraestructura

### Ejecución manual

1. Ve a la pestaña **Actions** en GitHub
2. Selecciona el workflow **Terraform Infrastructure**
3. Ejecuta con **Run workflow** , puedes escoger entre los stacks:
   - `transversal`
   - `atlas`
4. Selecciona la acción deseada:
   - `apply` - Crear/actualizar infraestructura
   - `destroy` - Destruir infraestructura

---

## Comandos útiles

### Validación y planning

```bash
# Validar sintaxis
terraform validate

# Ver plan de ejecución
terraform plan

# Aplicar cambios
terraform apply

# Destruir infraestructura
terraform destroy
```

### Gestión de estado

```bash
# Ver estado actual
terraform show

# Listar recursos
terraform state list

# Importar recurso existente
terraform import aws_instance.example i-1234567890abcdef0
```

### Debugging

```bash
# Habilitar logs detallados
export TF_LOG=DEBUG
terraform apply

# Ver outputs
terraform output
```

---

## Recursos creados

### AWS Resources

| Recurso              | Nombre                     | Propósito               |
| -------------------- | -------------------------- | ----------------------- |
| ECS Cluster          | `nequi-techlead-cluster`   | Entorno de contenedores |
| ECS Service          | `nequi-techlead-svc`       | Servicio de aplicación  |
| ALB                  | `nequi-techlead-alb`       | Load balancer público   |
| ECR Repository       | `nequi-techlead-app`       | Registro de imágenes    |
| CloudWatch Log Group | `/ecs/nequi-techlead`      | Logs de aplicación      |
| Secrets Manager      | `nequi-techlead-mongo-uri` | Credenciales MongoDB    |

### MongoDB Atlas Resources

| Recurso       | Nombre               | Propósito                  |
| ------------- | -------------------- | -------------------------- |
| Project       | `nequi-techlead`     | Proyecto de aplicación     |
| Cluster       | `Cluster0`           | Instancia de base de datos |
| Database User | `nequi_app`          | Usuario de aplicación      |
| Database      | `nequiTechnicalTest` | Base de datos principal    |

---

## Seguridad

### Buenas prácticas implementadas

- **Secrets Manager** para credenciales sensibles
- **Security Groups** con acceso mínimo necesario
- **IAM Roles** con principio de menor privilegio
- **VPC** con subnets públicas y privadas

### Configuración de red

- **VPC dedicada** con CIDR `10.0.0.0/16`
- **Subnets públicas** para ALB
- **Subnets privadas** para ECS tasks
- **NAT Gateway** para acceso saliente desde subnets privadas

---

## Troubleshooting

### Problemas comunes

#### Error: MongoDB Atlas authentication

```bash
Error: error creating MongoDB Atlas Project: POST https://cloud.mongodb.com/api/atlas/v1.0/groups: 401 (request "Unauthorized")
```

**Solución**: Verificar que las API Keys de Atlas sean correctas y tengan permisos de Organization Owner.

#### Error: ECR repository already exists

```bash
Error: error creating ECR Repository: RepositoryAlreadyExistsException
```

**Solución**: Importar el repositorio existente o usar un nombre diferente.

#### Error: ECS service unhealthy

```bash
service nequi-techlead-svc was unable to place a task because no container instance met all of its requirements
```

**Solución**: Verificar que la imagen Docker esté disponible en ECR y que los health checks sean correctos.

### Logs útiles

```bash
# Ver logs de ECS service
aws logs get-log-events --log-group-name "/ecs/nequi-techlead"

# Ver estado de ECS service
aws ecs describe-services --cluster nequi-techlead-cluster --services nequi-techlead-svc
```

---

## Notas importantes

- **Escalabilidad**: La infraestructura soporta auto-scaling horizontal basado en métricas
- **Costos**: MongoDB Atlas M0 es gratuito; AWS ECS Fargate cobra por uso de CPU/memoria
- **Monitoreo**: CloudWatch Logs y métricas están habilitadas para observabilidad completa
- **Backup**: MongoDB Atlas incluye backups automáticos en el tier M0
- **SSL/TLS**: Todas las conexiones están cifradas (ALB → ECS, App → MongoDB)

---

## Autor

**Edison Ferney Arias Plazas**  
Prueba técnica Nequi Líder Técnico - Infraestructura como Código
