# ECS Cluster

Provision an ECS cluster for hosting services. The provision of ECS cluster is done using Jenkins job and we discourage 
for any provisioning using local machines.

### Steps to provision

- Run the [Jenkins job](TBD_Jenkins_URL) named provision-ecs-cluster with parameter 'create'
- You will be prompted to approve the plan, approve it, if changes seems to be inline with expectations. 

### Steps to de-provision

- Run the [Jenkins job](TBD_Jenkins_URL) named provision-ecs-cluster with parameter 'destroy'
- You will be prompted to approve the plan, approve it, if changes seems to be inline with expectations.

### To-Do
- [ ] Test cluster by deploying a sample service(maybe nginx) on this cluster
- [ ] Update the Jenkins URL in README
