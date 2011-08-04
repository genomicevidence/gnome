# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{Rails.root}/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process :analyze

  def analyze
    # analyze files in the zip file one by one
    Zip::ZipFile.open(@file.file) do |files|
      files.each do |f|
        next unless f.file?
        # Use MD5 digest file name in tmp dir in case multiple users upload files with the same name
        file_path = File.join( Rails.root, "tmp", Digest::MD5.hexdigest(f.to_s + Time.now.to_s) + ".gvf" )
        files.extract( f, file_path )
        # TODO: delayed_job
        # TODO: check gvf format
        #v = `wc -l #{file_path}`
        #Rails.logger.info("TEST #{v}")
        pipeline = File.join(Rails.root, "script", "gnome_scripts", "pipeline.pl")
        system("#{pipeline} #{file_path}")
        # All done. Delete it.
        FileUtils.rm(file_path)
      end
    end
    @file
    # run pipleline script
    # load data
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end
  def extension_white_list
   %w(zip)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
