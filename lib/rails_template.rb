require "thor"
require "help_text" # long swaths of text, to keep this file cleaner

class RailsTemplate < Thor

  include Thor::Actions

  PACKAGE_NAME = "Rails New Project Generator"
  self.package_name PACKAGE_NAME

  ###############
  #             #
  # NEW COMMAND #
  #             #
  ###############

  desc "new PROJECT_NAME [OPTIONS]", "Create a new rails project"
  long_desc HelpText::NEW_LONG_DESC
  def new(name)
    task_init(name, options)
    directory "skeleton", @app_dir
    invoke :install_reqs
  end

  #######################
  #                     #
  # INSTALL_REQ COMMAND #
  #                     #
  #######################

  desc "install_reqs PROJECT_NAME [OPTIONS]", "Install ansible requirements"
  long_desc HelpText::INSTALL_REQ_LONG_DESC

  def install_reqs(name, cmd: "ansible-galaxy install -r requirements.yml --force")
    task_init(name, options)
    run_in_dir(
      dir: File.join(@app_dir, "provisioning", "roles"),
      cmd: cmd
      )
    say_next_steps
  end

  ################
  #              #
  # HELP COMMAND #
  #              #
  ################

  def self.help(shell, subcommand = false)
    shell.say HelpText::HELP_PREAMBLE % {package_name: PACKAGE_NAME}, :blue
    super
    shell.say HelpText::HELP_EPILOGUE, :blue
  end

  #------------------------------------------------------------------------#

  #############################
  #                           #
  # Class Methods and Options #
  #                           #
  #############################

  def self.source_root
    File.expand_path("../../", __FILE__)
  end

  class_option :dest, desc: "Destination folder for the new project, e.g. '~/Projects/'", type: :string, aliases: "-d", default: ".", banner: "DIR"


  #------------------------------------------------------------------------#

  private

  def run_in_dir(dir:, cmd:)
    (say("No such directory: #{dir}", :red) && exit(-1)) unless File.exist? dir

    Dir.chdir dir do
      run cmd
      (say("Anisible install failed", :red) && exit(-1)) unless $? == 0
    end
  end

  # Just to DRY up setting instance variables.
  def task_init(name, options)
    @app_name = name
    @dest = File.expand_path(options.fetch("dest"))
    @app_dir = File.join(@dest, @app_name)
    @app_abbr = abbreviate(@app_name)
  end

  def say_next_steps
    say HelpText::NEXT_STEPS % {app_dir: @app_dir, app_name: @app_name}, :green
  end

  # Used to create a prefix for environment variables, e.g. 'your_cool_app' => 'YCA'
  def abbreviate(name)
    name.split(/_/).map{|w| w[0]}.join.upcase
  end


end
