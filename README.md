# Felix Fixture JR
---
Generating Rails fixtures can be a real pain for developers, especially in legacy projects. What if you could just create everything you needed in a local environment, and then generate all the fixtures you need with a simple command.  Instead of just treating your fixtures as a group of files, you treat them as a type of active record model. So your fixtures have access to all of your active record relationships and query capabilities. 

## Installation
You can run:
```
gem install "felix_fixture_jr"
```
or add this to your Gemfile
```
group :test, :development do
  gem "felix_fixture_jr"
end
```

## Usage
---
You define what your fixtures should behave like, just like you would an active record model. There are a number of different options that will change your behavior to help you define your fixtures behavior.
The most basic setup looks like so.

```ruby
class UserFixture < User
  include FelixFixtureJr::Definition
end
```

This will create fixtures with the following format.

```yaml
user_1:
  first_name: Steve
  last_name: Scuba
  email: scuba_steve@gmail.com
  password: AKIXIN!()#*!<JBIS
  created_at: 202010191716120
  updated_at: 
```

## Contributing
Take a look at the the issues before jumping in. 

## Testing
Felix Fixture Jr uses RSpec for its shared contexts. We use the appraisal gem to test against different rails versions. To run the specs with a specific rails version use the appriasal command. 

```
# for Rails 4.2
bundle exec appraisal rails-4-2 rspec

# for Rails 5.0
bundle exec appraisal rails-5-0 rspec

# for Rails 5.1
bundle exec appraisal rails-5-1 rspec

# for Rails 5.2
bundle exec appraisal rails-5-2 rspec

# for Rails 6.0
bundle exec appraisal rails-6-0 rspec
```

## Roadmap
---

### Version 0.0.1
* Fixtures are generated based off of their table name and index
* Module inclusion lets define new fixtures
* Configuration around fixture folder location
* Ability to block attributes on individual fixtures
