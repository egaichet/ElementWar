require 'test_helper'

class CharacterTest < MiniTest::Test
  def setup
    @character = basic_character
  end

  def test_can_attack_another_with_ability
    foe = basic_character

    @character.attack!(foe, punch_ability)

    assert foe.attributes.hit_points < 100
    assert foe.attributes.hit_points >= 88
  end

  def test_can_kill_a_foe
    foe = dying_character

    @character.attack!(foe, punch_ability)

    assert foe.attributes.hit_points < 0
    assert foe.dead?
  end

  def test_character_can_be_faster_than_foe
    assert @character.faster?(slow_character)
  end

  private

  def punch_ability
    Ability.new('Punch', 8..12)
  end

  def basic_character
    CharacterBuilder.build(attributes: { hit_points: 100, speed: 50})
  end

  def dying_character
    CharacterBuilder.build(attributes: { hit_points: 1, speed: 50})
  end

  def slow_character
    CharacterBuilder.build(attributes: { hit_points: 100, speed: 1})
  end
end
