module Physics

  class Static
    attr_reader :bounds
    include Collision

    def initialize(params)
      create_bounds(params[:sprite])
    end

    def update(entity, delta)
      # yawn, not much to do
    end

  end

end
