class BasketItem < ActiveRecord::Base
  attr_accessible :basket_id, :product_id, :order_id, :quantity, :size_id, :item_price
  attr_accessible :item_price
  
  belongs_to :product
  belongs_to :basket
  belongs_to :order
  belongs_to :size

  validates :product_id, :quantity, :size_id, :basket_id, presence: :true

  before_save :price_times_quantity

  def self.product_totals(basket_id)
    joins(:basket, :product).where(:basket_id => basket_id).sum("item_price")
  end

  def self.add_item(params)
    item =  self.where(:product_id => params[:product_id], :size_id => params[:size_id], :basket_id => params[:basket_id]).first
    if item
      item.quantity += 1
    else
      item = self.create(params)
    end
    item
  end

  def self.update_item(params)
    item = self.find(params[:id])
    if item.quantity <= 0
      item.destroy
    else
      item.update_attributes(:quantity => params[:quantity])
    end
  end

  def price_times_quantity
   self.item_price = quantity * product.price
  end
end
