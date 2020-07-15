require "active_duty/version"

require "active_support"
require "active_model"

module ActiveDuty
  Failure = Class.new(StandardError)

  extend ActiveSupport::Autoload
  autoload :Base
  autoload :Job

  mattr_accessor :job_queue
  self.job_queue = :active_duty

  mattr_accessor :job_parent_class
  self.job_parent_class = 'ActiveJob::Base'

end
