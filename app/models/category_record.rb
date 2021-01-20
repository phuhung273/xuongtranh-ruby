class CategoryRecord < ApplicationRecord
    self.abstract_class = true
    
    scope :names, -> { pluck(:name) }
    
end