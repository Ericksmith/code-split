class ApplicationJob < ActiveJob::Base
  def perform
    puts 'perform'
  end
end
