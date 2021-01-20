class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.string :customer, :limit => 30, null: false
      t.references :sale_lead, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :demand
      t.string :connection, null: false
      t.references :status, null: false, foreign_key: true
      t.string :email, :limit => 50
      t.string :phone, :limit => 20
      t.string :time, :limit => 25
      t.string :modified_time, :limit => 25

    end

    up_only do
      50.times do
        Sale.create(
          customer: Faker::Name.first_name,
          sale_lead: SaleLead.all.sample,
          product: Product.all.sample,
          status: Status.all.sample,
          demand: Faker::Lorem.sentence(word_count: 3),
          connection: Faker::Lorem.sentence(word_count: 3),
          email: Faker::Internet.email(domain: 'example'),
          phone: Faker::PhoneNumber.cell_phone_in_e164,
          time: '2020-12-01T17:00:00.000Z',
          modified_time: '2020-12-01T17:00:00.000Z',
        )
      end
    end
  end
end
