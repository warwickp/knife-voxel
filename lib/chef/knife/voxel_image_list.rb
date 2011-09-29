require 'chef/knife/voxel_base'

class Chef
  class Knife
    class VoxelImageList < Knife
      include Knife::VoxelBase

      banner "knife voxel image list (options)"

      def run
        images = [ ui.color('ID', :bold), ui.color('Name', :bold) ]

        hapi.voxel_images_list['images']['image'].each do |image|
          image_list << image['id']
          image_list << image['summary']
        end

        puts ui.list(image_list, :columns_across, 2)
      end
    end
  end
end
