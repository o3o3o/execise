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
        @damage_p  = damage_p # 11? 3 ?
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
        @archer = Archer.new(7,3) # 3? 11 ?
        @health_cur = @health_full
        @direct = :forward
        @cur_attacked_cnt = 0
        @need_health_before_fight= @archer.damage_p  * @archer.attack_length #TODO: update?
        @action = nil
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
            #NOW we have shooting ability
            #@need_health = @archer.health - (@damage_p - @archer.damage_p) * (((@archer.health*1.0)/@damage_p).ceil)
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
        if @direct == :forward
            @direct = :backward
        else
            @direct = :forward
        end
        @status=CHANGE_DIRECTION
        p "Change Direction to #{@direct}!!!"
    end

    def change_direction_lasttime?
         @cur_attacked_cnt == 1 || @status!=CHANGE_DIRECTION
    end

    #TODO: How to predict the @health_before_attack with distance of enemies?
    def change_direction?(warrior)
        #TODO:update @need_health_before_fight
        #p "=======change_direction?=====need_health_before_fight: #{@need_health_before_fight}"
        if  bleeding?(warrior) && (warrior.health < @need_health_before_fight) && change_direction_lasttime?
            return true
        end
    end

    def check_enemy?(warrior)
        user=warrior.look(@direct)
        i = 0
        user.each do |u|
            #p "OoO)SAW:#{u.class} #{u}"
            type="#{u}" # convert "CALSS" to string
            i+=1
            if (type  == "Wizard" or type  =~ /Sludge/) and i == 2
                p "#######Oh I saw  [#{type}] on the #{i} space"
                return true
            end
            if type == "Archer"
            end
        end
        return false
    end
    def find_archer?(warrior)
        user=warrior.look(@direct)
        user.each do |u|
            type="#{u}" # convert "CALSS" to string
            if type == "Archer"
                return true
            end
        end
        return false
    end

    def shoot?(warrior)
        user=warrior.look(@direct)
        i = 0
        user.each do |u|
            #p "OoO)SAW:#{u.class} #{u}"
            type="#{u}" # convert "CALSS" to string
            i+=1
            if (type  == "Wizard" or type  =~ /Sludge/) and i == 2
                p "#######Oh I saw  [#{type}] on the #{i} space"
                return true
            end
            if type == "Archer" and i == 2 #??
                warrior.shoot!(@direct) if action?
                @action="DONE"
                return true
            end
        end
        return false
    end

    def action?
        @action != "DONE"
    end

=begin
    def do!(action) # lisp macro?
        if done?
            case action
            when "shoot" @warrior.shoot(@direct)
            when "walk" @warrior.walk(@direct)
            when "attack" @warrior.attack(@direct)
            else 
                p "NOT FOUND #{action}"
            end
            @warrior.action(@direct)
            @action = "DONE"
        end
    end
=end

    def play_turn(warrior)

        @warrior=warrior
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

                #May We are being attacking by archer in backward
                if bleeding?(warrior) && @cur_attacked_cnt > 1  && !find_archer?(warrior)
                    change_direction! 
                    warrior.shoot!(@direct) if action?
                    @action = "DONE"
                    change_direction!
                end

                if shoot?(warrior)
                    warrior.shoot!(@direct) if action?
                else
                    warrior.walk!(@direct)  if action?
                end

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
            p ">>>>>>>>>>>>>>Kill it!!"
            warrior.attack!(@direct)
        end
        # bleeding check helper
        @health_cur = warrior.health
        @action = nil
    end

end

