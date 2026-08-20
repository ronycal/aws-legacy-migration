# Project 1: Migrating Company's Legacy System to AWS

## Project Overview

This project demonstrates the migration of a legacy web application environment to Amazon Web Services (AWS).

The objective was to modernize a traditional web application stack by provisioning cloud infrastructure in AWS, deploying an Ubuntu EC2 server, installing the required LAMP components, and hosting a WordPress website.

Terraform was used to provision and manage the AWS infrastructure as Infrastructure as Code (IaC), while Git and GitHub were used for version control and infrastructure change tracking.

---

## Project Objectives

The project was designed to:

- Provision AWS infrastructure using Terraform.
- Create a dedicated Virtual Private Cloud (VPC).
- Deploy a public subnet.
- Configure internet connectivity using an Internet Gateway.
- Configure routing for the public subnet.
- Implement security controls using an AWS Security Group.
- Deploy an Ubuntu EC2 instance.
- Configure SSH key-based authentication.
- Install and configure Apache.
- Install and configure PHP.
- Install and configure MySQL.
- Create a dedicated WordPress database and database user.
- Deploy WordPress.
- Assign a static Elastic IP to the web server.
- Validate public access to the WordPress application.
- Manage infrastructure source code using Git and GitHub.

---

## Architecture

The deployed environment follows this architecture:

```text
                    Internet
                       |
                       |
                Internet Gateway
                       |
                       |
                 Public Route
                       |
                       |
                  Public Subnet
                       |
                       |
                Security Group
                       |
                       |
                  Elastic IP
                       |
                       |
                  Ubuntu EC2
                       |
             +---------+---------+
             |         |         |
           Apache     PHP      MySQL
             |                   |
             |              WordPress DB
             |
          WordPress
             |
             |
          End User
```

The EC2 instance hosts the complete web application stack for the scope of this project.

---

## Technologies Used

| Technology | Purpose |
|---|---|
| AWS | Cloud infrastructure platform |
| Amazon VPC | Network isolation |
| Amazon EC2 | Virtual web server |
| Elastic IP | Static public IPv4 address |
| AWS Security Groups | Network access control |
| Terraform | Infrastructure as Code |
| Ubuntu Linux | EC2 operating system |
| Apache | Web server |
| PHP | Server-side application runtime |
| MySQL | Relational database |
| WordPress | Web application/CMS |
| SSH | Secure server administration |
| Git | Source control |
| GitHub | Remote source repository |

---

## AWS Infrastructure

Terraform was used to provision the primary AWS infrastructure.

The Terraform-managed resources include:

- VPC
- Public subnet
- Internet Gateway
- Public route table
- Route table association
- Security group
- Ubuntu EC2 instance
- Elastic IP
- Elastic IP association

Terraform state was used to track the deployed infrastructure.

---

## Infrastructure as Code Workflow

Infrastructure changes followed a controlled Terraform workflow:

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

Before deployment, Terraform plans were reviewed to confirm the expected infrastructure changes.

Terraform state was also verified using commands such as:

```bash
terraform state list
```

This provided visibility into the resources being managed by Terraform.

---

## Networking

A dedicated AWS VPC was created for the project.

The EC2 web server was deployed into a public subnet with internet connectivity provided through an Internet Gateway and public route table.

The network path is:

```text
Internet
   |
Internet Gateway
   |
Public Route Table
   |
Public Subnet
   |
EC2 Web Server
```

An Elastic IP was later associated with the EC2 instance to provide a stable public IPv4 address.

---

## Security

Several security controls were implemented during the project.

### EC2 Access

SSH access uses key-based authentication rather than password authentication.

The private SSH key remains on the administrator's local system and is not stored in the Git repository.

### Security Group

An AWS Security Group controls inbound traffic to the EC2 instance.

Required application traffic includes:

- SSH for server administration
- HTTP for WordPress web traffic

### Database Security

WordPress does not use the MySQL root account.

A dedicated database account was created:

```text
wordpressuser
```

The account was granted privileges specifically on:

```text
wordpress.*
```

The database account is restricted to connections from:

```text
localhost
```

Therefore, MySQL does not need to be publicly exposed for the current architecture.

### WordPress Configuration

The WordPress configuration file containing database credentials was protected with restricted Linux file permissions.

Sensitive information such as private keys, Terraform state, and variable files containing secrets should not be committed to GitHub.

---

## Application Deployment

The EC2 instance runs Ubuntu Linux with the following application stack:

```text
Ubuntu
   |
Apache
   |
PHP
   |
WordPress
   |
MySQL
```

Apache serves the WordPress application from:

```text
/var/www/html
```

WordPress communicates with the locally installed MySQL database using a dedicated database account.

---

## WordPress Database

A dedicated MySQL database was created:

```text
wordpress
```

A dedicated application account was also created:

```text
wordpressuser@localhost
```

The account was granted access only to the WordPress database.

Database authentication and database access were tested successfully before WordPress installation.

---

## WordPress Deployment

WordPress was downloaded from the official WordPress distribution and extracted on the Ubuntu server.

The application files were deployed to:

```text
/var/www/html
```

Appropriate ownership was assigned to the Apache web service account:

```text
www-data:www-data
```

The WordPress configuration was then connected to the MySQL database.

After configuration, the WordPress installation wizard was completed successfully.

---

## Elastic IP

Initially, the EC2 instance used an automatically assigned public IPv4 address.

Because an automatically assigned address may change after an EC2 stop/start operation, Terraform was later used to allocate and associate an AWS Elastic IP.

This provides the web server with a stable public address.

The WordPress `home` and `siteurl` settings were updated after the Elastic IP was associated.

---

## Validation and Testing

Multiple tests were performed throughout the project.

### Terraform Validation

```bash
terraform validate
```

Result:

```text
Success! The configuration is valid.
```

### Infrastructure Validation

Terraform state was inspected to verify that the expected AWS resources were being managed.

### SSH Testing

SSH connectivity to the EC2 instance was successfully verified using key-based authentication.

### Apache Testing

Apache service status was verified using:

```bash
sudo systemctl status apache2
```

Apache reported:

```text
active (running)
```

### MySQL Testing

MySQL service status was verified and the dedicated WordPress database credentials were tested successfully.

### WordPress Testing

WordPress was successfully accessed through the EC2 server's Elastic IP.

Both the public website and WordPress administrative dashboard were tested successfully.

---

## Git and GitHub Workflow

Infrastructure changes were version controlled throughout the project.

The workflow used was:

```text
Modify Terraform
      |
terraform fmt
      |
terraform validate
      |
terraform plan
      |
terraform apply
      |
Verify Infrastructure
      |
git add
      |
git commit
      |
git push
      |
GitHub
```

Infrastructure components were committed incrementally as the environment was built.

This provides a documented history of the infrastructure's development.

---

## Repository Security

The repository is configured to prevent sensitive or unnecessary Terraform files from being committed.

Examples of files that should remain outside source control include:

```text
*.tfstate
*.tfstate.*
.terraform/
terraform.tfvars
*.tfvars
*.pem
```

Credentials, database passwords, AWS secrets, and private SSH keys must never be committed to the repository.

---

## Project Outcome

The project successfully achieved its primary objective of migrating a traditional web application stack to AWS.

The completed environment provides:

- Cloud-hosted compute using Amazon EC2.
- AWS-based network infrastructure.
- Infrastructure provisioning using Terraform.
- Internet-accessible web hosting using Apache.
- PHP application processing.
- MySQL database services.
- A functioning WordPress deployment.
- Static public addressing using an Elastic IP.
- Secure SSH administration using key-based authentication.
- Infrastructure version control using Git and GitHub.

The WordPress frontend and administrative dashboard were successfully tested, demonstrating an operational end-to-end application stack hosted in AWS.

---

## Current Scope and Future Improvements

The current implementation satisfies the objectives of this project.

Potential future improvements could include:

- Configuring a domain name.
- Enabling HTTPS/TLS.
- Moving MySQL to Amazon RDS.
- Deploying the database into private subnets.
- Adding an Application Load Balancer.
- Implementing Auto Scaling.
- Adding automated CI/CD or GitOps workflows.
- Using AWS Secrets Manager or Systems Manager Parameter Store for secrets.
- Implementing monitoring with Amazon CloudWatch.

These enhancements are outside the current project scope but could be introduced as part of a future production-ready architecture.

---

## Conclusion

This project demonstrates the practical migration of a traditional web application environment to AWS while applying cloud engineering concepts including Infrastructure as Code, networking, compute, security, Linux administration, database configuration, application deployment, and source control.

The completed environment provides a functional WordPress application running on AWS and establishes a foundation that could be expanded into a more highly available and production-oriented cloud architecture.