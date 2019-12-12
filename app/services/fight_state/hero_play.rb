class FightState
  class HeroPlay < FightState
    def check?
      !@fight.finished? && !@fight.turn_finished? && @fight.fighter == hero
    end

    def apply!
      console.write("Your turn (#{hero.strikes.keys.join('/')})")
      strike_name = @game_handler.give_means_to_user(hero.strikes.keys.map(&:to_s))
      @fight.play!(hero, strike_name)
      console.write("You hit with #{strike_name}! (your oponent has #{foe.attributes.hit_points} left)")
      @game_handler.storm_elemental_speaks_any('Not bad...', 'Boom headshot !', 'Maybe use fire. Or ice. I don\'t know', 'That bolt was... awesome...')
      @game_handler.fight_in!(castle.current_room)
    end
  end
end
