class Api::MarketingsController < ApiController
  before_action :set_marketing, only: [:update, :destroy]

  # GET /marketings
  # GET /marketings.json
  def index
    page = params[:page].to_i
    limit = params[:limit].to_i
    offset = (page - 1) * limit

    results = Marketing.joins(:product, :source, :lead)
                        .order(time: :desc)
                        .select(
                            'marketings.id',
                            'marketings.content',
                            'marketings.result',
                            'marketings.time',
                            'sources.name AS source_name',
                            'products.name AS product_name',
                            'leads.name AS lead_name',
                        ).limit(limit).offset(offset)

    count = results.length

    (sources, leads, products) = [Source, Lead, Product].map(&:names)

    render json: { 
      items: results,
      sourceOptions: sources,
      productOptions: products,
      leadOptions: leads,
      total: count,
    }, status: :ok
  end

  # POST /marketings
  # POST /marketings.json
  def create
    instance = Marketing.new(marketing_params)

    if instance.save
      render json: { msg: instance }, status: :created
    else
      render json: { msg: instance.errors }, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /marketings/1
  # PATCH/PUT /marketings/1.json
  def update
    if @marketing.update(marketing_params)
      render json: { msg: @marketing }, status: :ok
    else
      render json: { msg: @marketing.errors }, status: :unprocessable_entity
    end

  end

  # DELETE /marketings/1
  # DELETE /marketings/1.json
  def destroy
    instance = @marketing.destroy
    render json: { msg: instance }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketing
      @marketing = Marketing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def marketing_params
      # params.require(:marketing).permit(:result, :source_id, :product_id, :lead_id)

      # # Find by id
      # params.require([:result, :source_id, :product_id, :lead_id])
      # params.permit(:content, :result, :source_id, :product_id, :lead_id)

      # Find by name
      params.require([:result, :source, :product, :lead, :time])
      instance = params.permit(:content, :result, :source, :product, :lead, :time)

      instance[:source] = Source.find_by_name(instance[:source])
      instance[:product] = Product.find_by_name(instance[:product])
      instance[:lead] = Lead.find_by_name(instance[:lead])
      instance = instance.slice('content', 'result', 'source', 'product', 'lead', 'time')
      instance

    end
end