require 'test_helper'

class CharacterTest < MiniTest::Test
  def setup
    @character = Character.new(100)
  end

  def test_character_can_attack_another_with_ability
    foe = Character.new(100)
    punch = Ability.new('Punch', 8..12)

    @character.attack(foe, punch)

    assert foe.hit_points < 100
    assert foe.hit_points >= 88
  end
end
