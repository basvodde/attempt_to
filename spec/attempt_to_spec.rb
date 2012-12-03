
require 'attempt_to'
require 'socket'

describe "Attempt to do something a couple of times, if it fails, bail out." do

  before(:each) {
    @attempts = 0
  }

  it "calls the block only once when it succeeds" do
    attempt_to("do this", 3) {
      @attempts += 1
    }
    @attempts.should == 1
  end

  it "returns whatever the code block returns" do
    attempt_to("to do this", 2) {
      "returns"
    }.should == "returns"
  end
  
  it "calls the block multiple times when it fails " do
    Kernel.should_receive(:puts).with("Failed attempt #1 to do something. Error message: wrong 1")
    attempt_to("to do something", 3) {
      @attempts += 1
      raise(Exception, "wrong #{@attempts}") if @attempts == 1
    }
    @attempts.should == 2
  end
  
  it "bails out aften the maximum amount of attempts" do
    Kernel.should_receive(:puts).exactly(3).times
    Kernel.should_receive(:puts).with("Attempted 3 times to do this. Giving up...")
    lambda {
      attempt_to("to do this", 3) {
        @attempts += 1
        raise(Exception, "wrong!")
      }
    }.should raise_error(SystemExit)
    
    @attempts.should == 3
  end
  
  # it "Can run the example code" do
  #   attempt_to('connect to the network', 3) {
  #     TCPSocket.new("some.very.weird.domain.name", 9342)
  #   }
  #   
  # end
    
end
