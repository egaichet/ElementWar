class GameHandler
  attr_reader :hero, :boss, :castle, :fight, :console

  def self.random_minions_and_boss_anywhere(console = nil)
    boss = CharacterBuilder.boss
    new(
      CharacterBuilder.hero,
      boss,
      CastleBuilder.foes_in_random_room([CharacterBuilder.random_minion, CharacterBuilder.random_minion, boss]),
      console || ConsoleService.new
    )
  end

  def initialize(hero, boss, castle, console)
    @hero = hero
    @boss = boss
    @castle = castle
    @fight = nil
    @console = console
  end

  def start!
    storm_elemental_speaks(
      'Hello Aymeric, legendary hero. We, elemental lords grant you our power to destroy your enemy. Obliterate him !',
      'You can use fire, lightning and ice bolt to fight your foes.',
      'Fire bolt has a chance to deal critical damage, lightning bolt strike strong if you are faster, and ice bolt can daze your oponent to slow him.',
      'Your enemy can also use elemental power, and have minions.',
      'Go now, and may the Storm lives (...and if you want to run away just type exit)'
    )
    go_to_center!
  end

  def bye!
    @console.write('You ran away.')
    storm_elemental_speaks_any(
      'Bye coward !',
      'Should have bet it... Mikahell is a better hero.',
      'Rest a bit and come back later...'
    )
  end

  def go_to_center!
    @fight = nil
    @castle.hero_move_to!('center')
    @console.write("Choose a room (#{@castle.available_rooms.join('/')}).")
    room = give_means_to_user(@castle.available_rooms)
    fight_in!(room)
  end

  def fight_in!(room)
    @castle.hero_move_to!(room)
    @fight ||= Fight.new(@hero, @castle.current_foe)
    FightState.check_and_apply!(@fight, self)
  end

  def storm_elemental_speaks(*sentences)
    @console.write(*sentences.map{ |sentence| "Storm Elemental - #{sentence}" })
  end

  def storm_elemental_speaks_any(*sentences)
    storm_elemental_speaks(sentences.sample)
  end

  def give_means_to_user(means)
    selected = @console.ask(means.push('exit'))
    raise Exit if selected == 'exit'
    selected
  end
end
