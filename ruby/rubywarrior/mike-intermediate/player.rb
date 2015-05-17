class Player

    def initialize
    end

    def have_a_rest?
        @warrior.health
    end

    def play_turn(warrior)
        @direct=warrior.direction_of_stairs
        @warrior = warrior
        p "FEEL: #{warrior.methods} #{warrior.__id__} #{warrior.feel.methods}"

        if warrior.feel(@direct).enemy?
            warrior.attack!(@direct)
        elsif warrior.feel(@direct).empty?
            rest! if have_a_rest?
        else
            warrior.walk!(@direct)
        end
    end
end
