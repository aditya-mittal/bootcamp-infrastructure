# Infrastructure

Repository holding code to provision all infrastructure components needed, namely
- VPC
- DNS 
- ALB
- ECR
- Jenkins
- Environment (ECS Cluster)
- Test ECS Service (Nginx as test service)

![Infra Diagram](./jenkins.png "Infra Diagram")
 
### Pre-requisites
 
Before provisioning any code with terraform,
- Configure AWS credentials
- Create a S3 bucket & enable bucket versioning
```bash
$ aws s3 mb s3://bootcamp-2021-tf-state --region us-east-1
$ aws s3api put-bucket-versioning --bucket bootcamp-2021-tf-state --versioning-configuration Status=Enabled --region us-east-1
```
- Create a table in DynamoDB using script
```bash
$ aws dynamodb create-table --table-name bootcamp-2021-tf-lock-table \
    --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --region us-east-1
```

### Provisioning infrastructure

- [VPC](./vpc/README.md)
- [DNS](./dns/README.md)
- [ALB](./alb/README.md)
- [ECR](./ecr/README.md)
- [Jenkins](./jenkins/README.md)
- [Environment on ECS cluster](./ecs-cluster/README.md)
- [Test ECS service](./ecs-service/README.md)