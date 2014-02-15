require 'fog/fogdocker/core'

module Fog
  module Compute
    class Fogdocker < Fog::Service

      requires   :docker_url
      recognizes :docker_username, :docker_password, :docker_email

      model_path 'fog/fogdocker/models/compute'
      model      :server
      collection :servers
      model      :image
      collection :images

      request_path 'fog/fogdocker/requests/compute'

      request :api_version
      request :container_all
      request :container_create
      request :container_delete
      request :container_get
      request :container_action
      request :image_all
      request :image_create
      request :image_delete
      request :image_get

      class Mock
        def initialize(options={})
        end
      end

      class Real

        def initialize(options={})
          require 'docker'
          username = options[:docker_username]
          password = options[:docker_password]
          email    = options[:docker_email]
          url      = options[:docker_url]

          Docker.url = url
          Docker.authenticate!('username' => username, 'password' => password, 'email' => email) unless username. nil? || username.empty?
        end

        def downcase_hash_keys(h)
          if h.is_a?(Hash)
            h.keys.each do |key|
              new_key = key.to_s.downcase
              h[new_key] = h.delete(key)
              downcase_hash_keys(h[new_key])
            end
          elsif h.respond_to?(:each)
            h.each { |e| downcase_hash_keys(e) }
          end
          h
        end

      end
    end
  end
end
