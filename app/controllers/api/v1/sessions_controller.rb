module Api
  module V1
    #
    # SessionsController
    #
    # @author rashid
    #
    class SessionsController < Api::BaseController
      before_action :find_user, only: :create

      # POST /users/sign_in
      def create
        if @user.present? && @user.valid_password?(params[:password])
          @session_key = Session.create_session_for(@user)
        else
          @message = @user.present? ? 'Invalid password' : 'User does not exist'
        end
        render_json_response
      end

      # DELETE /users/sign_out
      def destroy
        if @session.present?
          @session.delete
          render json: { message: 'Signed out successfully!' }, status: :ok
        else
          render json: { message: 'Invalid Session' }, status: :bad_request
        end
      end

      private

      def find_user
        @user = User.find_by_email(params[:email])
      end

      def render_json_response
        if @session_key.present?
          user_data = @user.public_attributes.merge!(session_key: @session_key)
          response = { success: true, user: user_data }
        else
          response = { success: false, message: @message }
        end
        render json: response
      end
    end
  end
end
