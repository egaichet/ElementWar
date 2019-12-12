class Character
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def attack!(foe, ability)
    damage = ability.damage_sample
    damage += ability.damage_sample if ability.quickstrike? && faster?(foe)
    damage *= 2 if ability.critical?
    foe.attributes.hit_points -= damage
    foe.attributes.speed /= 2 if ability.daze?
  end

  def dead?
    @attributes.hit_points < 0
  end

  def faster?(foe)
    @attributes.speed > foe.attributes.speed
  end
end
