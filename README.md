# Provisioning Vault Server on AWS EC2

Instance type: t4g.micro

Instance specs:
- vCPUs: 2
- Memory (GiB): 1 GiB
- On-Demand hourly cost: 0.0084
- 1YR Std reserved hourly cost: 0.0053
- Monthly cost: $4.67

## Usage:

1. Set your AWS credentials as environment variables: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
 
1. If you want to change the instance type set the Terraform variable value in a file named terraform.tfvars

    ```shell
    # EC2 Instance Type
    instance_type = "t4g.micro"
    ```

1. Run Terraform:

    ```shell
    # Pull necessary plugins
    $ terraform init

    $ terraform plan

    $ terraform apply -auto-approve
    ```

1. Run Ansible to provision Vault Server
   
   ```shell
   $ ansible-playbook -i "hosts" provisioning.yml
   ```

1. On the **server** instance, run the following commands:

    ```shell
    # Initialize Vault
    $ vault operator init -stored-shares=1 -recovery-shares=1 \
            -recovery-threshold=1 -key-shares=1 -key-threshold=1 > key.txt
    # Vault should've been initialized and unsealed
    $ vault status
    # Log in with initial root token
    $ vault login $(grep 'Initial Root Token:' key.txt | awk '{print $NF}')
    ```

1. Clean up
    
    ```plaintext
    $ terraform destroy -force
    $ rm -rf .terraform terraform.tfstate* private.key
    ```

