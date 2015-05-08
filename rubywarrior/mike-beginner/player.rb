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
        # w:(Warrior)  wdm:(Warrior's damage point)
        # s:(Slundge) sdm: (Slundge's damage point)
        # 1. w - sdm*n > s-wdm*n  ==> w > s - (wdm-sdm)*n
        # 2. n = ceil(y/wdm)
        # 1 and 2 => w > s - (wdm-sdm)*ceil(s/wdm)
        @need_health = @slundge.health - (@damage_p - @slundge.damage_p) * (@slundge.health/@damage_p).ceil

        if(@need_health > @health_s)
            @need_health = @health_s
        end
    end

    def hurt?(warrior)
        p "#{warrior.health}  vs #{@health_cur}"
        warrior.health < @health_cur
    end

    def have_a_rest?(warrior)
        if !hurt?(warrior) && (warrior.health < @need_health)
            warrior.rest!
            p "oooooooooooo^_^ooooooooo REST......"
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
            p ">>>>>>>>>>>>>>Kill it!!"
        end
        @health_cur = warrior.health
    end

end

