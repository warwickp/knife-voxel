require 'chef/knife/voxel_base'

class Chef
  class Knife
    class VoxelVoxserversInventoryList < Knife
      include Knife::VoxelBase

      banner "knife voxel voxservers inventory list (options)"

      def run
        inventory_header = [ ui.color('ID', :bold), ui.color('Summary', :bold) ]

        facilities = hapi.voxel_voxservers_facilities_list

        unless facilities['facilities'].empty?
          facilities['facilities']['facility'].each do |facility|
            puts ui.color("#{facility['label']} (#{facility['description']})\n", :bold)

            available_inventory = hapi.voxel_voxservers_inventory_list( :facility => facility['label'], :verbosity => 'compact' )

            if available_inventory['facilities'].empty?
              puts "No inventory available at this time."
            else
              inventory = available_inventory['facilities']['facility']['configuration']
              inventory = [ inventory ] if inventory.is_a?(Hash)

              local_inventory = inventory_header.clone
              inventory.each do |cfg|
                local_inventory << cfg['id']
                local_inventory << cfg['summary']
              end

              puts ui.list(local_inventory, :columns_across, 2)
            end

            puts "\n"
          end
        end


#        unless available_inventory['facilities'].empty?
#          if available_inventory['facilities']['facility'].is_a?(Hash)
#            available_inventory['facilities']['facility'] = [ available_inventory['facilities']['facility'] ]
#
#            available_inventory['facilities']['facility'].each do |cfg|
#
#            end
#          end
#        end
      end
    end
  end
end
