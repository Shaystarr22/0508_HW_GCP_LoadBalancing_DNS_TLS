# Week 10 Homework – DNS, TLS, Load Balancing, Troubleshooting, and Terraform

## What This Is

This is my Week 10 assignment covering DNS, SSL/TLS, load balancing, cloud infrastructure troubleshooting, and deploying infrastructure with Terraform on Google Cloud Platform.

---

## Docs and Resources I Used

### Google Cloud

I referenced the GCP docs mainly for understanding how load balancers, managed instance groups, firewall rules, Cloud DNS, and health checks all fit together.

- https://cloud.google.com/load-balancing/docs
- https://cloud.google.com/dns/docs
- https://cloud.google.com/compute/docs/instance-groups

### Terraform

Used the Terraform registry docs to figure out the right syntax and resource types for the Google provider — especially for health checks, MIG resources, variables, and outputs.

- https://registry.terraform.io/providers/hashicorp/google/latest/docs

---

## Setting Up the Broken Environment

I spun up the broken environment using this command:

```bash
curl -s https://storage.googleapis.com/static-site-bucket-522479235074/broken-env-1.sh | sh
```

### What I Noticed Right Away

When I first looked at the environment, the VM was running but HTTP traffic wasn't going through. SSH wasn't working either at first. I started digging into the firewall rules, VM tags, and external IP config to figure out what was off.

### Commands I Used

```bash
gcloud compute instances list
gcloud compute firewall-rules list
curl EXTERNAL_IP
gcloud compute ssh VM_NAME --zone ZONE
```

---

## What's in This Assignment

### Q&A

Covers the conceptual stuff — DNS, TLS/SSL, load balancing, and Cloud DNS.

### Runbook

Step-by-step troubleshooting guide for SSH issues, HTTP failures, firewall problems, and general VM weirdness.

### Support Ticket

A write-up of the broken environment incident — what happened, what caused it, how I fixed it, and how to prevent it next time.

### Terraform

The actual infrastructure-as-code portion. Covers building out:

- VPC
- Firewall rules
- Instance template
- Health checks
- Managed instance groups
- Load balancer

## What's in This Assignment

### Commands I Used

---

## Repository Structure

```text
README.md
runbook.md
support-ticket.md
terraform/
```

The terraform directory contains the infrastructure-as-code configuration files used to provision networking, firewall rules, instance templates, managed instance groups, health checks, and load balancing resources.

---

## What's in This Assignment
