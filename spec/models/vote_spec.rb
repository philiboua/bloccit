require 'rails_helper'

describe Vote do

  
  describe "validations" do
    describe "value validation" do
      it "only allow -1 or 1 as values" do

        down_vote = Vote.new(value: -1)
        expect(down_vote.valid?).to eq(true)

        up_vote = Vote.new(value: 1)
        expect(up_vote.valid?).to eq(true) 

        invalid_vote = Vote.new(value: 4)
        expect(invalid_vote.valid?).to eq(false) 
      end
    end
  end

end
