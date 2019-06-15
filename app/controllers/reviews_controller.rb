class ReviewsController < ApplicationController
	def index
	end

	def create
		 @product = Product.find(params[:product_id])
		 @review = @product.reviews.build(review_params)
		 @review.user_id = current_user.id
		 @review.save
		 render :index
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		product = Product.find(params[:id])
		product.review.update(review_params)
		redirect_to product_path(product)
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		render :index

	end


	private

    def review_params
        params.require(:review).permit(:user_id, :product_id, :star, :body)
    end

end
