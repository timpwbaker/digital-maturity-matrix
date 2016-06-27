Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = ENV['AWS_REGION'],'.amazonaws.com'