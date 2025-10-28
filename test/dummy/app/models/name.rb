class Name < ApplicationRecord
  def legend = "#{name} #{id}"

  def self.column_headers
    %i[id name]
  end
end
