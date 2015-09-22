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

if [ -d $app_dir ]
  then
    echo "\n\nError: Project directory $app_dir already exists\n"
    exit 1
fi

mkdir $app_dir
cp -R ./skeleton/* $app_dir

echo "Creating bin files"
bin_files=( bootstrap configure deploy )
for file in "${bin_files[@]}"
do
  touch $app_dir/provisioning/bin/$file
  sed "s/__APP_NAME__/$app_name/g" $app_dir/provisioning/bin/$file.template > $app_dir/provisioning/bin/$file
  chmod 755 $app_dir/provisioning/bin/$file
  rm $app_dir/provisioning/bin/$file.template
done

echo "Creating Vagrantfile"
touch $app_dir/Vagrantfile
sed "s/__APP_NAME__/$app_name/g" $app_dir/Vagrantfile.template > $app_dir/Vagrantfile
rm $app_dir/Vagrantfile.template

echo "Creating Rails template file"
touch $app_dir/rails_template.rb
sed "s/__APP_NAME__/$app_name/g" $app_dir/rails_template.rb.template > $app_dir/rails_template.rb
rm $app_dir/rails_template.rb.template

echo "Creating README.md"
touch $app_dir/README.md
sed "s/__APP_NAME__/$app_name/g" $app_dir/README.md.template > $app_dir/README.md
rm $app_dir/README.md.template

echo "Cleaning up files"
rm -rf $app_dir/.git
rm -rf $app_dir/setup.sh

echo "Install Ansible dependencies"
cd $app_dir/provisioning/roles && ansible-galaxy install -r requirements.yml --force

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

