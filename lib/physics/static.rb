module Physics

  class Static

    def initialize(params)
      @bounds = Physics.create_bounds(params[:sprite])
    end

    def update(entity, delta)
      # yawn, not much to do
      if @bounds
      	@bounds.x = entity.x
      	@bounds.y = entity.y
      end
    end

    def collides_with?(other)
      @bounds.collides_with?(other.bounds)
    end

  end

end
