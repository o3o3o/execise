class Slundge
    attr_reader :health, :damage_p
    def initialize(health_full=12, damage_p=3)
        @health  = health_full
        @damage_p  = damage_p
    end
end

class Archer
    attr_reader :health, :damage_p, :attack_length
    def initialize(health_full=7, damage_p=3, attack_length=2)
        @health  = health_full
        @damage_p  = damage_p
        #攻击步长
        @attack_length = attack_length
    end

end

class Player
    NORMAL=0
    ATTACKED_BY_ARCHER=1
    CHANGE_DIRECTION=2

    def initialize(health_full=20, damage_p=5, recover_ration=0.1)
        @health_full  = health_full
        @damage_p  = damage_p
        @ratio = recover_ration
        @slundge = Slundge.new(24,3)
        @archer = Archer.new(7,3)
        @health_cur = @health_full
        @direct = :forward
        @cur_attacked_cnt = 0
        @need_health_before_fight= @archer.damage_p  * @archer.attack_length #TODO: update?
    end
    def set_need_health
        ### We should take a rest until the health is getting up to @need_health
        # w:(Warrior)  wdm:(Warrior's damage point)
        # s:(Slundge) sdm: (Slundge's damage point)
        # 1. w - sdm*n > s-wdm*n  ==> w > s - (wdm-sdm)*n
        # 2. n = ceil(y/wdm)
        # 1 and 2 => w > s - (wdm-sdm)*ceil(s*1.0/wdm)
        @need_health = @slundge.health - (@damage_p - @slundge.damage_p) * (((@slundge.health*1.0)/@damage_p).ceil)

        if(@need_health > @health_full)
            @need_health = @health_full
        end
    end


    # Check if we are hurt by enemies last time.
    def bleeding?(warrior)# attacked by archer?
        #p "#{warrior.health}  vs #{@health_cur}"
        if warrior.health < @health_cur
            # We need to raise the value of @need_health when it be  ATTACKED_BY_ARCHER
            @need_health = @health_full
            return true
        else
            set_need_health if @need_health != @health_full
            return false
        end
    end

    def have_a_rest?(warrior)
        if !bleeding?(warrior) && (warrior.health < @need_health)
            true
        end
    end

    def change_direction!
        p "Change Direction!!!"
        if @direct == :forward
            @direct = :backward
        else
            @direct = :forward
        end
        @status=CHANGE_DIRECTION
    end

    def change_direction_lasttime?
         @cur_attacked_cnt == 1 || @status!=CHANGE_DIRECTION
    end

    #TODO: How to predict the @health_before_attack with distance of enemies?
    def change_direction?(warrior)
        #TODO:update @need_health_before_fight
        p "=======change_direction?=====need_health_before_fight: #{@need_health_before_fight}"
        if  bleeding?(warrior) && (warrior.health < @need_health_before_fight) && change_direction_lasttime?
            return true
        end
    end

    def play_turn(warrior)

        if bleeding?(warrior)
            @cur_attacked_cnt += 1
            p "SAY:I am being attacked....#{@cur_attacked_cnt} times!"
        else
            @cur_attacked_cnt = 0 
        end

        if warrior.feel(@direct).empty?  #empty
            p "SAY: feel empty..."
            if have_a_rest?(warrior)
                p "SAY:oooooooooooo^_^ooooooooo REST......"
                warrior.rest!
                @health_cur += (@health_full * @ratio)
            else
                if change_direction?(warrior) 
                    p "SAY!!!! GOT HURT(#{warrior.health}<#{@need_health_before_fight}), WE NEED BACKWARD!!"
                    change_direction!
                else
                    @status = NORMAL
                end
                warrior.walk!(@direct)
            end
        elsif warrior.feel(@direct).captive? 
            warrior.rescue!(@direct)
        elsif warrior.feel(@direct).wall? 
            warrior.pivot!
            #change_direction! 
            #warrior.walk!(@direct)
        #elsif warrior.feel(@direct).stairs?  # feel enemy
        #    warrior.walk!(@direct)
        else
            warrior.attack!(@direct)
            p ">>>>>>>>>>>>>>Kill it!!"
        end
        # bleeding check helper
        @health_cur = warrior.health
    end

end

