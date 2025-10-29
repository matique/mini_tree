class MiniTreesController < ApplicationController
  def sync
    init_klasses(params[:owner])
    id = params[:id]
    value = params[:value]

    case params[:function]
    when "order"
      client_order = JSON.parse(params[:order])
      client_order.each_with_index do |pair, index|
        id, parent_id = pair
        row = @tree.find(id.to_i)
        row.update!(position: index, parent_id: parent_id.to_i)
      end
    when "leaf2node"
      row = @tree.find_by(id: value.to_i)
      row.update! kind: "node"
    when "node2leaf"
      row = @tree.find_by(id: value.to_i)
      row.update! kind: "leaf"
    when "toggle"
      id = id.to_i
      row = @tree.find_by(id:)
      row.update! collapsed: value
    else
      raise "MiniTreeView: unknown function <#{params}>"
    end
    # head :ok
    render json: {status: "ok"}
  rescue RuntimeError => e
    # head :bad_request
    render json: {status: "error", message: e.message}, status: :unprocessable_entity
  end

  private

  def init_klasses(name)
    @tree = Kernel.const_get("#{name}Tree")
  end
end
