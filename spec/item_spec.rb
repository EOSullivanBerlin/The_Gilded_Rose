require 'gilded_rose'

describe Item do

  describe "#sell_in" do
    it "has a sell in value" do
      item = [Item.new("foo", 0, 0)]
      expect(item.to_s( )).to include "@sell_in=0"
    end
  end

end
