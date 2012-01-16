require 'yaml'

class Wave

  attr_reader :interval, :min_spawn, :max_spawn, :enemies

  def initialize(config)
    @max_spawn = config['max_spawn']
    @min_spawn = config['min_spawn']
    @interval = config['interval']
    
    
    load_enemies(config['enemies'])
  
  end

  def completed?(drawn_enemies) 
    @enemies.empty? && drawn_enemies.empty?
  end

  private

  def load_enemies(enemies)
    @enemies = enemies.inject([]) do |enemies, (name, count)|
      count.to_i.times { enemies << Entities.const_get(name.capitalize) }
      enemies
    end
  end

end

class GameLevel
  attr_reader :warps, :current_enemies, :explosions, :player, :bullets, :next_level, :camera
  
  def self.level_path(file)
    "data/levels/#{file}"
  end

  def self.has_level?(level)
    !level.empty? && File.exists?(level_path(level))
  end

  def initialize(file_name)
    yaml = YAML::load(File.open(GameLevel.level_path(file_name)))
    
    @name = yaml['name']
    @description = yaml['description']
    @next_level = yaml['next_level'] || ""

    @current_enemies = []
    @explosions = []
    @bullets = []

    load_player($window.native_width/2, $window.native_height/2+275)
    load_waves(yaml['waves'])
    load_warps(yaml['warps'])
    
    @dialog = GUI::LevelDialog.new(:title => @name, :description => @description)
    
    @intro_length = 3000

    @camera = Camera.new(warps[0], 3)
  end

  def completed?; @waves.last == current_wave && current_wave.completed?(@current_enemies); end
  def current_defense; @warps.map(&:current_defense).inject(:+); end  
  def current_wave; @waves[@current_wave]; end
  def interval; current_wave.interval.to_i end
  def intro_finished?(ms); ms > @intro_length; end
  def max_defense; @warps.map(&:max_defense).inject(:+); end
  def next_wave; @current_wave += 1; end
  def targets; @warps + [@player] end
  def to_next_wave?; current_wave.completed?(@current_enemies); end

  def draw(delta)
    # hack.  We need a starting() method or something
    if @camera.target != @player
      @camera.smooth_retarget(player, 1.5, "expo out", 3000, 2000)
    end

    @camera.draw do
      # temporarily draw the level extents
      border_color = Gosu::Color.rgba(65, 108, 112, 200)
      $window.draw_line(0, 0, border_color,
                        $window.native_width, 0, border_color,
                        Utils::ZOrder::HUD)
      $window.draw_line($window.native_width, 1, border_color,
                        $window.native_width, $window.native_height, border_color,
                        Utils::ZOrder::HUD)
      $window.draw_line($window.native_width-1, $window.native_height, border_color,
                        0, $window.native_height, border_color,
                        Utils::ZOrder::HUD)
      $window.draw_line(0, $window.native_height-1, border_color,
                        0, -1, border_color,
                        Utils::ZOrder::HUD)


      entities.each { |e| e.draw(delta) }
    end
  end

  def draw_intro
    @dialog.draw($window.native_width/2, $window.native_height/2, :width => 1200, 
                 :height => 800, :color => Gosu::Color.rgba(65, 108, 112, 200),
                 :font_color => Gosu::Color.rgba(255, 255, 255, 120))
  end
  
  def update(delta)
    @camera.update(delta)
    @bullets.reject! { |b| b.dead? } # remove once bullets aren't special
    @current_enemies.reject! { |e| e.dead? }

    entities.each { |e| e.update(delta) }

    @bullets.each do |bullet|
      entities.each do |entity|
        if entity.enemy? && bullet.collides_with?(entity)
            bullet.kill
            entity.kill
            $window.sounds[:explosion].play
            @explosions << Entities::Explosion.new(entity.x, entity.y,
                                                   entity.vel_x*0.7,
                                                   entity.vel_y*0.7)
        end
      end
    end

    entities.each do |entity|
      if entity.enemy?
        if warp = @warps.detect { |w| entity.collides_with?(w) }
          warp.warp(entity)
        end
      end
    end

  end

  def spawn
    amount = rand(current_wave.max_spawn.to_i) + current_wave.min_spawn.to_i
    amount.times do
      unless current_wave.enemies.empty?
        enemy = current_wave.enemies.shuffle!.pop.new(targets[rand(targets.length)])
        enemy.spawn($window.native_width, $window.native_height)
        @current_enemies << enemy
      end
    end
  end

  def entities
    [@player] + @warps + @current_enemies + @bullets + @explosions
  end

  private

  def load_player(x = $window.native_width/2, y = $window.native_height/2)
    @player = Entities::Player.new
    @player.move_to(x, y)
  end

  def load_warps(warps)
    @warps = warps.collect do |warp|
      case warp['position']
      when 'center'
        x, y = [$window.native_width/2, $window.native_height/2]
      when 'random'
        x, y = [rand($window.native_width), rand($window.native_height)]
      else
        x, y =  warp['position'].split(",").map(&:strip)
      end  
      
      Entities::Warp.new(x, y)
    end
  end

  def load_waves(waves)
    @current_wave = 0
    @waves = waves.inject([]) do |waves, config|   
      waves << Wave.new(config)
      waves
    end
  end


end
