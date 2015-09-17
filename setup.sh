#!/bin/sh

if [ -z "$1" ]
  then
    echo "App name required"
    exit 1
fi

app_name=$1

export app_name
export app_dir=$(dirname $(pwd))/$app_name

echo "\n\n#################################################################################"
echo "Initializing app:           $app_name"
echo "Creating project directory: $app_dir"
mkdir $app_dir
cp -R . $app_dir

echo "Creating bin files"
echo "ansible-playbook --inventory-file=provisioning/inventories/\$app_name --user root --ask-pass --ask-vault-pass --extra-vars '{\"app_name\":\"$app_name\"}' -vvvv provisioning/bootstrap.yml" > $app_dir/provisioning/bin/bootstrap
echo "ansible-playbook --inventory-file=provisioning/inventories/\$app_name --user deploy --sudo --ask-vault-pass --extra-vars '{\"app_name\":\"$app_name\"}' -vvvv provisioning/site.yml" > $app_dir/provisioning/bin/configure
echo "ansible-playbook --inventory-file=provisioning/inventories/\$app_name --user deploy --ask-vault-pass --extra-vars '{\"app_name\":\"$app_name\"}' -vvvv provisioning/deploy.yml" > $app_dir/provisioning/bin/deploy
chmod 755 $app_dir/provisioning/bin/bootstrap
chmod 755 $app_dir/provisioning/bin/configure
chmod 755 $app_dir/provisioning/bin/deploy

echo "Generating Vagrantfile"
touch $app_dir/Vagrantfile
sed "s/__APP_NAME__/$app_name/g" $app_dir/Vagrantfile.template > $app_dir/Vagrantfile
rm $app_dir/Vagrantfile.template

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
echo "   vagrant up development --provider virtualbox --provision"
echo "#################################################################################\n\n"

exit 0

