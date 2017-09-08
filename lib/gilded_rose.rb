require 'item'

class GildedRose

  def initialize(items)
    @items = items
    @exceptional_item_classes = [
      "Aged Brie",
      "Backstage passes to a TAFKAL80ETC concert",
      "Sulfuras, Hand of Ragnaros",
      "Conjured"
    ]
  end



  def daily_quality_value_decrease(item)
    item.quality = item.quality - 1
  end

  def daily_quality_value_increses(item)
    item.quality = item.quality + 1
  end

  def post_sell_in_quality_increses(item)
    item.quality = item.quality + 2
  end

  def treble_quality_increses(item)
    item.quality = item.quality + 3
  end

  def post_sell_in_quality_decrease(item)
    item.quality = item.quality - 2
  end

  def daily_sell_in_value_decrease(item)
    item.sell_in = item.sell_in - 1 if item.sell_in > 0
  end

#  p "#{item.sell_in} #{item.name} #{item.quality}"

  def update_quality()
    @items.each do |item|
     if item.name == @exceptional_item_classes[0] && quality_equal_or_less_than_50?(item)
        if item.quality < 50
        item.sell_in <= 0 ? post_sell_in_quality_increses(item) : daily_quality_value_increses(item)
        end
        daily_sell_in_value_decrease(item)
      return
      end


      if item.name == @exceptional_item_classes[1]
        treble_quality_increses(item) if item.sell_in <= 5 && item.sell_in >= 0
        post_sell_in_quality_increses(item) if  item.sell_in <= 10 && item.sell_in > 5
        daily_quality_value_increses(item) if item.sell_in > 10
        item.quality = 0 if item.sell_in <= 0
        daily_sell_in_value_decrease(item)
        return
      end


      if item.name == @exceptional_item_classes[2]
        return
      end

      if item.name == @exceptional_item_classes[3]
        post_sell_in_quality_decrease(item)
        item.quality = 0 if item.sell_in <= 0 && item.quality > 0
        return
      end

      daily_quality_value_decrease(item)  if item.sell_in > 0 && item.quality > 0
      post_sell_in_quality_decrease(item)  if item.sell_in <= 0 && item.quality > 0
      daily_sell_in_value_decrease(item)

    end
  end

  private

  def quality_equal_to_50?(item)
    item.quality == 50
  end

  def quality_less_than_50?(item)
    item.quality < 50
  end

  def quality_equal_or_less_than_50?(item)
    item.quality <= 50
  end
end
