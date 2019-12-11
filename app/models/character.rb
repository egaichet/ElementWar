class Character
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def attack!(foe, ability)
    foe.attributes.hit_points -= ability.damage_sample
  end

  def dead?
    @attributes.hit_points < 0
  end

  def faster?(foe)
    @attributes.speed > foe.attributes.speed
  end
end
