class Sale < ApplicationRecord
  belongs_to :sale_lead
  belongs_to :product
  belongs_to :status
end
