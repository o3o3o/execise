class Slundge
    attr_reader :health, :damage_p
    def initialize(health_s=12, damage_p=3)
        @health  = health_s
        @damage_p  = damage_p
    end
end

class Player

    def initialize(health_s=20, damage_p=5, recover_ration=0.1)
        @health_s  = health_s
        @damage_p  = damage_p
        @ratio = recover_ration
        @slundge = Slundge.new(24,3)
        @health_cur = @health_s
        # w-3n > y - 5n
        @need_health = @slundge.health - (@damage_p - @slundge.damage_p)

        if(@need_health > @health_s)
            @need_health = @health_s
        end
    end

    def be_damage?(warrior)
        warrior.health < @health_cur
    end

    def have_a_rest?(warrior)
        if !be_damage?(warrior)  and (warrior.health < @need_health)
            warrior.rest!
            @health_cur = warrior.health
            true
        end
    end

    def play_turn(warrior)

        if warrior.feel.empty?
            if !have_a_rest?(warrior)
                warrior.walk!
            end
        else
            warrior.attack!
        end
    end

end

