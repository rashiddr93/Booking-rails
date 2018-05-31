require 'swagger_helper'

describe 'Register API' do
  path '/sign_up.json' do
    post 'User Registration' do
      let(:'session-version') { 'v1' }
      let(:user) { FactoryGirl.create(:user) }

      tags 'API_V1'
      consumes 'application/json', 'application/xml'
      description """
        Register API for version v1
      """
      parameter name: :'content-type', in: :header, required: false, type: :string
      parameter name: :body, in: :body,
                schema: {
                  type: :object,
                  properties: {
                    user: {
                      type: :object,
                      properties: {
                        email: { type: :string, required: true },
                        password: { type: :string, required: true },
                        name: { type: :string, required: true },
                        dob: { type: :string, required: true }

                      }
                    }
                  }
                }

      response '201', 'Successfull Registeration' do
        context 'Registeration successfull for given data' do
          let(:body) { { user: { email: 'test@example.com', password: 'test12345', first_name: 'test' } } }
          schema '$ref' => '#/definitions/user_detail'
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['email']).to eq('test@example.com')
            expect(data['first_name']).to eq('test')
          end
        end
      end

      response '400', 'Failed to register' do
        context 'Register Failure For Email Already Exists' do
          let(:body) { { user: { email: user.email, password: 'test12345' } } }
          schema '$ref' => '#/definitions/error_400'
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['message']).to eq('Email has already been taken')
          end
        end
      end
    end
  end
end