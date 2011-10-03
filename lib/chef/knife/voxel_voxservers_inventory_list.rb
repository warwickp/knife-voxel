require 'chef/knife/voxel_base'

class Chef
  class Knife
    class VoxelVoxserversInventoryList < Knife
      include Knife::VoxelBase

      banner "knife voxel voxservers inventory list (options)"

      def run
        inventory_header = [ ui.color('ID', :bold), ui.color('Facility', :bold), ui.color('Summary', :bold) ]
        available_inventory = hapi.voxel_voxservers_inventory_list( :facility => "LGA8" )

        require 'pp'

        unless available_inventory['facilities'].empty?
          if available_inventory['facilities']['facility'].is_a?(Hash)
            available_inventory['facilities']['facility'] = [ available_inventory['facilities']['facility'] ]

            available_inventory['facilities']['facility'].each do |cfg|

            end
          end
        end
      end
    end
  end
end
