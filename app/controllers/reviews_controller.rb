
class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
  end

  def index
  end

  def new
    @review = Review.new
    redirect_to new_user_review_url
  end

  def edit
  end

  def show
  end

  def update
  end
end
