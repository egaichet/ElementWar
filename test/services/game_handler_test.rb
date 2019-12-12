require 'test_helper'

class GameHandlerTest < MiniTest::Test
  class FakeConsole
    attr_accessor :written, :asked, :mean

    def initialize
      @written = []
      @asked = []
    end

    def write(*sentences)
      @written.concat(sentences)
    end

    def ask(means)
      @asked.push(means)
      @mean
    end
  end

  def setup
    @console = FakeConsole.new
    @game_handler = GameHandler.random_minions_and_boss_anywhere(@console)
  end

  def test_storm_elemental_can_speak
    @game_handler.storm_elemental_speaks('Hello !')

    assert_equal 'Storm Elemental - Hello !', @console.written.first
  end

  def test_can_give_means_to_user
    @console.mean = 'left'

    selected = @game_handler.give_means_to_user(['left', 'right'])

    assert_equal ['left', 'right', 'exit'], @console.asked.first
    assert_equal 'left', selected
  end

  def test_can_raise_exit_error_if_exit_selected
    @console.mean = 'exit'

    assert_raises Exit do
       @game_handler.give_means_to_user([])
    end
  end

  def test_can_say_bye
    verify_method_called(@game_handler, :storm_elemental_speaks, nil, [String]) do
      @game_handler.bye!
    end
  end

  def test_hero_go_to_center_after_start
    verify_method_called(@game_handler, :go_to_center!, nil, []) do
      @game_handler.start!
    end
  end

  def test_hero_is_asked_where_to_go_after_going_to_center_then_fight_in_new_room
    @console.mean = 'left'

    verify_method_called(@game_handler, :fight_in!, nil, ['left']) do
      @game_handler.go_to_center!
    end
    refute @console.written.empty?
  end

  def test_hero_can_kill_minion_and_go_to_center
    @console.mean = 'fire_bolt'
    game_handler = GameHandler.new(
      CharacterBuilder.hero,
      CharacterBuilder.boss,
      castle_full_of_minion,
      @console
    )

    verify_method_called(game_handler, :go_to_center!, nil, []) do
      game_handler.fight_in!('left')
    end

    assert game_handler.castle.current_foe.dead?
  end

  def test_hero_can_kill_boss_and_win
    @console.mean = 'fire_bolt'
    boss = CharacterBuilder.boss(30)
    game_handler = GameHandler.new(
      CharacterBuilder.hero,
      boss,
      castle_with_boss_at_left(boss),
      @console
    )

    game_handler.fight_in!('left')

    assert boss.dead?
  end

  def test_hero_can_be_killed
    @console.mean = 'fire_bolt'
    boss = CharacterBuilder.boss(300)
    game_handler = GameHandler.new(
      CharacterBuilder.hero,
      boss,
      castle_with_boss_at_left(boss),
      @console
    )

    game_handler.fight_in!('left')

    assert game_handler.hero.dead?
  end

  private

  def verify_method_called(handler, method, return_value, args)
    mocked_method = MiniTest::Mock.new
    mocked_method.expect :call, return_value, args
    handler.stub method, mocked_method do
      yield
    end
    mocked_method.verify
  end

  def castle_full_of_minion
    Castle.new([CharacterBuilder.minion, CharacterBuilder.minion, CharacterBuilder.minion])
  end

  def castle_with_boss_at_left(boss)
    Castle.new([boss, CharacterBuilder.minion, CharacterBuilder.minion])
  end
end
