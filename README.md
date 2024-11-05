# Welcome to ECS Demo

## Documentation

### Prerequisites
AWS Account 
Github Account
#### Steps

we will be using us-east-1

have the access keys and secret keys > store in Github Secrets

create the bucket for remote state backend with globally unique name, if different name , change name in provider.tf as well

update the accountid in the variables.tf

add repository secretes as shown in the screenshot with same names, which will be used in our workflow file

1st run the terraform create workflow

2nd one, docker build and push workflow

wait for couple of minutes

go to ec2 LB, access the dns name