module HelpText

    HELP_PREAMBLE = <<-HELP

The %{package_name} helps build new rails projects according to
Ackmann & Dickenson specifications.

Features include:
* Vagrant-based development
* Ansible provisioning
* Common setup for development, staging, and production

HELP

  HELP_EPILOGUE = <<-HELP

The repository is at <https://github.com/ackmanndickenson/rails_template>.
See the README.md for the repository for more information.

HELP

  NEW_LONG_DESC = <<-LONG_DESC

The command will create a Vagrant and Ansible-provisioned project
skeleton. After the project is created, there are additional steps
to complete the set up:

- Customising the provisioning, if needed

- Creating the VM and provisioning

- Generating the actual rails app inside the VM

Examples:

Creating a new project in the current directory:

$ rails_template new my_rails_app

Creating a new project in another directory:

$ rails_template new other_rails_app --dest=$HOME/Work/

LONG_DESC

  INSTALL_REQ_LONG_DESC = <<-LONG_DESC

This command is normally run within the "new" command, i.e., you
shouldn't have to run it yourself. However, it is available as a
stand-alone command in the case where the ansible requirements
installation fails during the "new" command.  (A particular instance
of failing is if you don't have access to some necessary A&D
repositories.)

Creating and provisioning a new project requires access to the
following A&D repositories:

- https://github.com/ackmann-dickenson/ansible_ruby

- https://github.com/ackmann-dickenson/ansible_common

LONG_DESC

  NEXT_STEPS = <<-BANNER

              --- DONE ---

New Rails project generated in %{app_dir}.

#################################################################################
Next steps:

1. Customize Ansible config for app
   #{ENV['VISUAL'] || ENV['EDITOR'] || 'vim'} %{app_dir}/provisioning

2. Create and provision your VM
   cd %{app_dir} && \\
   vagrant up development --provider virtualbox --provision

3. Instantiate the new project
   vagrant ssh
   > cd %{app_name}/
   > rails new . -m rails_template.rb

#################################################################################

BANNER



end
