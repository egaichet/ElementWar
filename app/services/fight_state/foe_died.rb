class FightState
  class FoeDied < FightState
    def check?
      @fight.finished? && foe.dead? && foe != boss
    end

    def apply!
      console.write('You killed a minion !')
      @game_handler.storm_elemental_speaks_any('Your real fight await !', 'It was just a test...')
      @game_handler.go_to_center!
    end
  end
end
