class Player
  attr_reader :score, :dead_x, :dead_y, :deaths
  attr_accessor :dead, :respawn_time

  def initialize(window)
    @image = Gosu::Image.new(window, "media/fighter.png", false)

    @beep = Gosu::Sample.new(window, "media/beep.wav")
    @applause = Gosu::Sample.new(window, "media/applause.wav")
    @warp = Gosu::Sample.new(window, "media/warp.wav")
    @meteor = Gosu::Sample.new(window, "media/meteor.wav")

    @deaths = 0
    @dead = false
    @respawn_time = 20

    @animation = Gosu::Image::load_tiles(window, "media/spaceship.png", 49, 49, false)

    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y

    @x %= 1600
    @y %= 1200

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
   # img = @animation[Gosu::milliseconds / 100 % @animation.size]
  #  img.draw(@x - img.width / 2.0, @y - img.height / 2.0, Utils::ZOrder::Player, @angle, @angle)
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def check_warps(warps)
    warps.each do |warp|
      if Gosu::distance(@x, @y, warp.x, warp.y) < 30
        @warp.play
        warp(rand * 1600, rand * 1200)
      end
    end
        
  end

  def die!
    puts "You died!."
  end

  def check_meteors(meteors)
    meteors.each do |meteor|
      if Gosu::distance(@x, @y, meteor.x, meteor.y) < 30
        @meteor.play
        @dead = true
        @dead_x = @x
        @dead_y = @y
        @deaths += 1
      end
    end
  end

  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu::distance(@x, @y, star.x, star.y) < 35
        @score += 10
        
        if (@score >= 100 && @score % 100 == 0)
          @applause.play
        else
          @beep.play
        end

        true
      else
        false
      end
    end

  end

end
