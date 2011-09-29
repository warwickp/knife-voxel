require 'chef/knife'

class Chef
  class Knife
    module VoxelBase
      def self.included(includer)
        includer.class_eval do

          deps do
            require 'voxel-hapi'
          end

          option :voxel_api_key,
            :short => "-K KEY",
            :long => "--voxel-api-key KEY",
            :description => "Voxel hAPI Key",
            :proc => Proc.new { |key| Chef::Config[:knife][:voxel_api_key] = key }

          option :voxel_api_secret,
            :short => "-S USERNAME",
            :long => "--voxel-api-secret SECRET",
            :description => "Voxel hAPI Secret",
            :proc => Proc.new { |secret| Chef::Config[:knife][:voxel_api_secret] = secret }
        end
      end

      def hapi
        @hapi ||= begin
          hapi = HAPI.new(
            :useauthkey     => true,
            :username       => Chef::Config[:knife][:voxel_api_key],
            :password       => Chef::Config[:knife][:voxel_api_key],
            :default_format => :ruby,
            :debug          => false
          )
        end
      end
    end
  end
end
