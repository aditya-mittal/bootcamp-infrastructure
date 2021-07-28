# Jenkins

Provision an EC2 instance for hosting Jenkins.

![Jenkins Diagram](./jenkins.png "Jenkins")

### Pre-requisites

- [terraform 0.12.19](https://learn.hashicorp.com/terraform/getting-started/install.html)
- Update the Jenkins image tag (`jenkins_image_tag`) [here](./main.tf). The Jenkins image tag can be obtained from provisioned ECR
- Provision a ssh key-pair which can be used for cloning git repositories. Add key to respective git account.

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