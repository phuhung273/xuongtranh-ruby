class CreateSaleLeads < ActiveRecord::Migration[6.0]
  def change
    create_table :sale_leads do |t|
      t.string :name, :limit => 20

    end

    up_only do
      SaleLead.create(name: 'Facebook inbox')
      SaleLead.create(name: 'Hotline call')
      SaleLead.create(name: 'Zalo call/inbox')
      
    end
  end
end
