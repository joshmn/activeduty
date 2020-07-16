# ActiveDuty

Service objects, based loosely on [Interactor](https://github.com/collectiveidea/interactor).

## Design 

Define the logic in `run` and call it with `call`:

## Basic usage 

```ruby
class AuthenticateUser < ActiveDuty::Base
  def initialize(email, password)
    @email, @password = email, password 
  end

  def run
    if user = User.authenticate(@email, @password)
      context.user = user 
    else
      fail!
    end
  end
end
```

Usage: 

```
service = AuthenticateUser.new("josh@example.com", password: "password")
service.call 
if service.success?
  # do something
else
  puts service.errors.inspect 
end 
```

## Advanced usage 

### init_with

A DSL for initializing.

#### Ordered arguments

```
class AuthenticateUser < ActiveDuty::Base 
  init_with :username, :password 
end 
```

Is the equivalent of:

```
class AuthenticateUser < ActiveDuty::Base 
  attr_reader :username, :password 
  def initialize(username, password)
    @username, @password = username, password 
  end 
end 
```

#### Keyword arguments 

```
class AuthenticateUser < ActiveDuty::Base 
  init_with uname: :username, pw: :password  
end 
```

Is the equivalent of:

```
class AuthenticateUser < ActiveDuty::Base 
  attr_reader :username, :password 
  def initialize(uname:, pw:)
    @username, @password = uname, pw 
  end 
end 
```

#### Defaults 

```
class AuthenticateUser < ActiveDuty::Base 
  init_with :username, [:password, nil] 
end 
```

Is the equivalent of:

```
class AuthenticateUser < ActiveDuty::Base 
  attr_reader :username, :password 
  def initialize(username, password = nil)
    @username, @password = username, password 
  end 
end 
```

#### Keyword arguments 

```
class AuthenticateUser < ActiveDuty::Base 
  init_with uname: [nil, :username], pw: ["good-password", :password]
end 
```

Is the equivalent of:

```
class AuthenticateUser < ActiveDuty::Base 
  attr_reader :username, :password 
  def initialize(uname: nil, pw: "good-password")
    @username, @password = uname, pw 
  end 
end 
```

### Callbacks 

Supports `after_initialize`, `before_call`, `after_call`. They use `ActiveModel::Callbacks` under the hood, so the API is familiar.

### Context 

An `OpenStruct` for a setting information during the runtime of your service object. Exposed via `context`.

### Errors 

Uses `ActiveModel::Errors` under the hood.

### Rollbacks 

If your call fails and you need to do some housekeeping, define a rollback:

```ruby 
class AuthenticateUser < ActiveDuty::Base
  def rollback 
    # do something 
  end
end
```

Or class-level: 

```ruby 
class AuthenticateUser < ActiveDuty::Base
  rollback do 
    # do something 
  end 
end
```

### Failing 

Need to fail? Call `fail!`
