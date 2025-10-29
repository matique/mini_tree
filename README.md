# UNDER CONSTRUCTION

# MiniTree

[![Gem Version](https://img.shields.io/gem/v/mini_tree?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/mini_tree)
[![Downloads](https://img.shields.io/gem/dt/mini_tree?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/mini_tree)
[![GitHub Build](https://img.shields.io/github/actions/workflow/status/matique/mini_tree/rake.yml?logo=github)](https://github.com/matique/mini_tree/actions/workflows/rake.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-168AFE.svg)](https://github.com/standardrb/standard)
[![MIT License](https://img.shields.io/badge/license-MIT-168AFE.svg)](http://choosealicense.com/licenses/mit/)

_MiniTree_ is a Rails gem to display and handle a treeview.
It supports moving/reordering items in the treeview,
collapsing/expanding of a subtree
and creating/deleting them.

Items in the treeview can be enhanced with links
to trigger actions.

_MiniTree_ requires just a basic Rails system.
Specifically, besides Stimulus no other Javascript package
(i.e jQuery) is expected.
Configuration is absent.

_MiniTree_ includes a javascript component to handle
the view on the client side
as well as code for the server side.


## Prerequisites

Some preparation for the usage is required:
- an additional database table storing the tree structure
- a _legend_ method in the model
- a call to _MiniTree_ to initialize the tree structure
- calls in the model to _miniTree_ during creation, update
  and deletion of an item

~~~Ruby
# ./app/models/<model>.rb
class <model> < ApplicationRecord
  def legend = "#{name} #{id}"   # an example
end

# ./app/models/<model>_tree.rb
class <model>Tree < ApplicationRecord
  include MiniTree::Utils
end

# ./db/migrate/<nnn>_create_<model>_trees.rb
class Create<Model>Trees < ActiveRecord::Migration[8.0]
  def change
    create_table :<model>_trees do |t|
      t.string :legend
      t.integer :parent_id, index: true
      t.integer :position, null: false, default: 0
      t.boolean :collapsed, default: false
      t.string :kind

      t.timestamps
    end
    # add_foreign_key :items, :items, column: :parent_id
  end
end
~~~

You may specify your view of an item in the treeview:
~~~Ruby
# ./app/views/mini_trees/_mini_tree_title.html.erb
# id and legend are defined
<%= link_to "action", edit_<model>(id:), class: 'button' %>
<%= legend %>
~~~

## Refresh

~~~Ruby
<Model>Tree.refresh
<Model>Tree.refresh_item(<id>, <legend>)
<Model>Tree.create_item(<id>, <legend>)
<Model>Tree.del_item(<id>)
~~~

## Usage

~~~Ruby
# Examp√le
<% list = <Model>Tree.all %>
<%= render "mini_trees/index", locals: {list:} %>
~~~


## Installation

As usual:

~~~~ruby
# Gemfile
...
gem "mini_tree"
...
~~~~

and run "bundle install".

Furthermore, copy manually *app/javascript/controllers/tree_controller.js*
from the _gem  mini-tree_
into your own _app/javascript/controllers/_ directory.


## System dependencies

This software has been developed and tested with:
- Ubuntu 24.04
- Ruby 3.4.7
- Rails 8.1.0

See also:
- ./.github/workflows/rake.yml

No particular system dependency is known,
i.e. _mini_tree_ is expected to run on other systems without trouble.


## Curious

There are quite a lot of TreeViews available.
If you are curious you may search in particular for:
- jqTree
- sortableJS


## License

Copyright (c) 2025 Dittmar Krall (www.matiq.com),
released as open source under the terms of the
[MIT license](https://opensource.org/licenses/MIT).




* Database initialization


Short description and motivation.

## Usage
How to use my plugin.
