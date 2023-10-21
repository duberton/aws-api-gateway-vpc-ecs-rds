Welcome to the documentation for the project. This repository contains Terraform code for infrastructure, Kotlin for the back-end API, a postman folder with a collection to communicate with the deployed API and last but not least, an OpenAPI 3.0 specification. Please follow the instructions below to get started with this project.

### Getting Started

Follow these steps to provision the infrastructure at AWS:

1. Let's configure the AWS CLI
   1. Download the AWS CLI
      1. https://aws.amazon.com/cli/
   2. Run ```aws configure``` configuring the access key, secret access key, region and default output
   3. Run ```aws s3 ls``` to run a quick little smoke test. No errors, success
2. Now, We're gonna start bringing up the Infrastructure. To bring it all up we need the Terraform binary installed.
   1. https://developer.hashicorp.com/terraform/downloads
4. Provisioning the common/base resources (ECR, IAM etc):
   1. ```cd ./infrastructure/bootstrap```
   2. ```terraform init```
   3. ```terraform apply -auto-approve -var-file ../variables.tfvars```
5. Building the image and pushing to ECR:

Note: replace the UPPER_CASE parts of the text with proper values

- ACCOUNT_ID=AWS account id
- REGION=AWS region
- REPOSITORY=the name of the ECR repository

```shell
docker build -t bands-api .

docker tag bands-api ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/REPOSITORY_NAME:latest

aws ecr get-login-password --region REGION | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/REPOSITORY_NAME

docker push ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/REPOSITORY_NAME:latest
```

6. Provisioning the RDS PostgreSQL database:
   1. ```cd ./infrastructure/db```
   2. ```terraform init```
   3. ```terraform apply -auto-approve -var-file ../variables.tfvars```

7. Provisioning the NLB and the ECS cluster:
   1. ```cd ./infrastructure/app```
   2. ```terraform init```
   3. ```terraform apply -auto-approve -var-file ../variables.tfvars```

8. Provisioning the API Gateway:
   1. ```cd ./infrastructure/gateway```
   2. ```terraform init```
   3. ```terraform apply -auto-approve -var-file ../variables.tfvars```
9. Testing it out
   1. Import the Postman collection in the './postman' folder
   2. Run ```aws apigateway get-rest-apis | jq -r '.items[0].id'```
   3. Go back to the collection, open the Band Env environment and set the api gateway id retrieved above to the *api_gw_id* variable