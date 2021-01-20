class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, :limit => 20 
      t.string :email, :limit => 50
      t.string :password
      t.string :name, :limit => 30
      t.string :avatar
      t.string :roles, :limit => 30

    end

    up_only do
      User.create(
        username: 'admin',
        email: Faker::Internet.email(domain: 'example'),
        password: 'admin',
        name: Faker::Name.first_name,
        avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif',
        roles: 'admin'
      )

      User.create(
        username: 'editor',
        email: Faker::Internet.email(domain: 'example'),
        password: 'editor',
        name: Faker::Name.first_name,
        avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif',
        roles: 'editor'
      )
    end
  end
end
