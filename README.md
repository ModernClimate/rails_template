# README

### Host Machine Requirements

- **Ansible**
  - `brew install ansible`
  - *Last tested on version 1.9.2*
- **VirtualBox**
  - [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
  - *Last tested on version 5.0.2*
- **Vagrant**
  - [http://www.vagrantup.com/downloads](http://www.vagrantup.com/downloads)
  - *Last tested on version 1.7.4*
- **Vagrant VirtualBox Guest Additions Plugin**
  - `vagrant plugin install vagrant-vbguest`
  - *Last tested on version 0.10.0*

### New Project Setup

Clone the A&D [Rails template](https://github.com/ackmann-dickenson/rails_template) repo, if you haven't already done so, and pull down latest changes:
```
git clone git@github.com:ackmann-dickenson/rails_template.git
cd rails_template
git pull
```
Generate the new project skeleton:
```
./setup.sh your_snake_case_project_name
```

Configure Ansible as needed in `your_snake_case_project_name/provisioning` and provision development VM:
```
cd ../your_snake_case_project_name
vagrant up
vagrant ssh
```

Generate new Rails app from template and start up Rails server:
```
cd /home/vagrant/your_snake_case_project_name
rails new . -m rails_template.rb
rails s
```

Then navigate to [http://localhost:3001](http://localhost:3001) to confirm you can connect to your VM/Rails instance. You should see the standard Rails "Welcome aboard" page in your browser.

If everything looks good, create a [new repo on GitHub](https://github.com/organizations/ackmann-dickenson/repositories/new), commit your code, and publish to GitHub:
```
git init
git commit -m "first commit"
git remote add origin git@github.com:ackmann-dickenson/your_snake_case_project_name.git
git push -u origin master
```

### Provisioning Staging/Production Servers

After the project has been pushed to GitHub you can bootstrap, configure, and deploy to the staging and production servers. **The steps below assume you're setting up the `staging` inventory.** If you're setting up a different inventory, simply replace `staging` with the name of your inventory (eg: `production`).

First, you'll need to create the remove server(s). The project is currently *not* configured to create remote servers so you'll need to create the servers through Rackspace's (or other provider's) [web interface](https://mycloud.rackspace.com). **Be sure to copy down your new server's IP address and root password as you'll need them in the next step!**

After the new server is created and available, add the server's IP address to the appropriate Ansible inventory file:
```
vim your_snake_case_project_name/provisioning/inventories/staging
```

Next, run the `provisioning/bin/bootstrap` shell script to bootstrap the server, passing the script the name of the inventory you're bootstrapping:
```
cd your_snake_case_project_name
./provisioning/bin/bootstrap staging
```

Bootstrapping the server will create a new `deploy` user, copy your `~/.ssh/id_rsa.pub` file to the `deploy` user's authorized keys file, remove root SSH access, disable SSH password authentication, and perform basic firewall configuration.

At this point, you should test that you're able to SSH into the remote server:
```
ssh deploy@your_ip_address
```

Now configure the server by running the `provisioning/bin/configure` shell script:
```
./provisioning/bin/configure staging
```

Finally, deploy your project to the server by running the `provisioning/bin/deploy` shell script:
```
./provisioning/bin/deploy staging
```
