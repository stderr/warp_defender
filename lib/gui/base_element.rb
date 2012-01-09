module GUI

  class BaseElement
    include Input::Handler
    attr_reader :options
    
    def initialize(options = {}, &block)
      @options = {
        :text => ""
      }.merge!(options)

      controls(&block) if block_given?
    end
    
    def draw(x, y, options = {})

      @options.merge!({
        :font => $window.fonts[:menu]
      }).merge!(options)

    end
    
  end

end
