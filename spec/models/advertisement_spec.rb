require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user)}
  it { should belong_to(:user) }
  it { should validate_presence_of(:status)}
  it { should validate_presence_of(:ad_type)}
end
