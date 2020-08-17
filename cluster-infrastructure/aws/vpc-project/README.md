# Cluster VPC set up on AWS
#fuchicorp


This Repo creates a VPC in us-east-1 region.

#### Deployment Tested with following versions:
terraform 0.11.14
awscli 3.10

#### providers
aws ~> 2.54


#### Before you begin
In order for this code to work, you will have to create user in your AWS account, once user is created you will be provided with access and secret key, please make sure you either save it or download it!
Next you will have to update you access and secret key in `.aws/credentials`
Also create manually bucket in your AWS account, and update the bucket name in backend.tf 

To be able to create bucket use following command if you have `aws` cli on your local. Also you will need to create dynamoDB
```
aws s3 mb s3://fuchicorp
```


## Deployment of VPC
Run the `setenv.sh` script to get backend dynamically set up. The script will create also $DATAFILE location off the configuration

```
source setenv.sh configurations/us-east-1/vpc.tfvars
```


This command will set your environment, download all the plugins  and initialize a backend `s3`
```
terraform  apply -var-file=$DATAFILE
```


This command will create 24 resources all needed for an infrastructure such as vpc, with public and private subnets, nat gateway, internet gateway with security groups and DynamoDB.

