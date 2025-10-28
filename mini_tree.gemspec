require_relative "lib/mini_tree/version"

Gem::Specification.new do |s|
  s.name = "mini_tree"
  s.version = MiniTree::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "MiniTree a simple TreeView Rails 8+ gem."
  s.description = <<-EOS
    A simple TreeView Rails 8+ gem based on Stimulus
    (no jQuery is required).
    A server side handling of the tree is included.
    The client side display of the usual legend can be
    adapted to the user's requirements to include links.
  EOS
  s.authors = ["Dittmar Krall"]
  s.email = ["dittmar.krall@gmail.com"]
  s.homepage = "https://github.com/matique/mini_tree"
  s.license = "MIT"

  s.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "README.md"]
  end
  s.extra_rdoc_files = Dir["README.md", "MIT-LICENSE"]

  s.require_paths = ["lib"]
  s.required_ruby_version = "~> 3"

  s.add_dependency "rails", ">= 8.0.1"
  s.add_dependency "stimulus-rails"
  s.add_development_dependency "combustion"
  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-spec-rails"
end
