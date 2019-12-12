class CharacterBuilder
  class << self
    def build(args)
      Character.new(
        Attributes.new(args[:attributes][:hit_points], args[:attributes][:speed]),
        args[:strikes]
      )
    end
  end
end
