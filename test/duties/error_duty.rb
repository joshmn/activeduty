class ErrorDuty < ActiveDuty::Base
  def call
    self.errors.add(:base, "is invalid")
  end
end
