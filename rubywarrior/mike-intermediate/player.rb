class Player
  def play_turn(warrior)
      @direct=warrior.direction_of_stairs
      warrior.walk!(@direct)
  end
end
