class FirstJob < ApplicationJob
  queue_as :default

  def perform
    puts "Hello Abhijit"
  end
end