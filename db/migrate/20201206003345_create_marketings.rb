class CreateMarketings < ActiveRecord::Migration[6.0]
  def change
    create_table :marketings do |t|
      t.string :content
      t.integer :result, :limit => 1
      t.references :source, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :lead, null: false, foreign_key: true
      t.string :time, :limit => 25
       
    end

    up_only do
      50.times do
        Marketing.create(
          content: Faker::Lorem.sentence(word_count: 3),
          result: rand(1..10),
          source: Source.all.sample,
          product: Product.all.sample,
          lead: Lead.all.sample,
          time: '2020-12-01T17:00:00.000Z'
        )
      end
    end
  end
end
