class BasketItem < ActiveRecord::Base
  attr_accessible :basket_id, :product_id, :order_id, :quantity, :sizing_id, :item_price
  
  belongs_to :product
  belongs_to :basket
  belongs_to :order
  belongs_to :sizing

  validates :product_id, :quantity, :sizing_id, :basket_id, presence: :true

  before_save :price_times_quantity

  scope :size_quantity, lambda {|sizing,product| joins(:sizing).where("sizings.id" => sizing, :product_id => product).select("sizings.quantity") }

  def self.product_totals(basket_id)
    joins(:basket).where(:basket_id => basket_id).sum("item_price")
  end

  def self.add_item(basket_items)
    item =  self.where(:product_id => basket_items[:product_id], :sizing_id => basket_items[:sizing_id], :basket_id => basket_items[:basket_id]).first
    if item
      item.quantity += 1
    else
      item = self.create(basket_items)
    end
    item
  end

  def self.update_item(basket_item)
    item = self.find(basket_item[:id])
    sizing = self.size_quantity(basket_item[:sizing_id],basket_item[:product_id]).last
    quantity = sizing.attributes["quantity"]
    desired_quantity = basket_item[:quantity].to_i

    if quantity == 0
      item.errors.add(:quantity, "Oh no there's no more in stock")
    elsif desired_quantity == quantity ^ desired_quantity <= quantity
      item.update_attributes(:quantity => desired_quantity)
    else desired_quantity > quantity
      wanted = desired_quantity - quantity
      gotten = desired_quantity - wanted
      item.update_attributes(:quantity => gotten)
    end
  end

  def price_times_quantity
   self.item_price = quantity * product.price
  end
end
