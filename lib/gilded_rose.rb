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

  def post_sell_in_quality_decrease(item)
    item.quality = item.quality - 2
  end

  def daily_sell_in_value_decrease(item)
    item.sell_in = item.sell_in - 1
  end

#  p "#{item.sell_in} #{item.name} #{item.quality}"

  def update_quality()
    @items.each do |item|
     if item.name == @exceptional_item_classes[0] && quality_less_than_50?(item)
        item.sell_in <= 0 ? post_sell_in_quality_increses(item) : daily_quality_value_increses(item)
        daily_sell_in_value_decrease(item)
      return
      end

      # if item.name == @exceptional_item_classes[1]
      #   item.sell_in <= 10 ? post_sell_in_quality_increses(item) : daily_quality_value_increses(item)
      #   daily_sell_in_value_decrease(item)
      # end


      if item.name == @exceptional_item_classes[2]
        return
      end

      # if item.name == @exceptional_item_classes[2]
      #   return item
      # end

      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
            item.quality = item.quality - 1
        end
      else
        if item.quality < 50 and item.name
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
        item.sell_in = item.sell_in - 1
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
                item.quality = item.quality - 1
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  private

  def quality_less_than_50?(item)
    item.quality < 50
  end

  def quality_equal_or_greater_than_50?(item)
    item.quality <= 50
  end
end
