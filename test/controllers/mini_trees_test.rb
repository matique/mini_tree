require "test_helper"

class MiniTreesControllerTest < ActionController::TestCase
  def setup
    @owner = "Name"
    @leaf = a_leaf
    @node = a_node
    @leaf.update! parent_id: @node.id
  end

  test "init" do
    assert_kind_of NameTree, @leaf
    assert_kind_of NameTree, @node
  end

  test "leaf2node" do
    leaf = a_leaf
    assert_equal "leaf", leaf.kind
    post :sync,
      params: {owner: @owner, function: "leaf2node", value: leaf.id},
      session: {}
    assert_equal "node", leaf.reload.kind
    assert true
  end

  test "node2leaf" do
    node = a_node
    assert_equal "node", node.kind
    post :sync,
      params: {owner: @owner, function: "node2leaf", value: node.id},
      session: {}
    assert_equal "leaf", node.reload.kind
    assert true
  end

  test "collapsed" do
    leaf = a_leaf
    refute leaf.collapsed

    patch :sync,
      params: {owner: @owner, function: "toggle", id: leaf.id, value: true},
      session: {}
    assert leaf.reload.collapsed

    patch :sync,
      params: {owner: @owner, function: "toggle", id: leaf.id, value: false},
      session: {}
    refute leaf.reload.collapsed
  end
end
