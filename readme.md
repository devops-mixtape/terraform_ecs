# Terraform ECS Fargate Example

This project will use [Terraform] to provision and manage AWS container
infrastructure to run whatever container your little heart desires.

You will be able to configure a public container image from Docker Hub, ECR, or
any other container registry out of the box. This is meant as a boiler
plate, if you want to use a private image, utilize a load balancer, or
use ports other than the default HTTP port (80) you'll need to do
further configuration from this boiler plate infrastructure.

## Configuration Options

In `variables.tf` you will be able to configure:

1. Container image URL
2. Container CPU
3. Container Memory
4. Number of containers to provision

## Usage

### Install Terraform
To get started you'll need to clone this repo and [install
Terraform](https://learn.hashicorp.com/terraform/getting-started/install)
on your computer. Once you have done that, run `terraform init` in this
 directory to install the Terraform AWS adapter.

### Authenticate to AWS

You'll also need to install the AWS CLI and configure your authentication
locally. I'd recommend referring to the [getting
started](https://learn.hashicorp.com/terraform/getting-started/build)
section a more in-depth guide on authenticating to AWS.

> Note: Running this AWS infrastructure will result in charges to your
> account.

### Spin Everything Up

Run `terraform apply` and Terraform will present to you the AWS
resources we will be provisioning in this example. If you reply with
`yes` Terraform will automatically provision in your container
infrastructure, pull down your container, and serve it over port 80.
