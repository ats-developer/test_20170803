class SecretCodesController < ApplicationController
  load_and_authorize_resource
  def index
    @secret_codes = SecretCode.all
  end

  def create
    no_of_codes = params[:secret_code][:code].to_i
    ActiveRecord::Base.transaction do
      no_of_codes.times do |i|
        SecretCode.create!(code: SecureRandom.hex(3))
      end
    end
    flash[:notice] = "#{helpers.pluralize(no_of_codes, 'Secret Code')} generated successfully."
    redirect_to action: :index
  end

  protected
  def secret_code_params
    params.require(:secret_code).permit(:code)
  end
end
