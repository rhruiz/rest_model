$:.push 'examples'; require 'helper'

class Customer < RestModel
  property :login
  property :document, type: String
end

class Developer < Customer
  property :root_access, type: Boolean
  property :document, type: Integer
end

input = {login: 'jackiechan2010', root_access: true, document: '1234'}

@parent = Customer.from_source!(input).first
@root = Developer.from_source!(input).first

inspect_rest_model(@parent)
inspect_rest_model(@root)
