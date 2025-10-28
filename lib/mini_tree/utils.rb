module MiniTree::Utils
  def self.included(base)
    base.extend(ClassMethods)
  end

  def children
    self.class.where(parent_id: id).order(:position)
  end

  def to_s
    "position <#{position}> parent_id <#{parent_id}> #{kind} \"#{legend}\""
  end

  module ClassMethods
    def refresh
      missing_cnt = delete_cnt = refresh_cnt = 0
      owner_class = Kernel.const_get(name[0..-5])
      owner_ids = owner_class.all.pluck(:id)
      ids = all.pluck(:id)

      (owner_ids - ids).each { |id|
        legend = owner_class.find_by(id:).legend
        create_item(id, legend)
        missing_cnt += 1
      }
      (ids - owner_ids).each { |id|
        del_item(id)
        delete_cnt += 1
      }
      (owner_ids & ids).each { |id|
        refresh_item(id, owner_class.find_by(id:).legend)
        refresh_cnt += 1
      }
      [missing_cnt, delete_cnt, refresh_cnt]
    end

    def refresh_item(id, legend)
      find_by(id:).update!(legend:)
    end

    def create_item(id, legend)
      create! id:, legend:, parent_id: 0, position: id, kind: "leaf"
    end

    def del_item(id)
      where(id:).delete_all
    end

    # used by tests
    def flat
      res = []
      sorted.each { |item|
        res << [item.id, item.parent_id]
      }
      res
    end

    def print
      puts "*** #{name}.all ***"
      sorted.each_with_index { |item, index|
        puts "#{index}: #{item}"
      }
    end

    def sorted
      all.order(:position)
    end
  end
end
