class Basket < ActiveRecord::Base
  attr_accessible :basket_id, :status, :order_id
  has_many :basket_items, :dependent => :destroy
  has_one :order, :dependent => :destroy

  def self.item_totals(basket) 
    joins(:basket_items).where("basket_items.basket_id" => basket).sum("item_price")
  end
end
