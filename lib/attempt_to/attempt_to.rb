

module AttemptTo
  def self.attempt_to(something, amount)
    amount.times { |times|
      begin
        return yield
      rescue Exception => ex
        Kernel.puts "Failed attempt ##{times+1} #{something}. Error message: #{ex.message}"
        if times+1 == amount
          Kernel.puts "Attempted #{amount} times #{something}. Giving up..."
          exit
        end
      end
    }
  end
end

def attempt_to(something, amount, &code_block)
  AttemptTo.attempt_to(something, amount, &code_block)
end