# Testing Terraform Modules with Kitchen and Inspec 

## Prequistes

1. GCP Account (https://cloud.google.com/free/)
2. Terraform (Consider using https://github.com/tfutils/tfenv)
3. Ruby with bundler. (Consider using https://github.com/rbenv/rbenv)
4. gcloud cli sdk. (https://cloud.google.com/sdk/docs/quickstarts)


## How to work the example. 

1. Sign up For a Free GCP Account.
2. Install gcloud cli and login using configuration. Use application default credentials or service account credentials.

```gcloud auth application-default login```

3. Set the requried project as shown below. This project is where the cloud function would be created.

```export GOOGLE_PROJECT=<google_project>```

4. To install the required gems run the below command. Make sure you have ruby installed.
```bundle install```

5. To run the kitchen tests and run the required inspec tests.
```bundle exec kitchen test```


## Commands
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
bundle install
bundle exec kitchen create
bundle exec kitchen converge
bundle exec kitchen list
bundle exec kitchen destroy
```

```
bundle exec kitchen test
```

To autogenerate inspec profile
```
inspec init profile --platform gcp <profile_name>
```

## Try Next
1. Try multiple inspec resource and terraform resources.
2. Try integrations with chef, puppet and Ansible.
3. Try using terraform registry modules with inspec. Don't repeat your self.
