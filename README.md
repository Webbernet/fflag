# Fflag
A simple feature flag Rails engine that allows you to change behaviour of production systems without a deploy.

## Installation

Add to your Rails gemfile and install

```
gem 'fflag', git: 'https://github.com/Webbernet/fflag', branch: 'master'
```

```shell
$ bundle install
```
Fflag uses a database table to track each flag. Install and run migrInstall and run migrations which will create a 'feature_flag_states' table in your project

```shell
$ bundle rake fflag_engine:install:migrations
$ bundle rake db:migrate
```

Create your definition file `app/src/fflag_definitions.yml` with

```yaml
permanent:
  - name: 'Send OB mail through redundancy'
    identifier: 'email_redundancy_system'
    description: 'If our primary email provider is experiencing issues, this will reroute all mail leaving our "Outbound Mail" system to be sent via our secondary email provider.'
  - name: 'Pause OB mail sending'
    identifier: 'disable_outbound_email_sending'
    description: 'This will prevent our system from sending the Queued emails in our Outbound Email system.'
temporary:
  - name: 'Feature X Release'
    identifier: 'feature_x_release'
    description: 'This will release feature X (#1234) to all users'
```


Mount the engine routes to your application so you can toggle your states. 
```ruby
Rails.application.routes.draw do
  mount Fflag::Engine => '/dev'
end
```
The primary page is `/toggles`, so after mounting the above you would find the page at `localhost:3000/dev/toggles`. By default you the basic password is `FEATUREFLAGBASIC`, however you can change this by setting the `FFLAG_PASSWORD` environment variable.

## Usage

Use the `FeatureFlag` class to detect if a toggle is switched on or not. Use the `identifier`  that you specified in the flag_definitions file to reference.

```ruby
if FeatureFlag.is_on? :disable_outbound_email_sending
  disable_sending!
end

if FeatureFlag.is_off? :email_redundancy_system
  send_with_primary_provider!
end
```

Switch feature flags on and off using the toggles page (see above)

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
