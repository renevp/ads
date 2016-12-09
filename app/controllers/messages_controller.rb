class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy, :index, :show ]
  before_action :owners_only, only: [ :destroy ]

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    if message_params.permitted?
      @message = Message.new
      @message.sender = current_user
      @message.recipient = User.find(params[:message][:recipient])
      @message.advertisement = Advertisement.find(params[:message][:advertisement])
      @message.title = params[:message][:title]
      @message.body = params[:message][:body]
      @message.body = params[:message][:status]
      if @message.save
        redirect_to user_message_path(current_user, @message), notice: "Message has been sent"
      else
        render :new, alert: "Message can'be created"
      end
    else
      render :new, alert: "Message can'be created, invalid params"
    end
  end

  def destroy
    @message.destroy
    redirect_to user_messages_path, notice: "Message deleted"
  end

  private

  def message_params
    params.require(:message).permit(:title, :body, :recipient, :sender, :advertisement, :status)
  end

  def owners_only
    @message = Message.find(params[:id])
    binding.pry
    if current_user != @message.recipient
      redirect_to user_messages_path, alert: "You aren't the owner of this message!"
    end
  end
end
