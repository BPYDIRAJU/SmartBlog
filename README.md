# ☁️ SmartBlog - AWS Terraform Project

This project deploys a **Flask-based blog app** called **SmartBlog** on AWS using **Terraform**, custom VPC, EC2, Security Groups, Load Balancer (ALB), and GitHub.

---

## 🗂️ Folder Structure


---

## ⚙️ What Each File Does

| File                  | Description |
|-----------------------|-------------|
| `application.py`      | Your Flask web app |
| `requirements.txt`    | All Python dependencies (Flask, Gunicorn) |
| `.gitignore`          | Ignores virtualenv and `.terraform` folders |
| `main.tf`             | Connects and orchestrates all resources |
| `provider.tf`         | Declares AWS provider and region |
| `variable.tf`         | Holds reusable variables like AMI, instance_type |
| `outputs.tf`          | Prints ALB DNS & EC2 public IP |
| `ec2.tf`              | Defines EC2 instance for Flask app |
| `alb.tf`              | Creates Application Load Balancer and Listener |
| `security.tf`         | Security Groups for ALB, EC2, and RDS |
| `subnets.tf`          | Public and private subnets |
| `vpc.tf`              | Custom VPC creation |
| `rds.tf`              | MySQL RDS DB in private subnet |
| `igw.tf`              | Internet Gateway for public subnet |
| `route_tables.tf`     | Public & private route tables |
| `terraform.tfstate`   | Terraform state file (do not edit manually) |
| `terraform.tfstate.backup` | Backup state file |

---

## 🚀 How to Launch Project (Step-by-Step)

### 1. Clone the Repo

```bash
git clone https://github.com/BPYDIRAJU/SmartBlog.git
cd SmartBlog/terraform-ninja-vpc
terraform init
terraform apply
