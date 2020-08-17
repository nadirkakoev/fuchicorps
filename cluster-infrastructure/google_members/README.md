# IAM & ADMIN 
_That code will add whatever user u want with following roles attached_ 
1. Compute Admin
2. Compute Storage Admin
3. Kubernetes Engine Admin
4. DNS Administrator

## VERSIONS
Terraform v0.11.14
provider.google v2.12.0
  
## Usage
In order for that code to run, ur service account must be present in that directory 
rename ur service account to fuchicorp_service_account.json or put urs under provider.tf 
and also add .tfvars file 
In case u get an error, go to  ur GOOGLE UI and enable iam API manually (u get link for that)

## EXAMPLE
google_project_id = "…”
members = ["@gmail.com", "@gmail.com"]

![](README/Screenshot%202020-04-02%20at%2012.46.14.png)








