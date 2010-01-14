class ChargeController < ApplicationController
  def index

    employee_id = User.find(session[:user_id]).employee_id
    @employee = Employee.find(employee_id)

    orders =  @employee.orders
    customer_ids = orders.map{ |order| order.customer.id }.uniq

    conditions = ["id in (?) ", customer_ids]

    if params[:keyword]
      keyword = "%" + params[:keyword] + "%"
      conditions[0] << "and furigana like ? "
      conditions << keyword
    end

    @customers = Customer.find(:all, :conditions => conditions)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
