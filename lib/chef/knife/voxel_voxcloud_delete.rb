require 'chef/knife/voxel_base'

class Chef
  class Knife
    class VoxelVoxcloudDelete < Knife
      include Knife::VoxelBase

      banner "knife voxel voxcloud delete DEVICE_ID (options)"

      def run
        if @name_args.empty?
          ui.error( "knife voxel voxcloud delete DEVICE_ID" )
        else

          @name_args.each do |device_id|
            device = hapi.voxel_devices_list( :device_id => device_id, :verbosity => 'extended' )

            if device['stat'] == "fail"
              ui.error(device['err']['msg'])
            else
              device = device['devices']['device']

              if device['type']['content'] == "Virtual Server"
                puts "#{ui.color("Device ID", :cyan)}: #{device['id']}"
                puts "#{ui.color("Name", :cyan)}: #{device['label']}"
                puts "#{ui.color("Image Id", :cyan)}: #{config[:image_id]}"
                puts "#{ui.color("Facility", :cyan)}: #{device['location']['facility']['code']}"
                puts "#{ui.color("Public IP Address", :cyan)}: #{device['ipassignments']['ipassignment'].select { |i| i['type'] == 'frontend' }.first['content']}"
                puts "#{ui.color("Private IP Address", :cyan)}: #{device['ipassignments']['ipassignment'].select { |i| i['type'] == 'backend' }.first['content']}"
                puts "\n"

                confirm("Do you really want to delete this VoxCLOUD device")

                delete = hapi.voxel_voxcloud_delete( :device_id => device_id )

                if delete['stat'] == "ok"
                  ui.warn("Deleted VoxCLOUD device #{device['id']} named #{device['label']}")
                else
                  ui.error("Error removing VoxCLOUD device #{device['label']}")
                end
              else
                ui.warn("Device #{device['id']} is not a VoxCLOUD device.")
              end
            end
          end
        end
      end
    end
  end
end
