
class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.new(review_params)
    @review.reviewer = current_user
    @review.reviewee = User.find(params[:user_id])
    if @review.save
      redirect_to user_path(@review.reviewee), notice: 'Review has been created'
    else
      render :new
    end
  end

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      redirect_to user_reviews_url(@review.reviewee), notice: 'Review has been updated'
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :feedback)
  end
end
