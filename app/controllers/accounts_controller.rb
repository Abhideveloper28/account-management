class AccountsController < ApplicationController
  before_action :get_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def show
  end

  def create
    @account = Account.create(account_params)
    if @account.errors.present?
      render 'new'
    else
      redirect_to account_path(@account)
    end
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to account_path(@account)
    else
      render 'edit'
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_path
  end

  private

  def account_params
    params.require(:account).permit(
      :account_type,
      :branch,
      :minor_indicator,
      :open_date
    )
  end

  def get_account
    @account = Account.find(params[:id])
  end
end
