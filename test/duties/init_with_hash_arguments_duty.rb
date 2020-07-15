class InitWithHashArgumentsDuty < ActiveDuty::Base
  init_with full_name: :name, num: :number
end
