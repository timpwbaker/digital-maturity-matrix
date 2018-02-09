module Features
  module AwsHelpers
    def stub_aws_return_matrix
      stub_request(:get, /https:\/\/digitalmaturitymatrix/).
        to_return(:status => 200,
                  :body => File.join(Rails.root, 'spec','fixtures','matrix.pdf'),
                  :headers => {})
    end

    def stub_aws_post_return_200
      stub_request(:put, /https:\/\/digitalmaturitymatrix/).
        to_return(:status => 200, :headers => {})
    end

    def stub_aws_client
      client_stub = Aws::S3::Client.new(stub_responses: true)
      resource_stub = Aws::S3::Resource.new(client: client_stub)
      resource_stub.bucket('digitalmaturitymatrix')
      allow(Aws::S3::Resource).to receive(:new).and_return resource_stub
    end
  end
end
