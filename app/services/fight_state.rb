class FightState
  def self.check_and_apply!(fight, game_handler)
    [
      BossDied,
      FoeDied,
      FoePlay,
      HeroDied,
      HeroPlay,
      TurnFinished
    ].map{ |state_klass| state_klass.new(fight, game_handler) }
      .find{ |state| state.check? }
      &.apply!
  end

  def initialize(fight, game_handler)
    @fight = fight
    @game_handler = game_handler
  end

  def check?
    raise NotImplementedError
  end

  def apply!
    raise NotImplementedError
  end

  private

  def hero
    @game_handler.hero
  end

  def foe
    @game_handler.castle.current_foe
  end

  def boss
    @game_handler.boss
  end

  def castle
    @game_handler.castle
  end

  def console
    @game_handler.console
  end
end
