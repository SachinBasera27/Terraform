# Terraform


Architecture:

Terraform/
│
├── .github/
│   └── workflows/
│       ├── terraform-build.yml
│       └── terraform-deploy.yml

├── modules/
│   ├── networking/
│   ├── storage/
│   ├── compute/
│   ├── security/
│   └── monitoring/


├── backend.tf
├── providers.tf
├── versions.tf
├── variables.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars.example


├── .gitignore
|    |-include env files here
└── README.md
