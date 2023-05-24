# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # def new eu
  #   super
  #   resource.credit_cards.build
  # end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  # def create eu
  #   super do |resource|
  #     resource.credit_cards.build(sign_up_params[:credit_cards_attributes])
  #     resource.save
  #   end
  # end

  # def sign_up_params eu
  #   params.require(:user).permit(:email, :password, :password_confirmation, credit_cards_attributes: [:number, :expiry_date])
  # end
  # def create
  #   super do |resource|
  #     # Salvează cardurile atașate userului înregistrat
  #     params[:user][:credit_cards_attributes].each do |_, cc_params|
  #       resource.credit_cards.create(cc_params)
  #     end
  #   end
  # end
  #
  # private
  #
  # def sign_up_params eu
  #   params.require(:user).permit(:email, :password, :password_confirmation, credit_cards_attributes: [:number, :expiry_date])
  # end
  #
  # def build_resource(hash = {}) eu
  #   self.resource = resource_class.new_with_session(hash, session)
  #   self.resource.credit_cards.build # Această linie adaugă un nou obiect CreditCard asociat utilizatorului
  #   self.resource
  # end
  #
  # def new eu
  #   build_resource({})
  #   resource.credit_cards.build
  #   respond_with self.resource
  # end
  #
  # def create eu
  #   super do |resource|
  #     if resource.valid?
  #       credit_card_params = params.require(:user).permit(credit_cards_attributes: [:number, :expiry_date])
  #       resource.credit_cards.create(credit_card_params[:credit_cards_attributes]['0'])
  #     end
  #   end
  # end


  def new
    build_resource
    resource.credit_cards.build
    respond_with resource
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, credit_cards_attributes: [:number, :expiry_date])
  end



end
