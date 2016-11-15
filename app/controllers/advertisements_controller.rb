
class AdvertisementsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :owners_only, only: [ :edit, :update, :destroy ]

  def index
    @advertisements = Advertisement.published
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)
    @advertisement.user = current_user
    if @advertisement.save
      redirect_to advertisement_path(@advertisement), notice: 'Achievement has been created'
    else
      render :new
    end
  end

  def edit
    @advertisement
  end

  def update
    if @advertisement.update_attributes(advertisement_params)
      redirect_to advertisement_path(@advertisement)
    else
      render :edit
    end
  end

  def destroy
    @advertisement.destroy
    redirect_to advertisements_path
  end

  private

  def advertisement_params
    params.require(:advertisement).permit(:title, :description, :price_cents, :status, :user, :ad_type)
  end

  def owners_only
    @advertisement = Advertisement.find(params[:id])
    if current_user != @advertisement.user
      redirect_to advertisements_path
    end
  end
end
