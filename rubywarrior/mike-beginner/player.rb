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
        ### We should take a rest until out health up to @need_health
        # w:(Warrior)  wdm:(Warrior's damage point)
        # s:(Slundge) sdm: (Slundge's damage point)
        # 1. w - sdm*n > s-wdm*n  ==> w > s - (wdm-sdm)*n
        # 2. n = ceil(y/wdm)
        # 1 and 2 => w > s - (wdm-sdm)*ceil(s*1.0/wdm)
        @need_health = @slundge.health - (@damage_p - @slundge.damage_p) * (((@slundge.health*1.0)/@damage_p).ceil)

        if(@need_health > @health_s)
            @need_health = @health_s
        end
    end

    # Check if we are hurt by enemies
    def bleeding?(warrior)
        #p "#{warrior.health}  vs #{@health_cur}"
        warrior.health < @health_cur
    end

    def have_a_rest?(warrior)
        if !bleeding?(warrior) && (warrior.health < @need_health)
            true
        end
    end

    def change_direction!
        if !@direct
            @direct = ":backward"
        elsif
            @direct = nil
        end
    end

    #TODO:if  Warrior is walking and is hurt by arch
    def change_direction?
    end

    # --------
    #|C @ S aa|
    # --------
    def play_turn(warrior)

        if warrior.feel.empty?  #empty
            if have_a_rest?(warrior)
                warrior.rest!
                p "oooooooooooo^_^ooooooooo REST......"
                @health_cur = warrior.health
            else
                change_direction! if change_direction?
                warrior.walk!(@direct)
            end
        elsif warrior.feel(@direct).captive? #captive
            warrior.rescue!(@direct)
        elsif warrior.feel(@direct).wall? #wall
            change_direction! 
        else
            warrior.attack!(@direct)
            p ">>>>>>>>>>>>>>Kill it!!"
        end
        @health_cur = warrior.health
    end

end

