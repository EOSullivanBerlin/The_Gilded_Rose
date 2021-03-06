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

    describe 'exceptional item Sulfuras, Hand of Ragnaros' do
      it "Sulfuras, being a legendary item, never has to be sold or decreases in Quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 48)]
        gildedr = GildedRose.new(items)
        gildedr.update_quality()
        expect(items[0].quality).to eq 48
        expect(items[0].sell_in).to eq 10
        gildedr.update_quality()
        expect(items[0].quality).to eq 48
        expect(items[0].sell_in).to eq 10
      end
    end
  end

  describe 'exceptional item Backstage passes' do
    it "Backstage passes, like aged brie, increases in Quality as its Sell_In value approaches" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 10)]
      gildedr = GildedRose.new(items)
      gildedr.update_quality()
      expect(items[0].quality).to eq 11
    end

    it "Quality increases by 2 when there are 10 days or less " do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      gildedr = GildedRose.new(items)
      gildedr.update_quality()
      expect(items[0].quality).to eq 12
    end

    it "increases by 3 when there are 5 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
      gildedr = GildedRose.new(items)
      gildedr.update_quality()
      expect(items[0].quality).to eq 13
    end

    it "increases by 3 when there are 5 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
      gildedr = GildedRose.new(items)
      gildedr.update_quality()
      expect(items[0].quality).to eq 13
    end

    it "Quality drops to 0 after the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      gildedr = GildedRose.new(items)
      gildedr.update_quality()
      expect(items[0].quality).to eq 0
    end
  end

  describe "#daily_quality_value_decrease" do
    it "reduces the values for sell_in for every item by 1" do
      items = [Item.new("foo", 10, 10)]
      gildedr = GildedRose.new(items)
      gildedr.daily_quality_value_decrease(items[0])
      expect(items[0].quality).to eq 9
    end
  end

  describe "#daily_sell_in_value_decrease" do
    it "reduces the values for quality for every item by 1" do
      items = [Item.new("foo", 10, 10)]
      gildedr = GildedRose.new(items)
      gildedr.daily_sell_in_value_decrease(items[0])
      expect(items[0].sell_in).to eq 9
    end
  end

  describe "#post_sell_in_quality_decrease" do
    it "reduces the values for quality by 2 for every day" do
      items = [Item.new("foo", 0, 10)]
      gildedr = GildedRose.new(items)
      gildedr.post_sell_in_quality_decrease(items[0])
      expect(items[0].quality).to eq 8
    end
  end

  describe "#Daily increses in quality" do
    it "increses the values of quality by 1 every day" do
      items = [Item.new("Aged Brie", 2, 10)]
      gildedr = GildedRose.new(items)
      gildedr.daily_quality_value_increses(items[0])
      expect(items[0].quality).to eq 11
    end
  end

  describe '#Conjured item' do
    it 'decreses in quality twice as fast' do
      items = [Item.new("Conjured", 10, 10)]
      gildedr = GildedRose.new(items)
      gildedr.update_quality()
      expect(items[0].quality).to eq 8
    end
  end


end
