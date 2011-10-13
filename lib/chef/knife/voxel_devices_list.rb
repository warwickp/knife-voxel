require 'chef/knife/voxel_base'

class Chef
  class Knife
    class VoxelDevicesList < Knife
      include Knife::VoxelBase

      banner "knife voxel devices list (options)"

      def devices_list
      end

      def run
        devices = [ ui.color('ID', :bold), ui.color('Name', :bold), ui.color('Type', :bold), ui.color('Status', :bold), ui.color('IP', :bold) ]
        statuses = hapi.helper_devices_status

        devices_list = hapi.voxel_devices_list['devices']

        unless devices_list.empty?
          devices_list['device'] = [ devices_list['device'] ] if devices_list['device'].is_a?(Hash)

          devices_list['device'].each do |device|
            devices << device['id']
            devices << device['label']
            devices << case device['type']['content']
            when "Virtual Server"
              "VoxCLOUD"
            when "Server"
              "VoxSERVER"
            else
              device['type']['content']
            end

            devices << (statuses.has_key?(device['id']) ? statuses[device['id']] : "N/A")

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
        end

        puts ui.list(devices, :columns_across, 5)
      end
    end
  end
end
