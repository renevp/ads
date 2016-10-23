require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:full_name)}
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:mobile_number)}
  it {should validate_presence_of(:status)}
  it {should validate_presence_of(:verified)}
end
