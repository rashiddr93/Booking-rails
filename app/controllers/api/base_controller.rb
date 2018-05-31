#
# BaseController
#
# @author rashid
#
module Api
  class BaseController < ApplicationController
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token
    
    def initialize_session
      return unless session_version_present?
      begin
        @session = Session.new(request)
      rescue Exceptions::RequiredHeaderMissingError => e
        render json: { message: "#{e.header} #{e.message}" }, status: :bad_request
      end
    end
  end
end
