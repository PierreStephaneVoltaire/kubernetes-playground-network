# Kubernetes Playground Networking Terraform Module

This repository contains the Terraform code for setting up networking resources required for a Kubernetes playground environment on AWS and Azure.

## Overview

This module creates the necessary networking resources in both AWS and Azure for deploying Kubernetes clusters using EKS and AKS. The resources include:

- **AWS Resources**:
    - VPC
    - Subnets (public and private)
    - NAT Gateways (replaced Nat with fck-nat to reduce cost)
    - Route Tables


The networking resources created here will be consumed by EKS and AKS modules for Kubernetes cluster deployments.

## Prerequisites

- Terraform v1.0+
- AWS CLI (for AWS resources)
- Appropriate AWS and Azure credentials configured
