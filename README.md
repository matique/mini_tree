# MiniTree
Short description and motivation.

## Usage
How to use my plugin.

...
## Contributing
Contribution directions go here.

# README

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# MiniTree

[![Gem Version](https://img.shields.io/gem/v/mini_tree?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/mini_tree)
[![Downloads](https://img.shields.io/gem/dt/mini_tree?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/mini_tree)
[![GitHub Build](https://img.shields.io/github/actions/workflow/status/matique/mini_tree/rake.yml?logo=github)](https://github.com/matique/mini_tree/actions/workflows/rake.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-168AFE.svg)](https://github.com/standardrb/standard)
[![MIT License](https://img.shields.io/badge/license-MIT-168AFE.svg)](http://choosealicense.com/licenses/mit/)

_MiniTree_ is a Rails gem to handle a treeview.
Minimal modifications to the actual code are required to display a treeview.

_MiniTree_ includes a javascript component to handle the view
as well as code for the server side.

You may add links to the legend in the TreeView.

Some preparation for the usage is required:
- an additional database table storing the tree structure
- a _legend_ method in the model
- a call to _MiniTree_ to initialize the tree structure
- calls in the model to _miniTree_ for creation and deletiom
-

## Further Reading
- jqTree
- sortableJS

## Prerequisites

- gem Stimulus (no jQuery is required)



A simple and efficient "configuration" gem for Ruby
(can be used in Rails as well).
Options can be initialized as required and later be accessed.

A global *Confi* (the usual usage)
as well as an instance (not recommended) configuration
are supported.

## Usage


/ yours in ./app/views/mini_trees/_mini_tree_title.html.erb
gem stimulus
Name#legend


## Usage (global Confi)

~~~~ruby
require "confi"
...
Confi.debug = true
...
if Confi.debug
  ...
end
...
~~~~


## Configure (initialization)

~~~~ruby
Confi.configure(hash)
~~~~

~~~~ruby
Confi.configure do |s|
  s.option = :active
  s.name = "name"
end
~~~~


## Usage (in instances)

~~~~ruby
require "confi"

class User # a sample
  include Confi
end
...
# create instance
user = User.new

# Functionality same as with Confi; use instance name
user.debug = false
...
~~~~

~~~~ruby
...
# Not yet initialized attribute
if Confi.debug  # NoMethodError: undefined method 'debug'
  ...
end
...
~~~~


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

No particular system dependency is known,
i.e. *mini_tree* should run on other systems as well.

## License

Copyright (c) 2025 Dittmar Krall (www.matiq.com),
released as open source under the terms of the
[MIT license](https://opensource.org/licenses/MIT).




# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
