Config = RbConfig if RUBY_VERSION > '1.9.2' # Hack to allow stuff that isn't compatible with 1.9.3 to work.

require 'bundler/setup'
require 'rake/clean'
require 'rake/testtask'
require 'releasy'


CLEAN.include("*.log")
CLOBBER.include("doc/**/*")


Releasy::Project.new do
  name "PlanetDefense"
  version '0.0.1'
  executable "main.rb"
  files `git ls-files`.split("\n")
  files.exclude %w[.gitignore build/**/*.* spec/**/*.*]
  exclude_encoding

  add_build :osx_app do
    wrapper "../releasy/wrappers/gosu-mac-wrapper-0.7.41.tar.gz"
    url "com.github.addamh.planetdefense"
    icon "media/icon.icns"
    add_package :tar_gz
  end

  add_build :source do
    add_package :zip
  end

  add_build :windows_folder do
    icon "media/icon.ico"
    add_package :exe
  end

  add_build :windows_installer do
    icon "media/icon.ico"
    start_menu_group "Spooner Games"
    readme "README.html"
    add_package :zip
  end

end


task default: :test
