#!/bin/sh

if [ -z "$1" ]
  then
    echo "App name required"
    exit 1
fi

app_name=$1
parent_dir="$(dirname "$dir")"

export app_name
export app_dir=$(dirname $(pwd))/$app_name

echo "\n\n#################################################################################"
echo "Initializing app:           $app_name"

echo "Creating project directory: $app_dir"
mkdir $app_dir
cp -R . $app_dir

echo "Cleaning up files"
rm -rf $app_dir/.git
rm -rf $app_dir/setup.sh

echo "Setup complete"
echo "#################################################################################\n"

echo "\n#################################################################################"

echo "Next steps:\n"

echo "1. Customize Ansible config for app"
echo "   vim $app_dir/provisioning\n\n"

echo "2. Create and provision your VM"
echo "   cd $app_dir && \\"
echo "   vagrant up development --provider virtualbox --provision\n\n"

echo "When provisioning is complete, your Rails app should be running on the guest/VM at http://localhost:3000/"

echo "#################################################################################\n\n"

exit 0

