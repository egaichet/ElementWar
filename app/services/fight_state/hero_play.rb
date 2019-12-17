class FightState
  class HeroPlay < FightState
    def check?
      !@fight.finished? && !@fight.turn_finished? && @fight.fighter == hero
    end

    def apply!
      console.write("Your turn (#{strike_name_list_text}).")
      strike_name = @game_handler.give_means_to_user(hero.strike_names)
      @fight.play!(hero, strike_name)
      console.write("You hit with #{strike_name}! (your oponent has #{foe.attributes.hit_points} left).")
      @game_handler.storm_elemental_speaks_any('Not bad...', 'Boom headshot !', 'Maybe use fire. Or ice. I don\'t know.', 'That bolt was... awesome...')
      @game_handler.fight_in!(castle.current_room)
    end

    private

    def strike_name_list_text
      hero.strike_names.join('/')
    end
  end
end
