# TablexiDev::Generators

Set of generators for Table XI projects.

## Usage

Install everything:

```bash
rails g tablexi_dev:all
```

Install just the ones you want:

```bash
bin/rails g tablexi_dev:rubocop
bin/rails g tablexi_dev:unicorn
```

### The Generators

#### Rubocop

The rubocop generator is designed to be used in the following different situations:

1) On initial setup of rubocop in a project, to set up the tool.
2) When updates to the rubocop cops occur (new versions of [Rubocop](https://github.com/bbatsov/rubocop/) are provided, with new rules)
3) When setting up a new developer environment, to help them run rubocop as part of their development workflow

For detailed instructions on the rubocop generator and its options, [check out the rubocop readme](rubocop.md)

#### Unicorn

The unicorn generator sets up a project's unicorn configuration files.

## Installation
Add this line to your application's Gemfile:

```ruby
group :development do
  gem "tablexi_dev-generators", git: "git@github.com:tablexi/tablexi_dev-generators.git"
end
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install tablexi_dev-generators
```

## Circle CI issue with Private repository

Note: when using Circle CI, if you want to check out the private `tablexi_dev-generators` git repo, you will have to authorize a User Key.

Instead of providing a private user key, we recommend refraining from gem-installing the `development` group as follows.

### CircleCI 1.0 - configure the system bundle config:

```
dependencies:
  pre:
    - gem install bundler # newer versions of bundler handle 'without' better
    - bundle config without development
```

### CircleCI 2.0 - adjust the `bundle install` command:

```
version: 2
jobs:
  build:

    ...

    steps:

      ...

      - run: bundle install --without=development --path vendor/bundle
```
