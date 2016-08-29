# GenericController: Generic, scope-oriented resource controller functions
class GenericController < ActionController::Base
  VALID_SORT = %w(asc desc).freeze

  def create
    @resource = cscope.new(model_params)
    @resource.save!
    respond_to do |f|
      f.any do
        response.headers['location'] = send("v#{api_version}_#{model_name.underscore}_url", @resource)
        render({ json: @resource,
                 serializer: each_sez,
                 status: :created }.merge!(render_options))
      end
    end
  end

  def destroy
    model.destroy(params[:id])
    respond_to do |f|
      f.any do
        head :no_content
      end
    end
  end

  def show
    respond_to do |f|
      f.any do
        render({
                 json: @resource,
                 serializer: each_sez,
                 status: :ok
               }.merge!(render_options))
      end
    end
  end

  def update
    @resource.attributes = model_params
    @resource.save!
    respond_to do |f|
      f.any do
        render({
                 json: @resource,
                 serializer: each_sez,
                 status: :ok
               }.merge!(render_options))
      end
    end
  end

  def index
    query = cscope
    l = limit.to_i
    p = page.to_i
    o = order_by.to_sym
    s = sort.to_sym
    respond_to do |f|
      f.any do
        render({
                 json: query.order(o => s).page(p).per(l),
                 meta: {
                   total: query.count(:all),
                   page: p,
                   limit: l,
                   order_by: o,
                   sort: s
                 },
                 each_serializer: each_sez,
                 status: :ok
               }.merge!(render_options))
      end
    end
  end

  private

  def render_options
    {}
  end

  def each_sez
    "#{norm_controller_name}Serializer".constantize
  end

  def page
    params[:page] ||= 1
  end

  def limit
    params[:limit] ||= 20
  end

  def order_by
    return params[:order_by] if model.column_names.include?(params[:order_by])

    'id'
  end

  def sort
    params[:sort].in?(VALID_SORT) ? params[:sort] : VALID_SORT[0]
  end

  def norm_controller_name
    controller_path.classify
  end

  def model_name
    controller_name.classify
  end

  def model
    model_name.constantize
  end

  def cscope
    model
  end

  def attach_resource
    @resource ||= cscope.find(params[:id])
  end

  def api_version
    self.class.to_s.split('::').first.delete!('V')
  end
end
