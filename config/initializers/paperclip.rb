# require 'paperclip/cloudinary'

# Paperclip::Attachment.default_options[:storage] = :cloudinary
Paperclip::Attachment.default_options.merge!(
    storage: :fog,
    fog_credentials: {
      provider: 'AWS',
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_KEY_ID"],
      region: ENV["S3_REGION_NAME"],
      preserve_files: false ,
    },
    fog_directory: ENV["BUCKET_NAME"]
  )

  Spree::Image.attachment_definitions[:attachment].delete(:url)
  Spree::Image.attachment_definitions[:attachment].delete(:path)

