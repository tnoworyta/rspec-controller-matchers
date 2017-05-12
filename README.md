```ruby   
   RSpec.configure do |config|
     config.expect_with :rspec do |c|
       c.include_chain_clauses_in_custom_matcher_descriptions = true
     end
   end
```

