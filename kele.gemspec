Gem::Specification.new do |s|
   s.name          = 'kele'
   s.version       = '0.0.1'
   s.date          = '2017-05-17'
   s.summary       = 'Kele API Client'
   s.description   = 'A client for the Contacts API'
   s.authors       = ['Doug Major']
   s.email         = 'doug.major@gmail.com'
   s.files         = ['lib/kele.rb']
   s.require_paths = ["lib"]
   s.homepage      =
   'http://rubygems.org/gems/kele'
   s.license       = 'MIT'
   s.add_runtime_dependency 'httparty', '~> 0.13'
end