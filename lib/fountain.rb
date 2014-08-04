require 'fountain/version'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

# Define all the command logic for fountain
module Fountain
  def build(host:, path:)
    image_set = ImageSet.build(path)
    image_set.install(DockerHost.new(host))
  end
end
