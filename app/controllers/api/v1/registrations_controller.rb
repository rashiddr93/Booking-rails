module Api
  module V1
    #
    # RegistrationController
    #
    # @author rashid
    #
    class RegistrationsController < Api::BaseController
      def create
        @user = User.new(user_params)
        if @user.save
          @session_key = Session.create_session_for(@user)
        else
          @message = @user.errors.full_messages[0]
        end
        render_json_response
      end

      private

      def render_json_response
        if @session_key.present?
          user_data = @user.public_attributes.merge!(session_key: @session_key)
          response = { success: true, user: user_data }
        else
          response = { success: false, message: @message }
        end
        render json: response
      end

      def user_params
        params.require(:user).permit(:email, :password, :name, :dob)
      end
    end
  end
end
