#!/usr/bin/env rake

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
