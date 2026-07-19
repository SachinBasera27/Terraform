# Terraform

Architecture:

```text
Terraform/
│
├── .github/
│   └── workflows/
│       ├── terraform-build.yml
│       └── terraform-deploy.yml
│
├── modules/
│   ├── networking/
│   ├── storage/
│   ├── Resource
│
├── backend.tf
├── providers.tf
├── main.tf
├── terraform.tfvars.example
├── .gitignore
│   └── include env files here
└── README.md
```
