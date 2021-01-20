class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.string :name, :limit => 20

    end

    up_only do
      Status.create(name: 'Hello')
      Status.create(name: 'Consulting')
      Status.create(name: 'Design Pick-up')
      Status.create(name: 'Contract Sent')
      Status.create(name: '1st Deposit')
      Status.create(name: 'Production')
      Status.create(name: 'Fully Payment')
      Status.create(name: 'Lost')
      
    end
  end
end
