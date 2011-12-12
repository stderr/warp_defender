require 'yaml'
class GameLevel

  def initialize(file_name)
    yaml = YAML::load(File.open("data/#{file_name}"))
    
    # Required: waves, warps, name, description, next_level
    yaml.each { |k, v| instance_variable_set("@#{k}", v) }
    
    @intro_fade = 2550
  end
  
  def warps
    @warps.collect do |warp|
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
    
  end
  
  def draw_intro
    $window.fonts[:game].draw_rel(@name, $window.width/2, $window.height/2, 
                                  Utils::ZOrder::HUD, 0.5, 0.5, 1, 1, 
                                  Gosu::Color::RED)
  end

  def intro_finished?
  end

  def spawn
  end

  def current_wave
    @waves.first
  end

  def to_next_wave?
    @waves[current_wave]['enemies'].inject(0) { |count, (k, v)| count += v; count } <= 0
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

  def interval
    current_wave["interval"].to_i
  end

end
