# Infra

This repository contains the [Terraform](https://terraform.io) definition to create the 
infrastructure in the cloud.

The environments are separated by [Terraform workspace](https://www.terraform.io/docs/state/workspaces.html).

### Requirements

 - [Terraform 0.12.9](https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_darwin_amd64.zip)
 - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

### Getting started
 - In the first run of Terraform, we need to create the S3 bucket and DynamoDB table 
 that will be used has a backend for Terraform state. To create it, follow the 
 step-by-step bellow:
    - `cd setup`
    - `terraform init`
    - `terraform apply` - Confirm with a "yes"
    - Copy the "bucket" output param (it will look like: 
      `<project_name>-terraform-state`).
    - At `./main.tf` file, change the param `bucket` in the terraform block by the 
      value you previously copied.
    - Copy the "dynamodb_table" output param (will look like: 
      `<project_name>-terraform-locks`).
    - In the same `terraform` block that you edited, change the param `dynamodb_table` 
      by the the value you previously copied.
    - Now, you can run the code of root directory.

### Creating the infrastucture
 - Initialize terraform in your local machine: `terraform init`
 - Select the workspace using `terraform workspace select {env}`
    - To list the existing workspaces use `terraform workspace list`
    - You can create new workspaces with `terraform workspace new`
 - Create a `./terraform.tfvars` file and populate it with input variables present on 
   `./variables.tf`
 - Create a key pair:
    ```
    $ ssh-keygen -m PEM
   ```
   Get the public key value and set the variable `public_key` in `./terraform.tfvars`:
   ```
    $ ssh-keygen -y -f /path/to/key
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5u................
    ```

 - To verify what will be changed, run `terraform plan`
 - If everything is ok, run `terraform apply` and confirm.
 - The update takes some time... So, go drink a coffee ☕️.
 - **Important:** The first run will fail, since it will timeout during the HTTPS 
   certificate creation (on ACM). You have to access the AWS console, copy the record 
   details and add it to your DNS provider. After this is done, wait until the the 
   certificate is ISSUED and run `terraform apply` one more time.
 - To get the outputs (deploy keys, container repos and DNS, use `terraform output`)

### More info
 This setup creates an ECS cluster, S3 bucket and RDS database (besides all the 
 underlying structure needed to run it: load balancer, roles, networks, security 
 groups, etc.).

 To create new services on the cluster, check `modules/cluster/main.tf` and follow the 
 same steps used to create the `backend` and `frontend` services: create a new 
 `task-definition json`, a new ECR instance (if needed) and link it on the module 
 definition.
