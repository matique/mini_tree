require "test_helper"

class MiniTreeTest < ActiveSupport::TestCase
  def setup
    @leaf = a_leaf
  end

  test "@leaf" do
    assert_kind_of NameTree, @leaf
    assert_match(/legend/, @leaf.legend)
    assert_equal "leaf", @leaf.kind
    assert_equal 0, @leaf.parent_id
    assert_equal @leaf.id, @leaf.position
    refute @leaf.collapsed
  end

  test "create_item" do
    NameTree.create_item(2, "Legend")

    assert_equal 2, NameTree.count
  end

  test "del_item" do
    NameTree.del_item(@leaf.id)
    assert_equal 0, NameTree.count
  end

  test "refresh_item" do
    new_legend = "New"
    refute_equal new_legend, NameTree.last.legend

    NameTree.refresh_item(@leaf.id, new_legend)
    assert_equal new_legend, NameTree.last.legend
  end

  test "to_s" do
    assert_kind_of String, @leaf.to_s
  end

  test "print" do
    out, err = capture_io { NameTree.print }
    assert_empty err
    assert_match(/ NameTree.all /, out)
    assert_match(/#{@name}/, out)
  end

  test "flat" do
    assert_equal [[1, 0]], NameTree.flat
  end
end
