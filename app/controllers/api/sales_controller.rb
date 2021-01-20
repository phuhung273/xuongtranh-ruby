class Api::SalesController < ApiController
  before_action :set_sale, only: [:update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    page = params[:page].to_i
    limit = params[:limit].to_i
    offset = (page - 1) * limit

    results = Sale.joins(:product, :status, :sale_lead)
                        .order(time: :desc)
                        .select(
                            'sales.id',
                            'sales.customer',
                            'sales.demand',
                            'sales.connection',
                            'sales.email',
                            'sales.phone',
                            'sales.time',
                            'statuses.name AS status_name',
                            'products.name AS product_name',
                            'sale_leads.name AS sale_lead_name',
                        ).limit(limit).offset(offset)

    count = results.length

    (statuses, products, sale_leads) = [Status, Product, SaleLead].map(&:names)

    render json: {
      items: results,
      statusOptions: statuses,
      productOptions: products,
      leadOptions: sale_leads,
      total: count,
    }, status: :ok
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # POST /sales
  # POST /sales.json
  def create
    instance = Sale.new(sale_params)

      if instance.save
        render json: { msg: instance }, status: :created
      else
        render json: { msg: instance.errors }, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    if @sale.update(sale_params)
      render json: { msg: @sale }, status: :ok
    else
      render json: { msg: @sale.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    instance = @sale.destroy
    render json: { msg: instance }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      # params.require(:sale).permit(:customer, :sale_lead_id, :product_id, :demand, :connection, :status_id, :email, :phone)

      # params.require([:customer, :sale_lead_id, :product_id, :connection, :status_id])
      # params.permit(:customer, :sale_lead_id, :product_id, :demand, :connection, :status_id, :email, :phone)

      params.require([:customer, :lead, :product, :connection, :status, :time])
      instance = params.permit(:customer, :lead, :product, :demand, :connection, :status, :email, :phone, :time, :modified_time)

      instance[:sale_lead] = SaleLead.find_by_name(instance[:lead])
      instance[:product] = Product.find_by_name(instance[:product])
      instance[:status] = Status.find_by_name(instance[:status])

      instance = instance.slice('customer', 'sale_lead', 'product', 'demand', 'connection', 'status', 'email', 'phone', 'time', 'modified_time')
      instance
    end
end
