class Admin::ProductsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @products = Product.all

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      @category_array = params.dig(:product, :category_ids)
      @category_array.each do |cat|
        @category = Category.find(cat)
        @product.categories << @category
      end
      flash[:notice] = "Product added!"
      redirect_to admin_products_path
    else
      flash[:notice] = "Product can't be blank!"
      render 'admin/products/new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      @product.product_categories.destroy_all
      @category_array = params.dig(:product, :category_ids)
      @category_array.each do |cat|
        @category = Category.find(cat)
        @product.categories << @category
      end
      flash[:notice] = "Product updated!"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    Product.destroy(params[:id])
    flash[:notice] = "Product removed!"
    redirect_to admin_products_path
  end

  def csv_upload
    data = params[:csv_file].read.split("\n")
    data.each do |line| 
      attribute = line.split(",").map(&:strip)
      Product.create title: attribute[0], description: attribute[1], stock: attribute[2]
    end
    redirect_to action: :index
  end 

  def delete_upload
    Product.image.destroy(params[:id])
  end


  private
    def set_product
      @product = Product.find(params[:id])
    end

    def generate_csv(products)
      products.map { |p| [p.title, p.description, p.created_at].join(',') }.join("\n")
    end
    
  
    def product_params
      pp = params.require(:product).permit(:name, :description, :price, :image)
      pp[:status] = params[:product][:status].to_i
      return pp
 end

end
