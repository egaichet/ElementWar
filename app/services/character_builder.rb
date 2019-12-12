class CharacterBuilder
  class << self
    def build(args)
      Character.new(
        Attributes.new(args[:attributes][:hit_points], args[:attributes][:speed]),
        args[:strikes]
      )
    end

    def hero
      Character.new(
        Attributes.new(100, 60),
        {
          fire_bolt: StrikeBuilder.fire_bolt,
          lightning_bolt: StrikeBuilder.lightning_bolt,
          ice_bolt: StrikeBuilder.ice_bolt
        }
      )
    end

    def minion(hit_points = 50, speed = 50)
      Character.new(
        Attributes.new(hit_points, speed),
        {
          punch: StrikeBuilder.punch,
          double_punch: StrikeBuilder.double_punch
        }
      )
    end
  end
end
