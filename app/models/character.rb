class Character
  attr_reader :attributes, :strikes

  def initialize(attributes, strikes)
    @attributes = attributes
    @strikes = strikes
  end

  def attack!(foe, strike_name)
    strike = @strikes[strike_name]
    damage = strike.damage_sample
    damage += strike.damage_sample if strike.quickstrike? && faster?(foe)
    damage *= 2 if strike.critical?
    foe.attributes.hit_points -= damage
    foe.attributes.speed /= 2 if strike.daze?
  end

  def dead?
    @attributes.hit_points < 0
  end

  def faster?(foe)
    @attributes.speed > foe.attributes.speed
  end

  def ==(character)
    character.is_a?(self.class) && character.object_id == object_id
  end
end
