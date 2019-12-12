require 'test_helper'

class CharacterTest < MiniTest::Test
  def setup
    @character = basic_character
  end

  def test_can_attack_another_with_ability
    foe = basic_character

    @character.attack!(foe, :punch)

    assert foe.attributes.hit_points < 100
    assert foe.attributes.hit_points >= 88
  end

  def test_can_kill_a_foe
    foe = dying_character

    @character.attack!(foe, :punch)

    assert foe.attributes.hit_points < 0
    assert foe.dead?
  end

  def test_character_can_be_faster_than_foe
    assert @character.faster?(slower_character)
  end

  def test_character_can_daze_foe
    foe = faster_character

    @character.attack!(foe, :daze)

    assert @character.faster?(foe)
  end

  def test_daze_halves_foe_speed
    foe = faster_character

    @character.attack!(foe, :daze)

    assert_equal 30, foe.attributes.speed
  end

  def test_critical_has_fifty_percent_chance_to_double_damage
    foe = basic_character

    @character.strikes[:critical].stub :rand, 0.5 do
      @character.attack!(foe, :critical)
    end

    assert_equal 80, foe.attributes.hit_points
  end

  def test_critical_has_fifty_percent_chance_to_deal_normal_damage
    foe = basic_character

    @character.strikes[:critical].stub :rand, 0.49 do
      @character.attack!(foe, :critical)
    end

    assert_equal 90, foe.attributes.hit_points
  end

  def test_faster_character_quickstrike_hit_one_more_time
    foe = slower_character

    @character.attack!(foe, :quickstrike)

    assert_equal 80, foe.attributes.hit_points
  end

  def test_slower_character_quickstrike_hit_normally
    foe = faster_character

    @character.attack!(foe, :quickstrike)

    assert_equal 90, foe.attributes.hit_points
  end

  private

  def basic_character
    CharacterBuilder.build(
      attributes: { hit_points: 100, speed: 50 },
      strikes: {
        punch: punch_ability,
        daze: daze_ability,
        critical: critical_ability,
        quickstrike: quickstrike_ability
      }
    )
  end

  def punch_ability
    Ability.new('Punch', 8..12)
  end

  def daze_ability
    Ability.new('Daze', 0..0, :daze)
  end

  def critical_ability
    Ability.new('Critical', 10..10, :critical)
  end

  def quickstrike_ability
    Ability.new('Quickstrike', 10..10, :quickstrike)
  end

  def dying_character
    CharacterBuilder.build(attributes: { hit_points: 1, speed: 50})
  end

  def slower_character
    CharacterBuilder.build(attributes: { hit_points: 100, speed: 40})
  end

  def faster_character
    CharacterBuilder.build(attributes: { hit_points: 100, speed: 60})
  end
end
