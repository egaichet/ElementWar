require 'test_helper'

class FightTest < MiniTest::Test
  def setup
    @hero = CharacterBuilder.hero
    @foe = CharacterBuilder.minion
  end

  def test_start_at_turn_1
    fight = Fight.new(@hero, @foe)

    assert_equal 1, fight.turn
    refute fight.finished?
    refute fight.turn_finished?
  end

  def test_faster_character_start
    fight = Fight.new(@hero, @foe)

    assert_equal @hero, fight.fighter
  end

  def test_fighter_can_play
    fight = Fight.new(@hero, @foe)

    fight.play!(@hero, 'ice_bolt')

    assert @foe.attributes.hit_points < 50
    assert @foe.attributes.speed < 50
  end

  def test_cannot_use_unknow_ability
    fight = Fight.new(@hero, @foe)

    assert_raises{ fight.play!(@hero, 'lava_storm') }
  end

  def test_foe_play_after_hero
    fight = Fight.new(@hero, @foe)

    fight.play!(@hero, 'ice_bolt')

    assert_equal @foe, fight.fighter
    refute fight.turn_finished?
  end

  def test_turn_is_finished_after_both_figther_played
    fight = Fight.new(@hero, @foe)

    fight.play!(@hero, 'ice_bolt')
    fight.play!(@foe, 'punch')

    assert fight.turn_finished?
  end

  def test_can_start_new_turn
    fight = Fight.new(@hero, @foe)
    fight.play!(@hero, 'ice_bolt')
    fight.play!(@foe, 'punch')

    fight.new_turn!

    assert_equal 2, fight.turn
    refute fight.turn_finished?
  end

  def test_can_finish_fight
    fight = Fight.new(@hero, @foe)

    2.times do
      fight.play!(@hero, 'ice_bolt')
      fight.play!(@foe, 'punch')
      fight.new_turn!
    end

    assert fight.finished?
  end
end
