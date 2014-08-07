require 'fountain/version'
Dir[File.dirname(__FILE__) + '/fountain/*.rb'].each { |file| require file }

# Define all the command logic for fountain
module Fountain
  def self.default_host
    '/var/run/docker.sock'
  end

  def self.default_path
    'fountain/**/*'
  end

  def self.build(host: default_host, path: default_path)
    image_set = ImageSet.build(path)
    image_set.install(DockerHost.new(host))
  end

  def self.run
    raise NotImplementedError
  end
end
