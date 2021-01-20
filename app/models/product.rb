class Product < CategoryRecord
    has_many :marketings
    has_many :sales
end
