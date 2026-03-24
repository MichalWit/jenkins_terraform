Terraform project
=======
## To allow repo volume
```shell
sudo chown -R 1000:1000 ./test_repo
```


## To create bare repo suitable for gitea
```shell
git config --global --add safe.directory /Users/michal.wit/personalspace/jenkins_terraform/test_repo/./.git
git clone --bare . ../terraform-repo.git
sudo chown -R 1000:1000 terraform-repo.git
```

## To initialize terraform workspace

1. 
```shell

rm -fr /etc/workspace/
mkdir /etc/workspace
ls -la /etc/workspace/

```

2. 
```shell
cat >/etc/workspace/main.tf <<EOL
terraform {
    required_providers {
        local = {
            source  = "hashicorp/local"
            version = "~> 2.0"
         }
    }
}

resource "local_file" "hello" {
    filename = "\${path.module}/hello.txt"
    content  = "hello world from terraform"
}
EOL
```

```shell
docker run --rm -v "/etc/workspace:/workspace" -w /workspace hashicorp/terraform:1.14.7 init
docker run --rm -v "/etc/workspace:/workspace" -w /workspace hashicorp/terraform:1.14.7 plan -out=tfplan
docker run --rm -v "/etc/workspace:/workspace" -w /workspace hashicorp/terraform:1.14.7 apply -auto-approve tfplan
```

## To remove file content / cleanup
```shell
> /etc/workspace/main.tf
```