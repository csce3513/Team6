AD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec'
require 'PlanetDefense/require_all'

require 'chingu'

def media_path(file)
    File.join($window.root, "..", "..", "classes", "fonts","gfx","sounds" file)
end

if defined?(Rcov)
    # all_app_files = Dir.glob('lib/**/*.rb')
  #   # all_app_files.each{|rb| require rb}
  #   end
  #
end
end

