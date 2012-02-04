require 'spec_helper'

require_relative '../../lib/planet_defense/player'
require_relative '../../lib/planet_defense/play_state'
require_relative '../../lib/planet_defense/main'

describe PlanetDefense do
  
  before(:all) do
    @g = PlanetDefense.new
  end

  it { @g.should respond_to :close }
  it { @g.should respond_to :fps }
  it { @g.should respond_to :update }
  it { @g.should respond_to :draw }
  it { @g.should respond_to :root }
  it { @g.should respond_to :game_state_manager }
  it { @g.should respond_to :factor }
  it { @g.should respond_to :cursor }
  it { @g.should respond_to :root }
  it { @g.should respond_to :milliseconds_since_last_tick }
  
  it 'Window should be initialized' do
    @g.should be_kind_of(PlanetDefense)
  end
  
  it 'Window should have correct dimensions' do
    @g.width.should == 1024
    @g.height.should == 768
  end
end
