class StrikeBuilder
  class << self
    def punch
      Strike.new(8..12)
    end

    def double_punch
      Strike.new(6..10, :quickstrike)
    end

    def lightning_bolt
      Strike.new(20..40, :quickstrike)
    end

    def fire_bolt
      Strike.new(25..35, :critical)
    end

    def ice_bolt
      Strike.new(30..35, :daze)
    end
  end
end
