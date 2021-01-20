class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, :limit => 15

    end

    up_only do
      Product.create(name: 'Tranh vẽ tường')
      Product.create(name: 'Tranh canvas')
      
    end
  end
end
