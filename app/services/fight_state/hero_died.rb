class FightState
  class HeroDied < FightState
    def check?
      @fight.finished? && hero.dead?
    end

    def apply!
      console.write('You died...')
      @game_handler.storm_elemental_speaks_any('lol', 'I trusted you...', 'I am gonna call Mikahell', 'You were so close !')
    end
  end
end
