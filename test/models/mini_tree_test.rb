require "test_helper"

class MiniTreeTest < ActiveSupport::TestCase
  let(:leaf) { a_leaf }

  def setup
    leaf.save # write to dabase
  end

  test "leaf" do
    assert_kind_of NameTree, leaf
    assert_match(/legend/, leaf.legend)
    assert_equal "leaf", leaf.kind
    assert_equal 0, leaf.parent_id
    assert_equal leaf.id, leaf.position
    refute leaf.collapsed
  end

  test "create_item" do
    assert_difference("NameTree.count") {
      NameTree.create_item(2, "Legend")
    }
  end

  test "destroy_item" do
    assert_difference("NameTree.count", -1) {
      NameTree.destroy_item(leaf.id)
    }
  end

  test "update_item" do
    new_legend = "New"
    refute_equal new_legend, NameTree.last.legend

    NameTree.update_item(leaf.id, new_legend)
    assert_equal new_legend, NameTree.last.legend
  end

  test "to_s" do
    assert_kind_of String, leaf.to_s
  end

  test "print" do
    legend = leaf.legend
    out, err = capture_io { NameTree.print }

    assert_empty err
    assert_match(/ NameTree.all /, out)
    assert_match(/#{legend}/, out)
  end

  test "flat" do
    assert_equal [[1, 0]], NameTree.flat
  end
end
