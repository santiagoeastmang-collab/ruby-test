class SignUpsController < ApplicationController
    unauthenticated_access_only
    rate_limi to: 10, within: 3.minutes, only: :create, with: -> { 
        redirect_to sign_up_oath, alert: "Try again later."
     }

    def show
        @user = User.new
    end

    # assigns parameters and attepts to save the user to the databese
    def create
        @user = User.new(sign_up_params)
        if @user.save
          start_new_session_for(@user)
          redirect_to root_path
        else
          render :show, status: :unprocessable_entity
        end
    end

    private
        def sign_up_params
            params.expect(user: [ :firts_name, :last_name, :email_address, :password, :password_confirmation ])
        end
    
end