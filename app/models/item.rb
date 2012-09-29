class Item < ActiveRecord::Base
  attr_accessible :description, :is_active, :name, :price, :price, :role
  has_many :billing_items
end
