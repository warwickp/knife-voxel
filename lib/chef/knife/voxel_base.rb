require 'chef/knife'

class Chef
  class Knife
    module VoxelBase
      def self.included(includer)
        includer.class_eval do

          deps do
            require 'hapi'
          end

          option :voxel_api_key,
            :short       => "-K KEY",
            :long        => "--voxel-api-key KEY",
            :description => "Voxel hAPI Key",
            :proc        => Proc.new { |key| Chef::Config[:knife][:voxel_api_key] = key }

          option :voxel_api_secret,
            :short       => "-S SECRET",
            :long        => "--voxel-api-secret SECRET",
            :description => "Voxel hAPI Secret",
            :proc        => Proc.new { |secret| Chef::Config[:knife][:voxel_api_secret] = secret }

          option :voxel_api_username,
            :long        => "--voxel-api-username USERNAME",
            :description => "Voxel hAPI Username",
            :proc        => Proc.new { |username| Chef::Config[:knife][:voxel_api_username] = username }

          option :voxel_api_password,
            :long        => "--voxel-api-password PASSWORD",
            :description => "Voxel hAPI Password",
            :proc        => Proc.new { |password| Chef::Config[:knife][:voxel_api_password] = password }


        end
      end

      def hapi
        @hapi ||= begin
          if Chef::Config[:knife].has_key?(:voxel_api_username)
            unless Chef::Config[:knife].has_key?(:voxel_api_password)
              ui.error( "--voxel-api-password is required when using --voxel-api-username" )
              exit 1
            end

            hapi = HAPI.new(
              :useauthkey     => false,
              :username       => Chef::Config[:knife][:voxel_api_username],
              :password       => Chef::Config[:knife][:voxel_api_password],
              :default_format => :ruby,
              :debug          => false
            )
          elsif Chef::Config[:knife].has_key?(:voxel_api_key)
            unless Chef::Config[:knife].has_key?(:voxel_api_secret)
              ui.error( "--voxel-api-secret is required when using --voxel-api-key" )
              exit 1
            end

            hapi = HAPI.new(
              :useauthkey     => true,
              :username       => Chef::Config[:knife][:voxel_api_key],
              :password       => Chef::Config[:knife][:voxel_api_secret],
              :default_format => :ruby,
              :debug          => false
            )
          else
            ui.error( "--voxel-api-key or --voxel-api-username must be specified" )
            exit 1
          end
        end
      end
    end
  end
end
