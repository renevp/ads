class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy, :index, :show ]
  before_action :owners_only, only: [ :destroy ]

  def index
    @messages = Message.user_messages(current_user)
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    @advertisement = Advertisement.find(params[:advertisement_id])
    binding.pry
  end

  def create
    if message_params.permitted?
      @message = Message.new
      @message.sender = current_user
      @message.advertisement = Advertisement.find(params[:advertisement_id])
      @message.recipient = User.find(@message.advertisement.user.id)
      @message.body = params[:body]
      if @message.save
        redirect_to advertisement_message(current_user, @message), notice: "Message has been sent"
      else
        render :new, alert: "Message can'be created"
      end
    else
      render :new, alert: "Message can'be created, invalid params"
    end
  end

  def destroy
    binding.pry
    @message.destroy
    redirect_to user_messages_path, notice: "Message deleted"
  end

  private

  def message_params
    params.require(:message).permit(:title, :body, :recipient, :sender, :advertisement_id, :status)
  end

  def owners_only
    @message = Message.find(params[:id])
    if current_user != @message.recipient
      redirect_to user_messages_path, alert: "You aren't the owner of this message!"
    end
  end
end
