# HUG Meetup Sept 2019
## Testing Terraform Modules with Kitchen and Inspec
## HUG MeetUp Sept
### Cheat Cheet

Terraform
```
terraform init
terraform workspace new demo
terraform workspace select demo
terraform plan
terraform apply
terrafrom destroy
```

Kitchen CI
```
bundle exec kitchen create
bundle exec kitchen converge
bundle exec kitchen list
bundle exec kitchen destroy
```

```
bundle exec kitchen test
```

Inspec
```
inspec init profile --platform gcp <profile_name>
```
