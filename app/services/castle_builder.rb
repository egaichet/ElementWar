class CastleBuilder
  class << self
    def foes_in_random_room(foes)
      Castle.new(foes.shuffle)
    end
  end
end
