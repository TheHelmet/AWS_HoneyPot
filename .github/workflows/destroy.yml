name: Terraform Destroy

on:
  workflow_dispatch:

jobs:
  destroy:
    runs-on: ubuntu-latest
 
    steps:
    - name: Checkout Repository
      uses: actions/checkout@v2

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v1

    - name: Configure AWS Credentials
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_KEY }}
        aws-region: ap-southeast-2

    - name: Terraform Init
      run: terraform init 

    - name: Terraform Destroy
      run: terraform destroy -auto-approve 
