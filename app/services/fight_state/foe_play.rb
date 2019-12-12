class FightState
  class FoePlay < FightState
    def check?
      !@fight.finished? && !@fight.turn_finished? && @fight.fighter == foe
    end

    def apply!
      console.write("Your oponent turn !")
      strike_name = foe.strikes.keys.map(&:to_s).sample
      @fight.play!(foe, strike_name)
      console.write("Your foe strike with #{strike_name}! (you have #{hero.attributes.hit_points} left)")
      @game_handler.storm_elemental_speaks_any('Aouch', 'You should have avoided it', 'Mickahell would have dodged easily...', 'Are you ok ?')
      @game_handler.fight_in!(castle.current_room)
    end
  end
end
