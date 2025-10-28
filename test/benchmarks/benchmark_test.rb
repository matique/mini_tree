require "test_helper"
require "benchmark"
require "benchmark/ips"

# ENV["MORE"] = "true"

describe "prepare & refresh" do
  test "prepare" do
    assert true # avoid missing assertions
    return unless ENV["MORE"]

    def prepare(n)
      Name.delete_all
      (1..n).each { |id|
        Name.create! id:, name: "name_#{id}"
      }
    end

    def refresh(n)
      prepare(n)
      NameTree.refresh
    end

    Benchmark.ips do |x|
      [10, 100, 1000].each { |n|
        x.report("prepare #{n} : ") { prepare(n) }
        x.report("refresh #{n} : ") { refresh(n) }
      }

      x.compare!
    end
  end
end
