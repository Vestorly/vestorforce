module Vestorforce
  class BaseMapper
    def self.map
      Proc.new { |item| item }
    end
  end
end
