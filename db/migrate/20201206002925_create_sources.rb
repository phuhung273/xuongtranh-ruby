class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.string :name, :limit => 20

    end

    up_only do
      Source.create(name: 'Facebook')
      Source.create(name: 'SEO')
      Source.create(name: 'SEM')
      
    end
  end
end