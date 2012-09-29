require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  install_prezto
  switch_to_zsh
  replace_all = false
  files = Dir['*'] - %w[Rakefile README.md LICENSE]
  files.each do |file|
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
  install_janus
  install_rbenv
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  elsif file =~ /zshenv|zpreztorc$/
    puts "copying ~/.#{file}"
    system %Q{cp "$PWD/#{file}" "$HOME/.#{file}"}
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

def install_prezto
  if File.exist?(File.join(ENV['HOME'], '.zprezto'))
    puts "found ~/.zprezto"
  else
    print "install prezto? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing prezto"
      system %Q{git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"}
    when 'q'
      exit
    else
      puts "skipping prezto, you will need to change ~/.zshrc"
    end
  end
end

def install_janus
  if File.exist?(File.join(ENV['HOME'], ".vim"))
    puts "found ~/.vim"
  else
    print "install janus? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing janus"
      system %Q{git clone https://github.com/carlhuda/janus.git "$HOME/.vim"}
      system %Q{cd "$HOME/.vim" && rake}
    when 'q'
      exit
    else
      puts "skipping janus"
    end
  end
end

def install_rbenv
  if File.exists?(File.join(ENV['HOME'], ".rbenv"))
    puts "found ~/.rbenv"
  else
    print "install rbenv? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing rbenv"
      system %Q{git clone https://github.com/sstephenson/rbenv.git "$HOME/.rbenv"}
      system %Q{mkdir -p "$HOME/.rbenv/plugins"}
      puts "installing ruby-build"
      system %Q{git clone https://github.com/sstephenson/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"}
      puts "installing rbenv-gemset"
      system %Q{git clone https://github.com/jamis/rbenv-gemset.git "$HOME/.rbenv/plugins/rbenv-gemset"}
    when 'q'
      exit
    else
      puts "skipping rbenv"
    end
  end
end
