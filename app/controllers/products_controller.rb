class ProductsController < ApplicationController
  def index
    @products = Product.all
    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(Product.all), file_name: 'products.csv'}
    end

  end

  def show
    @product = Product.find(params[:id])
  end
  
  def csv_upload
    data = params[:csv_file].read.split("\n")
    data.each do |line| 
      attribute = line.split(",").map(&:strip)
      Product.create title: attribute[0], description: attribute[1], stock: attribute[2]
    end
    redirect_to action: :index
  end 


  def generate_csv(products)
    products.map { |p| [p.name, p.description, p.created_at].join(',') }.join("\n")
  end

end
