require 'chef/knife/voxel_base'

class Chef
  class Knife
    class VoxelDevicesList < Knife
      include Knife::VoxelBase

      banner "knife voxel devices list (options)"

			def devices_list
			end

      def run
        devices = [ ui.color('ID', :bold), ui.color('Name', :bold) ]

        hapi.voxel_devices_list['devices']['device'].each do |device|
          devices << device['id']
          devices << device['label']
        end

        puts ui.list(devices, :columns_across, 2)
      end
    end
  end
end
