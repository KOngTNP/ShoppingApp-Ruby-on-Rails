class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!
  
    def index
      @orders = Order.all
    end
    
    def create
      @orders = Order.new(orders_params)
      # if @category.save
      #   flash[:notice] = "Category added!"
      #   redirect_to admin_categories_path
      # else
      #   flash[:notice] = "Category can't be blank!"
      #   render 'admin/products/new'
      # end
    end

    private

      def orders_params
        params.require(:orders).permit(:name)
      end


  end
  