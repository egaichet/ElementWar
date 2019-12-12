class FightState
  class BossDied < FightState
    def check?
      @fight.finished? && foe.dead? && foe == boss
    end

    def apply!
      console.write('You killed the boss !')
      @game_handler.storm_elemental_speaks_any('... could not believe it...', 'Fire elemental will burst of joy !', 'Mickahell would have won faster.')
    end
  end
end
