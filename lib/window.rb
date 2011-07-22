class GameWindow < Gosu::Window
  def initialize
    super(1600, 1200, false)
    self.caption = 'Oh Noes! Meteorz!'

    @background_image = Gosu::Image.new(self, "media/space.jpg", true)

    @player = Player.new(self)
    @player.warp(800, 600)

    @star_animation = Gosu::Image::load_tiles(self, "media/star.png", 38, 38, false)
    @stars = Array.new

    @debris_animation = Gosu::Image::load_tiles(self, "media/debris.png", 50, 40, false)
    @debris = Array.new

    @warp_animation = Gosu::Image::load_tiles(self, "media/warp.png", 98, 96, false)
    @warps = Array.new

    @meteor_animation = Gosu::Image::load_tiles(self, "media/meteor.png", 72, 72, false)
    @meteors = Array.new

    @explosion_animation = Gosu::Image::load_tiles(self, "media/explosion.png", 63, 63, false)


    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    unless @player.dead
      if button_down?(Gosu::KbLeft) || button_down?(Gosu::GpLeft)
        @player.turn_left
      end

      if button_down?(Gosu::KbRight) || button_down?(Gosu::GpRight)
        @player.turn_right
      end

      if button_down?(Gosu::KbUp)
        @player.accelerate
      end

      @player.move
      @player.collect_stars(@stars)
      @player.check_warps(@warps)
      @player.check_meteors(@meteors)
    else
      @explosion = Explosion.new(@explosion_animation, @player.dead_x, @player.dead_y) if @player.respawn_time == 20
      @explosion.draw
      
      @player.respawn_time -= 1
      if @player.respawn_time.zero?
        @player.respawn_time = 20
        @player.dead = false
        @player.warp(800, 600)
      end
    end

    @meteors.each { |meteor| meteor.move }
    @debris.each { |debris| debris.move }

    if rand(100) < 4 and @stars.size < 10
      @stars.push(Star.new(@star_animation))
    end
    
    if rand(100) < 4 and @debris.size < 25
      @debris.push(Debris.new(@debris_animation))
    end
    
    if rand(100) < 4 and @warps.size < 4
      @warps.push(Warp.new(@warp_animation))
    end
    
    if rand(100) < 4 and @meteors.size < 5
      @meteors.push(Meteor.new(@meteor_animation))
    end
    
  end

  def draw
    @background_image.draw(0, 0, Utils::ZOrder::Background)

    @player.draw

    @stars.each { |star| star.draw }
    @debris.each { |debris| debris.draw }
    @warps.each { |warp| warp.draw }
    @meteors.each { |meteor| meteor.draw }

    @font.draw("Score: #{@player.score}", 10, 10, Utils::ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Deaths: #{@player.deaths}", 10, 30, Utils::ZOrder::UI, 1.0, 1.0, 0xffffff00)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end
