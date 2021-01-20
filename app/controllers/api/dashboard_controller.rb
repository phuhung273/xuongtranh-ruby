class Api::DashboardController < ApiController
  before_action :set_time_range

  def index
    customers = Sale.joins(:status)
                      # .order('statuses.id ASC')
                      .group('time','statuses.name')
                      .having(time: @time_range[:from]..@time_range[:to])
                      .count

    marketings = Marketing.joins(:product, :lead)
                            .group('time', 'products.name', 'leads.name')
                            .having(time: @time_range[:from]..@time_range[:to])
                            .sum(:result)

    sales = Sale.joins(:sale_lead, :product)
                  .group('time', 'products.name', 'sale_leads.name')
                  .having(time: @time_range[:from]..@time_range[:to])
                  .count

    customers = RecordUtil.group2_to_h(customers)
    customers = HashUtil.to_hash_array_with_names(customers, 'time', 'status', 'result')

    marketings = RecordUtil.group3_to_h(marketings)
    marketings = HashUtil.to_hash_array_with_names(marketings, 'time', 'product', 'lead', 'result')

    sales = RecordUtil.group3_to_h(sales)
    sales = HashUtil.to_hash_array_with_names(sales, 'time', 'product', 'lead', 'result')

    marketingPerformance = Marketing.joins(:lead)
                                      .group('time', 'leads.name')
                                      .having(time: @time_range[:from]..@time_range[:to])
                                      .sum(:result)
    marketingPerformance = RecordUtil.group2_to_h(marketingPerformance)
    marketingPerformance = HashUtil.to_hash_array_with_names(marketingPerformance, 'time', 'lead', 'result')

    render json: { 
      customers: customers,
      marketings: marketings,
      marketingLeadOptions: Lead.names,
      marketingPerformance: marketingPerformance,
      sales: sales,
    }, status: :ok
  end

  def marketing
    @results = Marketing.joins(:product, :lead)
                          .order(time: :asc)
                          .where(time: @time_range[:from]..@time_range[:to])
                          .select(
                              'marketings.result',
                              'marketings.time',
                              'products.name AS product_name',
                              'leads.name AS lead_name',
                          )

    response_results
  end

  def sale
    resultProduct = Sale.joins(:product)
                        .group('time', 'products.name')
                        .order(time: :asc)
                        .having(time: @time_range[:from]..@time_range[:to])
                        .count
    
                        
    resultProduct = RecordUtil.group2_to_h(resultProduct)
    resultProduct = HashUtil.to_hash_array_with_names(resultProduct, 'time', 'product', 'result')
    
    totalResult = Sale.group('time')
                        .order(time: :asc)
                        .having(time: @time_range[:from]..@time_range[:to])
                        .count
    totalResult = HashUtil.to_hash_array_with_names(totalResult, 'time', 'result')

    resultLead = Sale.joins(:sale_lead)
                        .group('time', 'sale_leads.name')
                        .order(time: :asc)
                        .having(time: @time_range[:from]..@time_range[:to])
                        .count
                        
    resultLead = RecordUtil.group2_to_h(resultLead)
    resultLead = HashUtil.to_hash_array_with_names(resultLead, 'time', 'lead', 'result')

    render json: { 
      totalResult: totalResult,
      resultProduct: resultProduct,
      resultLead: resultLead,
      productOptions: Product.names,
      leadOptions: SaleLead.names,
    }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_range
      params.require([:from, :to])
      @time_range = params.permit(:from, :to)
    end
end
