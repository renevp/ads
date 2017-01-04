class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy, :index, :show ]
  before_action :owners_only, only: [ :destroy ]
  before_action :validate_username, only: [ :create ]

  def index
    @advertisement = Advertisement.find(params[:advertisement_id])
    @messages = Message.advertisement_messages(@advertisement)
    @message = Message.new
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new(parent_id: params[:parent_id])
    @advertisement = Advertisement.find(params[:advertisement_id])
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    @advertisement = Advertisement.find(params[:advertisement_id])
    @message.advertisement = @advertisement
    @message.recipient = User.find(@message.advertisement.user.id)

    respond_to do |format|
      if @message.save
        MessageMailer.new_message(@message).deliver
        unless params[:message][:parent_id].empty?
          format.html { redirect_to advertisement_messages_path(@advertisement), notice: "Message has been sent" }
        else
          format.js
        end
      else
        format.html { render :new, alert: "Message can'be created" }
      end
    end
  end

  def destroy
    @message.destroy
    redirect_to advertisement_messages_path, notice: "Message deleted"
  end

  private

  def message_params
    params.require(:message).permit(:title, :body, :recipient, :sender, :advertisement_id, :status, :parent_id)
  end

  def owners_only
    @message = Message.find(params[:id])
    if current_user != @message.sender
      redirect_to advertisement_messages_path, alert: "You aren't the owner of this message!"
    end
  end

  def validate_username
    if current_user && current_user.username == 'facebook'
      redirect_to username_user_path(current_user)
    end
  end
end
