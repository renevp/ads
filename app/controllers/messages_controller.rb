class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy, :index, :show ]
  before_action :set_message, only: [ :destroy, :show ]
  before_action :set_advertisement, only: [ :index, :new, :create ]
  before_action :owners_only, only: [ :destroy ]
  before_action :request_username, only: [ :create ]

  include UsernameRequestable

  def index
    @messages = Message.advertisement_messages(@advertisement)
    @message = Message.new
  end

  def show
  end

  def new
    @message = Message.new(parent_id: params[:parent_id])
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.advertisement = @advertisement
    @message.recipient = User.find(@message.advertisement.user.id)

    respond_to do |format|
      if @message.save
        MessageMailer.new_message(@message).deliver
        unless params[:message][:parent_id] && params[:message][:parent_id].empty?
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

  def set_message
    @message = Message.find(params[:id])
  end

  def set_advertisement
    @advertisement = Advertisement.find(params[:advertisement_id])
  end

  def owners_only
    if current_user != @message.sender
      redirect_to advertisement_messages_path, alert: "You aren't the owner of this message!"
    end
  end


end
