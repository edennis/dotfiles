require 'rake'
require 'yaml'
require 'erb'

desc "install the dot files into user's home directory"
task :install => :copy_files do
  load_secrets
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
        puts "identical ~/.#{file.sub('.erb', '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub('.erb', '')}"
        end
      end
    else
      link_file(file)
    end
  end
end

desc "recursively copies copy/* to the user's home directory"
task :copy_files do
  system("cp -r copy/* #{ENV['HOME']}")
end

task :default => :install

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def load_secrets
  return unless File.exists? '.secrets.yml'
  YAML.load_file('.secrets.yml').each_pair do |k,v|
    instance_variable_set "@#{k}", v
  end
end