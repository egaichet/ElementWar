require 'test_helper'

class GameHandlerTest < MiniTest::Test
  def setup
    @console = Minitest::Mock.new
    @game_handler = GameHandler.new(@console)
  end

  def test_storm_elemental_can_speak
    @console.expect :write, nil, ['Storm Elemental - Hello !']

    @game_handler.storm_elemental_speaks('Hello !')

    @console.verify
  end

  def test_can_give_means_to_user
    @console.expect :ask, 'left', [['left', 'right', 'exit']]

    selected = @game_handler.give_means_to_user(['left', 'right'])

    assert_equal 'left', selected
    @console.verify
  end

  def test_can_raise_exit_error_if_exit_selected
    @console.expect :ask, 'exit', [['exit']]

    assert_raises Exit do
       @game_handler.give_means_to_user([])
    end
  end

  def test_can_say_bye
    @console.expect :write, nil, [String]
    verify_game_handler_method_called(:storm_elemental_speaks, nil, [String]) do
      @game_handler.bye!
    end
    @console.verify
  end

  def test_can_say_died
    @console.expect :write, nil, [String]
    verify_game_handler_method_called(:storm_elemental_speaks, nil, [String]) do
      @game_handler.died!
    end
    @console.verify
  end

  def test_can_say_won
    @console.expect :write, nil, [String]
    verify_game_handler_method_called(:storm_elemental_speaks, nil, [String]) do
      @game_handler.won!
    end
    @console.verify
  end

  def test_hero_go_to_center_after_start
    @console.expect :write, nil, [String, String, String, String]

    verify_game_handler_method_called(:go_to_center!, nil, []) do
      @game_handler.start!
    end
  end

  def test_hero_is_asked_where_to_go_after_going_to_center_then_fight_in_new_room
    @console.expect :write, nil, ["Choose a room (left/middle/right)"]
    @console.expect :ask, 'left', [['left', 'middle', 'right', 'exit']]

    verify_game_handler_method_called(:fight_in!, nil, ['left']) do
      @game_handler.go_to_center!
    end
    @console.verify
  end

  def test_hero_can_fight_in_room
    @game_handler.fight_in!('left')

    assert @game_handler.fight
  end

  private

  def verify_game_handler_method_called(method, return_value, args)
    mocked_method = MiniTest::Mock.new
    mocked_method.expect :call, return_value, args
    @game_handler.stub method, mocked_method do
      yield
    end
    mocked_method.verify
  end
end
