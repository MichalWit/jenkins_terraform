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