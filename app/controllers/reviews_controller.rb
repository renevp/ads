
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
    @user = User.find(params[:user_id])
    @reviews = Review.user_reviews(@user)
  end

  def new
    @user = User.find(params[:user_id])
    reviewer = current_user
    reviewee = @user
    reviews = Review.user_reviewed?(reviewee, reviewer)
    if reviews.count > 0
      @review = reviews[0]
      render :edit
      return
    else
      @review = Review.new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to user_path(@review.reviewee), notice: 'Review has been updated'
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :feedback)
  end
end
