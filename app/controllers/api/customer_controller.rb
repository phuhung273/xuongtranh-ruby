class Api::CustomerController < ApiController

  def index
    results = Sale.joins(:status)
                        .select(
                            'sales.id',
                            'sales.customer',
                            'sales.time',
                            'sales.modified_time',
                            'statuses.name AS status_name',
                        )

    count = results.length

    render json: { items: results, total: count }, status: :ok
  end

  def show
    sale = Sale.joins(:product, :status, :sale_lead)
                .select(
                  'sales.id',
                  'sales.customer',
                  'sales.demand',
                  'sales.connection',
                  'sales.email',
                  'sales.phone',
                  'sales.time',
                  'sales.modified_time',
                  'statuses.name AS status_name',
                  'products.name AS product_name',
                  'sale_leads.name AS sale_lead_name',
                )
                .find(params[:id])

    render json: { items: [sale], total: 1 }, status: :ok
  end

  def update
    sale = Sale.find(params[:id])

    if sale.update(customer_params)
      render json: { msg: sale }, status: :ok
    else
      render json: { msg: sale.errors }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def customer_params
      # params.require(:sale).permit(:customer, :sale_lead_id, :product_id, :demand, :connection, :status_id, :email, :phone)

      # params.require([:customer, :sale_lead_id, :product_id, :connection, :status_id])
      # params.permit(:customer, :sale_lead_id, :product_id, :demand, :connection, :status_id, :email, :phone)

      params.require([:status, :modified_time])
      instance = params.permit(:status, :modified_time)

      instance[:status] = Status.find_by_name(instance[:status])

      instance = instance.slice('status', 'modified_time')
      instance

    end
end
