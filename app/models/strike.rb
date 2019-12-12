class Strike
  def initialize(damage, bonus = nil)
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

  def quickstrike?
    @bonus == :quickstrike
  end
end
