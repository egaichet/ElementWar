class Ability
  def initialize(name, damage, debuff = nil)
    @name = name
    @damage = damage
    @debuff = debuff
  end

  def damage_sample
    @damage.to_a.sample
  end

  def daze?
    @debuff && @debuff == :daze
  end
end
