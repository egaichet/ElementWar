class Ability
  def initialize(name, damage, bonus = nil)
    @name = name
    @damage = damage
    @bonus = bonus
  end

  def damage_sample
    @damage.to_a.sample
  end

  def daze?
    @bonus == :daze
  end

  def critical?
    @bonus == :critical && rand >= 0.5
  end
end
