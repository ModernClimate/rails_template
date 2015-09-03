#!/bin/sh

if [ -z "$1" ]
  then
    echo "App name required"
    exit 1
fi

export APP_NAME=$1
export APP_DIR=../$APP_NAME
echo "App name: $APP_NAME"

echo "Creating project directory"
mkdir $APP_DIR
cp -R . $APP_DIR

echo "Cleaning up files"
rm -rf $APP_DIR/.git
rm -rf $APP_DIR/setup.sh

echo "Setup complete.\n\nThis would be a good time to navigate to $APP_DIR and tweak the Ansible files to fit your app's needs.\nWhen you're done, run 'vagrant up development --provider virtualbox --provision' in $APP_DIR."
echo "Creating and provisioning VM"
cd $APP_DIR && vagrant up development --provider virtualbox --provision

exit 0

