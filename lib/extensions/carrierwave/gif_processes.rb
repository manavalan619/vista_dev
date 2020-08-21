module CarrierWave
  module GifProcesses
    # Remove the GIF animation
    # process :remove_animation
    def remove_animation
      manipulate! do |img, index|
        index.zero? ? img : nil
      end
    end

    # TODO: make this work with MiniMagick
    # Re-optimize the animation. This can help lower the file size with GIFs.
    # Without this resizing GIF files can result in very large image formats.
    # process :optimize_animation
    # def optimize_animation
    #   list = ::MiniMagick::ImageList.new.from_blob file.read
    #   return unless list.size > 1
    #   list = list.coalesce
    #   list.optimize_layers(MiniMagick::OptimizeLayer)
    #   list.remap
    #   File.open(current_path, 'wb') { |f| f.write list.to_blob }
    # end
  end
end
