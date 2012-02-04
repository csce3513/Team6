require 'spec_helper'

require_relative '../../lib/planet_defense/player'
require_relative '../../lib/planet_defense/play_state'
require_relative '../../lib/planet_defense/main'

describe PlanetDefense do
  
  before(:each) do
    @g = PlanetDefense.new
  end
  
   it 'should have set dimensions' do
     @g.width.should == 1024
     @g.height.should == 768
   end
end
