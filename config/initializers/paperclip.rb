require 'paperclip/cloudinary'

Paperclip::Attachment.default_options[:storage] = :cloudinary
