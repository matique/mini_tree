require "test_helper"

# mainly testing refresh
class MiniTree2Test < ActiveSupport::TestCase
  let(:node) { a_node }
  let(:leaf) { a_leaf }

  test "the truth" do
    assert_kind_of NameTree, leaf
    assert_kind_of NameTree, node
  end

  test "refresh; owner empty => delete all" do
    Name.destroy_all
    assert_difference("NameTree.count", -NameTree.count) {
      NameTree.refresh
    }
  end

  test "refresh; tree empty => insert all" do
    Name.create name: "NAME"
    Name.create name: "NAME"
    NameTree.destroy_all

    assert_difference("NameTree.count", Name.count) {
      NameTree.refresh
    }
  end

  test "refresh; both same => refresh all" do
    Name.create name: "NAME"
    name = Name.create name: "NAME"
    NameTree.destroy_all
    assert_equal [2, 0, 0], NameTree.refresh # create NameTrees

    name.update! name: "NEW"
    assert_equal [0, 0, 2], NameTree.refresh
  end

  test "children" do
    assert node.children.empty?
    assert leaf.children.empty?
    leaf.update! parent_id: node.id
    refute node.children.empty?
    assert leaf.children.empty?
  end

  test "ancestors" do
    assert_equal [leaf.id], NameTree.ancestors(leaf.id)
    assert_equal [node.id], NameTree.ancestors(node.id)

    leaf2 = a_leaf node
    assert_equal [node.id, leaf2.id], NameTree.ancestors(leaf2.id)
  end
end
