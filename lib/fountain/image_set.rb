module Fountain
  # an ImageSet wraps the result of the invocation of the Fountain
  # DSL. Each image in an image set can be installed on a Docker
  # host. An image set can contain multiple root images, as well as
  # be built using multiple invocations of the Fountain DSL.
  class ImageSet

    def self.global
      @global_image_set ||= ImageSet.new
    end

    def self.glboal=(image_set)
      raise "Expected #{image_set} to be a valid image set" unless image_set.is_a?(ImageSet)
      @global_image_set = image_set
    end

    def self.build(path)
      prev_size = global.size
      Dir[path].each { |f| require f }
      Fountain.logger.warn "Loading #{path} did not create new fountain images." if global.size - prev_size == 0
      global
    end

    def initialize
      @images = {}
    end

    def size
      @images.size
    end

    def [](key)
      @images[key]
    end

    def add(image)
      @images[image.fully_qualified_name] = image
    end

    def in_context(&block)
      Fountain::DSL.new(self).instance_eval(&block)
    end
  end
end

Kernel.class_eval do
  def fountain(&block)
    Fountain::ImageSet.global.in_context(&block)
  end
end
