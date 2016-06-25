class PictureUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end

  version :bright_face do
    cloudinary_transformation :effect => "brightness:30", :radius => 20,
                              :width => 150, :height => 100, :crop => :thumb, :gravity => :face
  end

  version :thumbnail do
    cloudinary_transformation :width => 150, :height => 150, :crop => :thumb
  end

  version :large do
    cloudinary_transformation :width => 1000, :height => 300, :crop => :crop
  end

  version :medium do
    cloudinary_transformation :width => 200, :height => 200, :crop => :fill
  end


end