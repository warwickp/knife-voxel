require 'chef/knife/voxel_base'

class Chef
  class Knife
    class VoxelImagesList < Knife
      include Knife::VoxelBase

      banner "knife voxel images list (options)"

      def images_list
      end

      def run
        images = [ ui.color('ID', :bold), ui.color('Name', :bold) ]

        hapi.voxel_images_list['images']['image'].each do |image|
          images << image['id']
          images << image['summary']
        end

        puts ui.list(images, :columns_across, 2)
      end
    end
  end
end
