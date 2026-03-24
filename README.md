Terraform project
=======

## (re)build and run

### ALL
```shell
./scripts/rebuild_run_and_push.sh
```

### Only gitea
```shell
./scripts/rebuild_run_and_push.sh gitea
```

## To initialize terraform workspace (inside jenkins server)

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