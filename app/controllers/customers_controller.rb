class CustomersController < ApplicationController
  before_action :get_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def show
  end

  def create
    @customer = Customer.create(customer_params)
    if @customer.errors.present?
      render 'new'
    else
      redirect_to customer_path(@customer)
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render 'edit'
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end

  private

  def customer_params
    params.require(:customer).permit(
      :email,
      :user_name,
      :password,
      :password_confirmation,
      :date_of_birth,
      :gender,
      :phone_number
    )
  end

  def get_customer
    @customer = Customer.find(params[:id])
  end
end
