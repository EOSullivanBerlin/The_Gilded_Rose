require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    describe "normal items" do
      it "does not change the name" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
      end

      it 'deceses the sell by day by one' do
        items = [Item.new("foo", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 1
      end

      it 'deceses the quality of every item' do
        items = [Item.new("foo", 2, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end
    end

    describe 'exceptional item aged bree' do
      
    end
  end

end
