require 'spec_helper'

require 'player'

describe Player do
   it 'successfully creates a new player object' do
     player = Player.new(self) 
     player.should be_valid
   end
end
