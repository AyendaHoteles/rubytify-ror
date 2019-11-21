require 'rails_helper'

RSpec.describe Artist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "Test validations" do
    it "validate presence of name" do
      should validate_presence_of(:name)
    end
  end
end
