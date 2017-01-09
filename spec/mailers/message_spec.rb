require "rails_helper"

RSpec.describe MessageMailer, type: :mailer do
  describe "new_message" do
    let(:message) { FactoryGirl.create(:message)}
    let(:mail) { MessageMailer.new_message(message) }

    it "renders the headers" do
      expect(mail.subject).to eq("New message")
      expect(mail.to).to eq([message.recipient.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi #{message.recipient.full_name}")
    end
  end

end
