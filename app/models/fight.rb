class Fight
  attr_reader :hero, :foe, :turn

  def initialize(hero, foe)
    @hero = hero
    @foe = foe
    @turn = 1
    @played = []
  end

  def finished?
    @hero.dead? || @foe.dead?
  end

  def turn_finished?
    @played.size == 2
  end

  def new_turn!
    @turn += 1
    @played = []
  end

  def fighter
    if @played.empty?
      faster_between_characters
    else
      ([@hero, @foe] - @played).first
    end
  end

  def play!(fighter, action)
    raise "Cannot execute #{action}" unless fighter.strikes.keys.map(&:to_s).include?(action)
    target = ([@hero, @foe] - [fighter]).first
    fighter.attack!(target, action.to_sym)
    @played << fighter
  end

  private

  def faster_between_characters
    if @hero.faster?(@foe)
      @hero
    else
      @foe
    end
  end
end
