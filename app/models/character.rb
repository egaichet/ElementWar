class Character
  attr_accessor :hit_points

  def initialize(hit_points)
    @hit_points = hit_points
  end

  def attack(foe, ability)
    foe.hit_points -= ability.damage_sample
  end
end
