class PdfBuilder
  def self.build(submission:)
    return submission.s3_url if submission.s3_url
    new(submission: submission).create_and_save_pdf
  end

  def initialize(submission:)
    @submission = submission
    @rand = SecureRandom.hex
    @date = Date.today
    @org = submission.user.organisation
  end

  def create_and_save_pdf
    write_file
    submission.update_attribute(:s3_url, to_s3_return_url)
  end

  private

  attr_reader :submission, :rand, :date, :org

  def pdf
    @_pdf ||= ApplicationController.render(
      format: :pdf,
      template: 'submissions/showpdf',
      locals: { submission: submission},
      javascript_delay: 2000,
      pdf: 'submission',
      layout: 'pdf')
  end

  def write_file
    File.open(path, 'wb') { |file| file.write(pdf) }
  end

  def path
    @_path ||= Rails.root.join(
      'app', 'pdf',"#{org}_#{date}_submission#{rand}.pdf"
    )
  end

  def to_s3_return_url
    bucket.put_object(
      key: File.basename(path),
      body: File.read(path),
      acl: 'public-read'
    ).public_url
  end

  def s3_resource
    @_s3_resource ||= Aws::S3::Resource.new(
      credentials: s3_credentials,
      region: ENV['AWS_REGION']
    )
  end

  def s3_credentials
    Aws::Credentials.new(
      ENV['AWS_ACCESS_KEY_ID'], 
      ENV['AWS_SECRET_ACCESS_KEY']
    )
  end

  def bucket
    s3_resource.bucket("digitalmaturitymatrix")
  end
end
