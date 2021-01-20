class Marketing < ApplicationRecord
  belongs_to :source
  belongs_to :product
  belongs_to :lead
end
