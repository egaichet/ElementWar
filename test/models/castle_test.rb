require 'test_helper'

class CastleTest < MiniTest::Test
  def test_can_populate_castle_rooms
    castle = Castle.new([foe, foe, foe])

    assert_equal ['left', 'middle', 'right'], castle.available_rooms
  end

  def test_room_with_dead_character_is_not_available
    castle = Castle.new([dead_foe, foe, foe])

    assert_equal ['middle', 'right'], castle.available_rooms
  end

  def test_can_give_foe_at_position
    expected = foe
    castle = Castle.new([expected, foe, foe])

    assert_equal expected, castle.foe_at('left')
  end

  def test_hero_is_at_center_at_beginning
    castle = Castle.new([])

    assert_equal 'center', castle.current_room
  end

  def test_hero_can_move
    castle = Castle.new([])

    castle.hero_move_to!('left')

    assert_equal 'left', castle.current_room
  end

  private

  def foe
    CharacterBuilder.build(attributes: { hit_points: 50, speed: 50})
  end

  def dead_foe
    CharacterBuilder.build(attributes: { hit_points: 0, speed: 50})
  end
end
