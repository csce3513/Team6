require_relative "../rspec_helper"

describe "Window" do
  before :each do 
    @game = Chingu::Window.new
  end

  after :each do 
    @game.close
  end

  context "a new PlanetDeense window" do
    it "should return itself as the current scope" do
      pending "Need to build this test"
    end
  end
end
