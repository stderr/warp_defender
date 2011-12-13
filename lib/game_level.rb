require 'yaml'
class GameLevel
  attr_reader :warps

  def initialize(file_name)

    yaml = YAML::load(File.open("data/#{file_name}"))
    
    # Required: waves, warps, name, description, next_level
    yaml.each { |k, v| instance_variable_set("@#{k}", v) } 
   
    @warps = @warps.collect do |warp|
      case warp['position']
      when 'center'
        x, y = [$window.width/2, $window.height/2]
      when 'random'
        x, y = [rand($window.width), rand($window.height)]
      else
        x, y =  warp['position'].split(",").map(&:strip)
      end  

      Entities::Warp.new(x, y)
    end
    
    @dialog = GUI::LevelDialog.new(:title => @name, :description => @description)
    @intro_length = 3000
  end
  
  def draw_intro
    @dialog.draw($window.width/2, $window.height/2, :width => 600, 
                 :height => 400, :color => Gosu::Color.rgba(65, 108, 112, 200),
                 :font_color => Gosu::Color.rgba(255, 255, 255, 120))
  end

  def intro_finished?(ms)
    ms > @intro_length
  end
  
  def spawn(targets)
    to_spawn = []
    amount = rand(current_wave['max_spawn'].to_i) + current_wave['min_spawn'].to_i

    amount.times do 
      if enemy = enemies(targets).shuffle!.pop
        to_spawn << enemy
      else
        next_wave
        @current_enemies = nil
      end
    end

    to_spawn
  end

  def current_wave
    @waves.first
  end

  def to_next_wave?
    @current_enemies.nil?
  end
  
  def completed?
    @waves.empty?
  end

  def next_wave
    @waves.shift
  end

  def next_level
    @next_level
  end

  def enemies(targets)

    @current_enemies ||= current_wave['enemies'].inject([]) do |enemies, (name, count)|
      count.to_i.times { enemies << Entities.const_get(name.capitalize).new(targets[rand(targets.length)]) }
      enemies
    end
 
  end

  def interval
    current_wave["interval"].to_i
  end

end
