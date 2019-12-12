class FightState
  class TurnFinished < FightState
    def check?
      !@fight.finished? && @fight.turn_finished?
    end

    def apply!
      console.write("Turn #{@fight.turn} finished")
      @fight.new_turn!
      @game_handler.fight_in!(castle.current_room)
    end
  end
end
