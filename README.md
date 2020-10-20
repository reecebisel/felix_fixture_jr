# Felix Fixture JR
---
Generating Rails fixtures can be a real pain for developers, especially in legacy projects. What if you could just create everything you needed in a local environment, and then generate all the fixtures you need with a simple command.  Instead of just treating your fixtures as a group of files, you treat them as a type of active record model. So your fixtures have access to all of your active record relationships and query capabilities. 

##Usage
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


## Roadmap

### Version 0.0.1
* Fixtures are generated based off of their table name and index
* Module inclusion lets define new fixtures
* Configuration around fixture folder location
* Ability to block attributes on individual fixtures
