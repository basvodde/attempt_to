

module AttemptTo
  def self.attempt_to(something, amount)
    amount.times { |times|
      begin
        return yield
      rescue Exception => ex
        Kernel.puts "Failed attempt ##{times+1} to #{something}. Error message: #{ex.message}"
        if times+1 == amount
          Kernel.puts "Attempted #{amount} times to #{something}. Giving up..."
          exit
        end
      end
    }
  end

  def self.attempt_to_with_timeout(seconds)
    Timeout::timeout(seconds) {
      success = false
      while not success
        begin
          success = yield
        rescue Exception
        end
      end
    }
  end
end

def attempt_to(something, amount, &code_block)
  AttemptTo.attempt_to(something, amount, &code_block)
end

def attempt_to_with_timeout(seconds, &code_block)
  AttemptTo.attempt_to_with_timeout(seconds, &code_block)
end
