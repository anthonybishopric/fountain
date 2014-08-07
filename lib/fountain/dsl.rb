module Fountain
  # Provides the DSL wrapper that configures ImageSet instances.
  class DSL
    def initialize(image_set)
      @image_set = image_set
      @current_parent
    end

    def image(name, from:)
      @image_set.add(Image.new(name, from: from))
    end
  end
end
