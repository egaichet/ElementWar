class Castle
  attr_reader :current_room

  def initialize(foes)
    @rooms = {
      'left' => foes[0],
      'middle' => foes[1],
      'right' => foes[2]
    }
    @current_room = 'center'
  end

  def available_rooms
    @rooms.select{ |_, foe| !foe.dead? }.keys
  end

  def current_foe
    @rooms[@current_room]
  end

  def hero_move_to!(position)
    @current_room = position
  end
end
