#!/usr/bin/env rake
require 'relapse'

# Relapse generates rake tasks for releases
Relapse::Project.new do |p|
  p.name = "Warp Defender"
  p.version = WarpDefender::VERSION
  p.executable = "bin/alpha_channel.rbw"
  p.files = `git ls-files`.split("\n").reject {|f| f[0] == '.' }
  p.icon = "media/icon.ico"
  p.readme = "README.html"

  p.add_link "http://www.github.com/stderr/warp_defender", "Warp Defender website"

  # Create a variety of releases, for all platforms.
  p.add_output :osx_app do |o|
    o.url = "com.github.stderr.games.warp_defender"
    o.wrapper = "../osx_app/RubyGosu App.app"
    o.gems = Bundler.definition.specs_for([:default]) # Don't want :development gems.
  end
  p.add_output :source
  p.add_output :win32_folder do |o|
    o.ocra_parameters = "--no-enc"
  end
  p.add_output :win32_installer do |o|
    o.ocra_parameters = "--no-enc"
    o.start_menu_group = "Brawlsome Games"
  end

  # Create all packages as zip and 7z archives.
  p.add_archive_format :zip
  p.add_archive_format :'7z'
end

bundler_installed = !!(%x[gem list] =~ /bundler/)

desc "Setup Warp Defender"
task :setup do
  sh %q!gem install bundler! unless bundler_installed
  sh %q!bundle install!

  Dir['config/*.example'].each do |example|
    config = example.gsub(/\.example/, '')
    sh %Q!cp #{example} #{config}! unless File.exists?(config)
  end
  
   puts "Setup finished.\n\n"
end
