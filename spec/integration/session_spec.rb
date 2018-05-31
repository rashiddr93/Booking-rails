require 'swagger_helper'

describe 'Login API' do
  path 'api/v1/sign_in.json' do

    post 'Users Sign In' do
      let(:user) { FactoryGirl.create(:user) }
      let(:'session-version') { 'v1' }

      tags 'API_V1'
      consumes 'application/json', 'application/xml'
      description """
        Login API for version v1
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
                        password: { type: :string, required: true }
                      }
                    }
                  }
                }

      response '202', 'User SignIn Successfully' do
        schema '$ref' => '#/definitions/user_detail'

        let(:body) { { email: 'eee', password: 'hhhhh' } }
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
        end
      end
    end
  end
end
