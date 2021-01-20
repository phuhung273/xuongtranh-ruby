class CreateLeads < ActiveRecord::Migration[6.0]
  def change
    create_table :leads do |t|
      t.string :name, :limit => 20

    end

    up_only do
      Lead.create(name: 'Facebook inbox')
      Lead.create(name: 'Call')
      
    end
  end
end
