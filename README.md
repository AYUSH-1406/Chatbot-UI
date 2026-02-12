

# 🚀 EKS DevSecOps Chatbot Platform

Production-grade 1-tier Chatbot application deployed on Amazon EKS using pure Terraform and secured with a full DevSecOps Jenkins pipeline including drift detection and container security scanning.

---

<img width="1413" height="395" alt="image" src="https://github.com/user-attachments/assets/309c74ae-92c6-4843-92d2-417aac058294" />
<img width="1919" height="967" alt="image" src="https://github.com/user-attachments/assets/511c54a9-59e1-47dd-8f68-0603c0a94e47" />

## 📌 Project Overview

This project demonstrates a complete production-level DevOps & DevSecOps implementation including:

* Custom VPC architecture
* Amazon EKS cluster (no Terraform modules used)
* Dockerized Next.js application
* Amazon ECR image registry
* AWS Load Balancer Controller (ALB Ingress)
* Jenkins CI/CD pipeline
* Terraform remote backend (S3 + DynamoDB)
* Terraform drift detection (exit-code based)
* Container vulnerability scanning (Trivy)
* SAST security scanning
* Rolling deployments to Kubernetes

The application is a stateless chatbot UI that communicates with the OpenAI API.

---

## 🏗 Architecture

```
User
  ↓
Application Load Balancer (Public Subnet)
  ↓
Amazon EKS Cluster (Private Subnets)
  ↓
Kubernetes Service
  ↓
Chatbot Pods (Docker container from ECR)
  ↓
Outbound NAT → OpenAI API
```

---

## 🧱 Infrastructure Stack

| Component               | Technology         |
| ----------------------- | ------------------ |
| Cloud Provider          | AWS                |
| Container Orchestration | Amazon EKS         |
| Infrastructure as Code  | Terraform          |
| Remote State            | S3 + DynamoDB      |
| CI/CD                   | Jenkins            |
| Container Registry      | Amazon ECR         |
| Security Scanning       | Trivy              |
| Ingress                 | AWS ALB Controller |
| Container Runtime       | Docker             |
| Application             | Next.js            |

---

## 🔐 DevSecOps Pipeline Stages

Pipeline includes:

* ✅ Checkout from GitHub
* ✅ SAST filesystem scan
* ✅ Docker build
* ✅ Container vulnerability scan
* ✅ Push to ECR
* ✅ Terraform init
* ✅ Drift detection (`terraform plan -detailed-exitcode`)
* ✅ Conditional Terraform apply
* ✅ Rolling deployment to EKS

### Drift Detection Logic

| Exit Code | Meaning        |
| --------- | -------------- |
| 0         | No changes     |
| 2         | Drift detected |
| 1         | Error          |

Apply runs only if drift is detected.

---

## 📁 Repository Structure

```
.
├── Terraform/                # Terraform Infrastructure
│   ├── provider.tf
│   ├── backend.tf
│   ├── vpc.tf
│   ├── iam.tf
│   ├── eks.tf
│   ├── nodegroup.tf
│   ├── ecr.tf
│   └── outputs.tf
│
├── K8s/                  # Kubernetes manifests
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
│
├── Dockerfile
├── Jenkinsfile
└── README.md
```

---

## 🌐 Deployment Workflow

1. Developer pushes code
2. Jenkins triggers pipeline
3. Security scans run
4. Docker image built
5. Image scanned for vulnerabilities
6. Image pushed to ECR
7. Terraform drift detection runs
8. Infra updated only if drift exists
9. Kubernetes rolling deployment triggered

Zero downtime deployment.

---

## 🔒 Security Features

* Non-root container execution
* Resource limits defined
* Vulnerability scanning (Trivy)
* ECR image scanning enabled
* Terraform state locking
* Remote state encryption
* Drift detection enforcement

---

## 📦 Terraform Remote Backend

```hcl
backend "s3" {
  bucket         = "your-terraform-state-bucket"
  key            = "eks/terraform.tfstate"
  region         = "ap-south-1"
  dynamodb_table = "terraform-locks"
  encrypt        = true
}
```

---

## 🚀 How to Deploy

### 1️⃣ Provision Infrastructure

```bash
cd Terraform
terraform init
terraform apply
```

### 2️⃣ Push Docker Image

```bash
docker build -t chatbot-ui .
docker tag chatbot-ui:latest <ECR_URL>
docker push <ECR_URL>
```

### 3️⃣ Deploy to EKS

```bash
kubectl apply -f k8s/
```

---

## 🧠 Learning Outcomes

This project demonstrates:

* Building EKS without Terraform modules
* Designing production VPC architecture
* Implementing DevSecOps pipeline
* Infrastructure drift detection
* Secure CI/CD implementation
* Rolling Kubernetes deployments
* Real-world cloud production patterns

---

## 📈 Future Enhancements

* Horizontal Pod Autoscaler
* Cluster Autoscaler
* GitOps (ArgoCD)
* OPA policy enforcement
* Prometheus + Grafana monitoring
* Multi-environment (staging/prod)
* Blue/Green deployment strategy

---

## 👨‍💻 Author

Built as a complete end-to-end DevOps & DevSecOps production project.

---

🚀
