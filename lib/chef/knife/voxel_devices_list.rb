require 'chef/knife/voxel_base'

class Chef
  class Knife
    class VoxelDevicesList < Knife
      include Knife::VoxelBase

      banner "knife voxel devices list (options)"

      def devices_list
      end

      def run
        devices = [ ui.color('ID', :bold), ui.color('Name', :bold), ui.color('Status', :bold), ui.color('IP', :bold) ]
        statuses = hapi.helper_devices_status

        hapi.voxel_devices_list['devices']['device'].each do |device|
        require 'pp'

          devices << device['id']
          devices << device['label']
          devices << (statuses.has_key?(device['id']) ? statuses[device['id']] : "UNKNOWN")

          if device.has_key?('ipassignments')
            ips = device['ipassignments']['ipassignment']

            if ips.is_a?(Hash)
              ips = [ ips ]
            end

            ip = ips.select { |a| a['type'] == "frontend" }.first

            devices << (ip.nil? ? "" : ip["content"])
          else
            devices << ""
          end
        end

        puts ui.list(devices, :columns_across, 4)
      end
    end
  end
end
