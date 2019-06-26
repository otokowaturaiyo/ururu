module ApplicationHelper
  def product_array_maker(product)
    stock_array = []
    product_count = 0
    product.stock.times do
      # if quantity > product.stock
        stock_array << product_count + 1
        product_count = product_count + 1
      # else
        # break
      # end
    end
    return stock_array
  end

end
