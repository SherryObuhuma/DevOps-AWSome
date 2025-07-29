# 🛠️ Dev VPC Infrastructure with Terraform

This project sets up a development Virtual Private Cloud (VPC) environment on AWS using [Terraform](https://www.terraform.io/). It includes:

- A custom VPC
- Public and private subnets across two Availability Zones
- Internet Gateway (IGW) and NAT Gateway
- Route tables and associations
- A security group for development (dev_SG)

---

## 📁 Project Structure

The Terraform configuration provisions the following resources:

### ✅ VPC & Subnets
- `aws_vpc.dev_vpc` – Main development VPC
- 2 public subnets: `dev_public_subnet_1`, `dev_public_subnet_2`
- 2 private subnets: `dev_private_subnet_1`, `dev_private_subnet_2`

### ✅ Internet and NAT Gateways
- `aws_internet_gateway.dev_igw` – Provides internet access for public subnets
- `aws_eip.dev_eip` – Elastic IP for NAT
- `aws_nat_gateway.dev_nat_gateway` – Enables private subnets to access the internet

### ✅ Route Tables
- `dev_public_rt` routes public traffic through IGW
- `dev_private_rt` routes traffic from private subnets through NAT Gateway

### ✅ Security Group (`dev_SG`)
Allows inbound:
- HTTP (port 80)
- HTTPS (port 443)
- SSH (port 22)

And allows all outbound traffic.

---

## 🧪 Prerequisites

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- AWS credentials configured via:
  - `~/.aws/credentials`, or
  - `aws configure`, or
  - environment variables

---

## 🚀 How to Use

1. **Clone this repo**:
   ```bash
   git clone hhttps://github.com/SherryObuhuma/DevOps-AWSome.git
   cd DevOps-AWSome

## Or this

2. **Clone this repo**:
   ```bash
   git clone https://github.com/muiruri3000/DevOps-AWSome.git
   cd DevOps-AWSome