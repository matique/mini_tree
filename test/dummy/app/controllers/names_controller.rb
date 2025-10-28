class NamesController < RowsController
  def five
    Name.delete_all
    (1..5).each_with_index { |id, idx|
      Name.create! id:, name: "name_#{id}"
    }

    redirect_to root_url
  end

  private

  def resource_whitelist
    %i[name]
  end
end
