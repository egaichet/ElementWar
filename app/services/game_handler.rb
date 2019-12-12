class GameHandler
  attr_reader :hero, :boss, :castle, :fight

  def initialize(console = nil)
    @hero = CharacterBuilder.hero
    @boss = CharacterBuilder.boss
    @castle = CastleBuilder.foes_in_random_room([CharacterBuilder.minion, CharacterBuilder.minion, @boss])
    @fight = nil
    @console = console || ConsoleService.new
  end

  def start!
    storm_elemental_speaks(
      'Hello Aymeric, legendary hero. We, elemental lords grant you our power to destroy your ennnemi. Obliterate him !',
      'You can use fire, lightning and ice bolt to fight your foes',
      'Fire bolt has a chance to deal critical damage, lightning bolt strike strong if you are faster, and ice bolt can daze your oponent to slow him',
      'Go now, and may the Storm lives (...and if you want to run away just type exit)'
    )
    go_to_center!
  end

  def bye!
    @console.write('You ran away')
    storm_elemental_speaks_any(
      'Bye coward !',
      'Should have bet it... Mikahell is a better hero',
      'Rest a bit and come back later...'
    )
  end

  def died!
    @console.write('You died...')
    storm_elemental_speaks_any(
      'lol',
      'I trusted you...',
      'I am gonna call Mikahell',
      'You were so close !'
    )
  end

  def won!
    @console.write('You won !')
    storm_elemental_speaks_any(
      'I always knew you could do it',
      'You were close to die ! Just kidding, congratulation',
      'The elemental lords thank you...'
    )
  end

  def go_to_center!
    @fight = nil
    @castle.hero_move_to!('center')
    @console.write("Choose a room (#{@castle.available_rooms.join('/')})")
    room = give_means_to_user(@castle.available_rooms)
    @castle.hero_move_to!(room)
    fight_in!(room)
  end

  def fight_in!(room)
    @fight ||= Fight.new(@hero, @castle.current_foe)
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
