class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :edit, :update]

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
    unless @customer == current_customer
     redirect_to customers_mypage_path
    end
  end

  def update
    if current_customer.update(customer_params)
      redirect_to customers_mypage_path
    else
      redirect_to edit_customer_path
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def widthdraw
    @customer = current_customer
    @customer.update(is_active: true)
    reset_session
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end


end
