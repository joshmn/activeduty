module ActiveDuty
  module Success
    def success?
      !failure?
    end
  end
end
