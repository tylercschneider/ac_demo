class BalancesController < ApplicationController
  before_action :require_auth

  def show
    render json: { outstanding_balance: @current_user.outstanding_balance }
  end
end
