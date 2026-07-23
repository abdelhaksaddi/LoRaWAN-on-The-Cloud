# 🚀 LoRaWAN Cloud Infrastructure with AWS & Terraform

This project automates the deployment of a **LoRaWAN Network Server (ChirpStack)** on Amazon Web Services (AWS) using **Terraform** for Infrastructure as Code (IaC).

---

## 📋 Prerequisites

Before starting, ensure you have installed and configured the following tools:

* Git
* AWS CLI
* Terraform (v1.0+)
* An active **AWS Account** (Standard or AWS Academy / Learner Lab)

---

## 🛠️ Step-by-Step Setup Guide

### 1. Workspace Setup
Initialize your local project directory and Git repository:

mkdir TerraformAwsLab
cd TerraformAwsLab
git init

---

### 2. Configure AWS Credentials
Connect your terminal to your AWS account:

aws configure

Provide your AWS Access Key ID, AWS Secret Access Key, and set the default region to us-east-1.

> 💡 Note for AWS Academy / Learner Lab Users:
> Session tokens are temporary. When your session expires, update your credentials directly in the AWS credentials file on Windows:
>
> Path: C:\Users\<your-windows-username>\.aws\credentials
>
> Paste the refreshed session block (including aws_session_token) into this file:
> [default]
> aws_access_key_id = ASIA...
> aws_secret_access_key = ...
> aws_session_token = IQoJb3JpZ2luX2Vj...

---

## 🧪 Part 1: Initial Terraform Validation Test

To test that Terraform communicates correctly with AWS, create a test bucket configuration.

1. Create a file named main.tf and paste the following:

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Test resource: S3 Bucket creation
resource "aws_s3_bucket" "mon_bucket_test" {
  bucket = "tf-lab-bucket-abdelhak-2026"
}

2. Initialize the working directory:
terraform init

3. Preview the infrastructure plan:
terraform plan
(Expected output: Plan: 1 to add, 0 to change, 0 to destroy)

4. Apply the configuration to deploy the test bucket:
terraform apply
When prompted, type yes to confirm execution.

---

## 📡 Part 2: Automated ChirpStack EC2 Deployment

Once the provider setup is verified, update the configuration to automatically provision an AWS EC2 virtual machine pre-configured with ChirpStack (Dockerized LoRaWAN Network Server).

### 1. Preview Deployment Plan
Review the pending EC2 instance and Security Group deployment:

terraform plan

### 2. Deploy the Infrastructure
Apply the configuration to launch the instance and execute the initialization script (user_data):

terraform apply
Type yes when prompted.

---

## 🌐 Accessing the Network Server

Once deployment completes, retrieve the public IP address of your ChirpStack server:

terraform output server_public_ip

### Next Steps:
1. Allow 2 to 3 minutes for the user_data script to finish installing Docker and booting up ChirpStack containers.
2. Open your web browser and navigate to:
   http://<server_public_ip>:8080
3. Log in with the default credentials:
   * Username: admin
   * Password: admin

---

## 🧹 Cleanup

To avoid unnecessary AWS charges, destroy all deployed resources when finished:

terraform destroy