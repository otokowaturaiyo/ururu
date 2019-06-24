class Admins::ReviewsController < ApplicationController
  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
  end

  def update
    product = Product.find(params[:product_id])
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to admins_product_path(product)
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admins_product_path(id: @product)
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :product_id, :star, :body)
  end
end
