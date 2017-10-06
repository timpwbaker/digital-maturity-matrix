module AwsHelpers
  def stub_aws_return_matrix
    stub_request(:get, /https:\/\/digitalmaturitymatrix.s3-eu-west-1.amazonaws.com/).
      to_return(:status => 200,
                :body => File.join(Rails.root, 'spec','fixtures','matrix.pdf'),
                :headers => {})
  end

  def stub_aws_post_return_200
    stub_request(:put, /https:\/\/digitalmaturitymatrix.s3-eu-west-1.amazonaws.com/).
      to_return(:status => 200, :headers => {})
  end
end
