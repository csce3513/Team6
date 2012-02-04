require 'spec_helper'

require_relative '../../lib/planet_defense/player'
require_relative '../../lib/planet_defense/play_state'
require_relative '../../lib/planet_defense/main'

describe PlanetDefense do
  
  before(:all) do
    @g = PlanetDefense.new
  end
  
  it 'Window should be initialized' do
    @g.should be_kind_of(PlanetDefense)
  end
  
  it 'Window should have correct dimensions' do
    @g.width.should == 1024
    @g.height.should == 768
  end
end
