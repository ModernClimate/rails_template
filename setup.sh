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

echo "Creating bin files"
echo "ansible-playbook --inventory-file=provisioning/inventories/staging --user root --ask-pass --ask-vault-pass --extra-vars '{\"app_name\":\"$app_name\"}' -vvvv provisioning/bootstrap.yml" > $app_dir/provisioning/bin/bootstrap-staging
echo "ansible-playbook --inventory-file=provisioning/inventories/staging --user deploy --sudo --ask-vault-pass --extra-vars '{\"app_name\":\"$app_name\"}' -vvvv provisioning/site.yml" > $app_dir/provisioning/bin/provision-staging
echo "ansible-playbook --inventory-file=provisioning/inventories/staging --user deploy --sudo --ask-vault-pass --extra-vars '{"app_name":"natcam_data_service"}' -vvvv provisioning/deploy.yml" > $app_dir/provisioning/bin/deploy-staging
chmod 755 $app_dir/provisioning/bin/bootstrap-staging
chmod 755 $app_dir/provisioning/bin/provision-staging
chmod 755 $app_dir/provisioning/bin/deploy-staging
echo "ansible-playbook --inventory-file=provisioning/inventories/production --user root --ask-pass --ask-vault-pass --extra-vars '{\"app_name\":\"$app_name\"}' -vvvv provisioning/bootstrap.yml" > $app_dir/provisioning/bin/bootstrap-production
echo "ansible-playbook --inventory-file=provisioning/inventories/production --user deploy --sudo --ask-vault-pass --extra-vars '{\"app_name\":\"$app_name\"}' -vvvv provisioning/site.yml" > $app_dir/provisioning/bin/provision-production
echo "ansible-playbook --inventory-file=provisioning/inventories/production --user deploy --sudo --ask-vault-pass --extra-vars '{"app_name":"natcam_data_service"}' -vvvv provisioning/deploy.yml" > $app_dir/provisioning/bin/deploy-production
chmod 755 $app_dir/provisioning/bin/bootstrap-production
chmod 755 $app_dir/provisioning/bin/provision-production
chmod 755 $app_dir/provisioning/bin/deploy-production

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

