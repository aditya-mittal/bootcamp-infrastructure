# ALB

Provisions an ALB for load balancing all services and tools.

The entire provisioning of ALB is done using terraform.

![ALB Diagram](../docs/alb.png "ALB")

### Pre-requisites

- [terraform 0.12.19](https://learn.hashicorp.com/terraform/getting-started/install.html)

### Steps to provision

```bash
$ terraform init
$ terraform get -update=true
$ terraform plan -out tfplan
$ terraform apply tfplan
```

### Steps to de-provision

```bash
$ terraform init
$ terraform get -update=true
$ terraform plan -destroy -out destroy_tfplan
$ terraform apply destroy_tfplan
```