Config = RbConfig if RUBY_VERSION > '1.9.2' # Hack to allow stuff that isn't compatible with 1.9.3 to work.

require 'bundler/setup'
require 'rake/clean'
require 'rake/testtask'
require 'releasy'

require_relative "lib/planet_defense/version"

CLEAN.include("*.log")
CLOBBER.include("doc/**/*")


Releasy::Project.new do
  name "PlanetDefense"
  version PlanetDefense::VERSION
  executable "bin/planet_defense.rbw"
  files `git ls-files`.split("\n")
  files.exclude %w[.gitignore coverage/**/*.* build/**/*.* spec/**/*.*]
  exclude_encoding

  add_build :osx_app do
    wrapper "../releasy/wrappers/gosu-mac-wrapper-0.7.41.tar.gz"
    url "com.github.addamh.planetdefense"
    add_package :tar_gz
  end

  add_build :source do
    add_package :zip
  end

  add_build :windows_folder do
    executable_type :console # Assuming you don't want it to run in a console window.
    add_package :exe
  end

  add_build :windows_installer do
    readme "README.html"
    add_package :zip
  end
  
  add_build :windows_wrapped do
   wrapper "../releasy/wrappers/ruby-1.9.2-p290-i386-mingw32.7z" # Assuming this is where you downloaded this file.
   executable_type :console # Assuming you don't want it to run in a console window.
   exclude_tcl_tk
   add_package :zip
  end
   
end


task default: :test
