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

The rubocop generator sets up a project for rubocop by doing the following actions:

- Install `.rubocop.yml` file - the base config file when `rubocop` runs
- Install `.rubocop-txi.yml` file - the TableXI agreed-upon standard for ruby syntax
- Install `.rubocop_todo.yml` file - For short-term project variations from the rubocop/txi standard
- Install `.rubocop-project_overrides.yml` file - For long-term project decisions
- Install a git pre-commit hook which will run rubocop before each `git commit`

In order to use the rubocop tools, the following workflow is expected.

- Run `rails g tablexi_dev:rubocop`
  - If this is the first time running on this project, or on this developer's machine, agree to all prompts
  - If this is a subsequent run, it will skip updating the `.rubocop_todo.yml` and `.rubocop-project_overrides.yml` as it is assumed that these files will diverge from blank.
- Run `bundle` in order to install rubocop
- Run `bundle update rubocop` in order to install the latest rubocop
- Run `rubocop --auto-gen-config` in order to have rubocop analyze your project, and create a `.rubocop_todo.yml` for any deviations
- Inspect the `.rubocop_todo.yml` contents, and address them, or move them into the `.rubocop-project_overrides.yml` if they are going to become permanent project-specific deviations from the standard.

#### Unicorn

The unicorn generator sets up a project's unicorn configuration files.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "tablexi_dev-generators", git: "git@github.com:tablexi/tablexi_dev-generators.git"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install tablexi_dev-generators
```

## Update your README

The following is recommended to be added to your README, so that new developers get the benefits of the pre-commit hooks for rubocop:

```
## Development Setup

CircleCI runs rubocop as part of the CI process, and thus it is recommended that you run rubocop as part of your git pre-commit hooks.

To do so, we recommend installing a git pre-commit into your git project. One is available through the `tablexi_dev-generators` gem.

To install this pre-commit hook on your development environment, run:

`bundle exec rails g tablexi_dev:rubocop`

```

## Usage with CircleCI

Note: when using Circle CI, if you want to check out the private `tablexi_dev-generators` git repo, you will have to authorize a User Key.

Instead of providing a private user key, we recommend refraining from gem-installing the `development` group as follows.

CircleCI 1.0:

```
database:
  pre:
    - bundle config without development
```

CircleCI 2.0:

```
version: 2
jobs:
  build:

    ...

    steps:

      ...

      - run: bundle install --without=development --path vendor/bundle
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
