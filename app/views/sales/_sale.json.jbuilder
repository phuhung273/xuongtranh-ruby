json.extract! sale, :id, :customer, :sale_lead_id, :product_id, :demand, :connection, :status_id, :email, :phone, :time, :modified_time, :created_at, :updated_at
json.url sale_url(sale, format: :json)
