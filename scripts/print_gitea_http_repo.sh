#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sh "$SCRIPT_DIR/print_urls_json.sh" | jq -r '.http.gitea'
