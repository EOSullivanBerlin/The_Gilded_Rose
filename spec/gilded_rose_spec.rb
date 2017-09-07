require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    describe "normal items" do
      it "does not change the name" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
      end

      it 'decreases the sell by day by one' do
        items = [Item.new("foo", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 1
      end

      it 'decreases the quality of every item' do
        items = [Item.new("foo", 2, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end

      it 'once the sell by date has passed it ages twice as fast' do
        items = [Item.new("foo", 1, 10)]
        gildedr = GildedRose.new(items)
        gildedr.update_quality()
        expect(items[0].quality).to eq 9
        gildedr.update_quality()
        #it reduces by two once it reaches the sell by date
        expect(items[0].quality).to eq 7
        gildedr.update_quality()
        expect(items[0].quality).to eq 5
        gildedr.update_quality()
        expect(items[0].quality).to eq 3
      end

      it "the quality of the item is never below zero" do
        items = [Item.new("foo", 1, 1)]
        gildedr = GildedRose.new(items)
        gildedr.update_quality()
        gildedr.update_quality()
        gildedr.update_quality()
        expect(items[0].quality).to eq 0
      end



    end

    describe 'exceptional item Aged Brie' do
      it "increses in value over time" do
        items = [Item.new("Aged Brie", 2, 30)]
        gildedr = GildedRose.new(items)
        gildedr.update_quality()
        expect(items[0].quality).to eq 31
        gildedr.update_quality()
        expect(items[0].quality).to eq 32
        #the brie also increses in value twice as fast after the date
        gildedr.update_quality()
        expect(items[0].quality).to eq 34
      end

      it "the quality of an item cannot go over 50" do
        items = [Item.new("Aged Brie", 10, 48)]
        gildedr = GildedRose.new(items)
        gildedr.update_quality()
        expect(items[0].quality).to eq 49
        gildedr.update_quality()
        expect(items[0].quality).to eq 50
        gildedr.update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    describe 'exceptional item "Sulfuras, Hand of Ragnaros"' do
      
    end

  end

end
