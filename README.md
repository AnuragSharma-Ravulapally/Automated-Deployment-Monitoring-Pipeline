
# Project Title

# 🌐 Automated Deployment & Monitoring Pipeline (ADMP)
### Phase 1: Infrastructure Setup using Terraform

This phase focuses on **automating the creation of AWS EC2 instances** for different tools — **Jenkins, Ansible, Nagios, and Web Server** — using Terraform.

---
## ⚙️ Prerequisites

Before you begin, make sure you have:

- ✅ **AWS Account**
- ✅ **AWS CLI configured** (`aws configure`)
- ✅ **Terraform installed** (`terraform -v`)
- ✅ **Key pair** created in AWS EC2 (example: `ADMP`)
- ✅ **Correct AMI ID** (Ubuntu 22.04 LTS — `ami-0c398cb65a93047f2`)
- ✅ **Region:** `us-east-1`

---

## 🚀 Step-by-Step Commands

Run the following commands **inside your project folder**:

### 🏁 1. Initialize Terraform
```bash
terraform init
```
This downloads all required Terraform providers and prepares your workspace.
🔍 2. Validate the Configuration
```bash
terraform validate
```
Ensures that all .tf files are syntactically correct.

📋 3. Preview the Resources
```bash
terraform plan
```
Displays what Terraform will create before actually deploying.

⚡ 4. Apply the Configuration
```bash
terraform apply
```
When prompted, type:
yes

This command creates the EC2 instances for:

Jenkins Server

Ansible Server

Nagios Server

Web Server

⚠️ WARNING — Infrastructure Deletion
⚠️ DO NOT RUN THIS COMMAND UNLESS YOU WANT TO DELETE EVERYTHING! ⚠️
```bash
terraform destroy
```
🟥 This will permanently delete all EC2 instances and resources created by Terraform.
