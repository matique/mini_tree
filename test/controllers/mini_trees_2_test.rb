require "test_helper"

describe MiniTreesController do
  def setup
    @owner = "Name"
  end

  test "should reorder" do
    leaf1 = a_leaf
    leaf2 = a_leaf
    goal = [[leaf2.id, 0], [leaf1.id, 0]]
    post :sync,
      params: {owner: @owner, function: :order, order: goal.to_json},
      session: {}
    assert_equal goal, NameTree.flat
  end

  test "move subtree" do
    node1 = a_node
    leaf2 = a_leaf node1
    leaf3 = a_leaf node1
    leaf4 = a_leaf
    leaf5 = a_leaf
    # NameTree.print
    goal = [
      [leaf4.id, 0], [node1.id, 0], [leaf2.id, node1.id],
      [leaf3.id, node1.id], [leaf5.id, 0]
    ]
    post :sync,
      params: {owner: @owner, function: :order, order: goal.to_json},
      session: {}
    # NameTree.print
    assert_equal goal, NameTree.flat
  end

  test "move leaf4 & subtree" do
    node1 = a_node
    leaf2 = a_leaf node1
    leaf3 = a_leaf node1
    leaf4 = a_leaf
    leaf5 = a_leaf
    # NameTree.print
    goal = [
      [leaf4.id, 0], [node1.id, 0], [leaf2.id, node1.id],
      [leaf3.id, node1.id], [leaf5.id, 0]
    ]
    post :sync, params: {owner: @owner, function: :order, order: goal.to_json}, session: {}
    # NameTree.print
    assert_equal goal, NameTree.flat

    goal = [
      [node1.id, 0], [leaf2.id, node1.id], [leaf3.id, node1.id],
      [leaf4.id, 0], [leaf5.id, 0]
    ]
    post :sync, params: {owner: @owner, function: :order, order: goal.to_json}, session: {}
    # NameTree.print
    assert_equal goal, NameTree.flat
  end
end
