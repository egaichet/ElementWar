class Ability
  def initialize(name, damage)
    @name = name
    @damage = damage
  end

  def damage_sample
    @damage.to_a.sample
  end
end
