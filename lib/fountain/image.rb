module Fountain
  # defines a single image and its necessary provisioning.
  class Image

    attr_reader :name, :from, :parent_image

    def initialize(name, from:, parent_image: nil)
      @name = name
      @from = from
      @parent_image = parent_image
    end

    def fully_qualified_name
      if parent_image
        "#{parent_image.fully_qualified_name}_#{name}"
      else
        name
      end
    end
  end
end
