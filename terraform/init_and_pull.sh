#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/../.env"

git init
git config pull.rebase true
git remote add origin http://localhost:3000/admin/terraform-repo.git
git branch --set-upstream-to=origin/main main