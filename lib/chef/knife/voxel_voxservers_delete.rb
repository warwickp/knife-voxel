require 'chef/knife/voxel_base'

class Chef
  class Knife
    class VoxelVoxserversDelete < Knife
      include Knife::VoxelBase

      banner "knife voxel voxservers delete DEVICE_ID (options)"

      def run
        if @name_args.empty?
          ui.error("knife voxel voxservers delete DEVICE_ID (options)")
        else
          @name_args.each do |device_id|
            device = hapi.voxel_devices_list( :device_id => device_id, :verbosity => 'extended' )

            if device['stat'] == "fail"
              ui.error(device['err']['msg'])
            else
              device = device['devices']['device']

              if device['type']['content'] == "Server"
                puts "#{ui.color("Device ID", :cyan)}: #{device['id']}"
                puts "#{ui.color("Name", :cyan)}: #{device['label']}"
                puts "#{ui.color("Image Id", :cyan)}: #{config[:image_id]}"
                puts "#{ui.color("Facility", :cyan)}: #{device['location']['facility']['code']}"
                puts "#{ui.color("Public IP Address", :cyan)}: #{device['ipassignments']['ipassignment'].select { |i| i['type'] == 'frontend' }.first['content']}"
                puts "#{ui.color("Private IP Address", :cyan)}: #{device['ipassignments']['ipassignment'].select { |i| i['type'] == 'backend' }.first['content']}"
                puts "\n"

                confirm("Do you really want to delete this VoxSERVER device")

                delete = hapi.voxel_voxservers_delete( :device_id => device_id )

                if delete['stat'] == "ok"
                  ui.info("Deleted VoxSERVER device #{device['id']} named #{device['label']}")
                else
                  ui.error("Error removing VoxSERVER device #{device['label']}: #{delete['err']['msg']}")
                end
              else
                ui.error("Device #{device['id']} is not a VoxSERVER device.")
              end
            end
          end
        end
      end
    end
  end
end
