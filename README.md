# New project setup
Clone the A&D [Rails template](https://github.com/ackmann-dickenson/ansible_rails) repo, if you haven't already done so, and pull down latest changes:
```
git clone git@github.com:ackmann-dickenson/ansible_rails.git
cd ansible_rails
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
