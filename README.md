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
|     └── networkMain.tf
|     └── netOut.tf
│   ├── storage/
|      └── storageMain.tf
|      └── storageOut.tf
│   ├── Resource
|      └── resourceMain.tf
|      └── resourceOut.tf
│
├── backend.tf
├── providers.tf
├── main.tf
├── .gitignore
│    └── terraform.exe
|    └── Working Directory files which include providers and modules
|    └── Terraform state files
|    └── Terraform plan files
└── README.md
```
