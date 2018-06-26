# Table XI Dev Generators

A recommended set of generators for Table XI projects.

## Example usage

Install everything:

```bash
bundle exec rails g tablexi_dev:all
```

Or install only the ones you want:

```bash
bundle exec rails g tablexi_dev:git_hook
bundle exec rails g tablexi_dev:rubocop
bundle exec rails g tablexi_dev:unicorn
# ...
```

## Installing this gem

Add this line to your application's Gemfile:

```ruby
group :development do
  gem "tablexi_dev-generators"
end
```

And then execute:
```bash
$ bundle
```

## Upgrading this gem

After upgrading this gem, it's recommended that you re-run the generators and verify that the changed files are correct.

## All available generators

### Generator: Git hooks

    bundle exec rails g tablexi_dev:git_hook

This generator will guide you through installing git hooks. If you do not have a strong preference, we recommend installing the `pre-push` rubocop hook.

Because git hooks do not get checked into the remote repository, it's recommended that each team member run this generator upon installing any project on their local machine.

### Generator: Rubocop

    bundle exec rails g tablexi_dev:rubocop

The rubocop generator is designed to be used in the following different situations:

1) On initial setup of rubocop in a project, to set up the tool.
2) When updates to the rubocop cops occur (new versions of [Rubocop](https://github.com/bbatsov/rubocop/) are provided, with new rules)

For detailed instructions on the rubocop generator and its options, [check out the rubocop readme](rubocop.md)

### Generator: Unicorn

    bundle exec rails g tablexi_dev:rubocop

The unicorn generator sets up a project's unicorn configuration files.


## Publishing this gem

1. Bump the version in `lib/tablexi_dev/generators/version.rb` according to [semver](https://semver.org/)
2. Commit `lib/tablexi_dev/generators/version.rb` to master and push
3. [Draft a github release](https://github.com/tablexi/tablexi_dev-generators/releases) with new vesion number and add a description that follows the convention of the existing releases
4. Publish the release
5. Checkout `master` and pull the latest
6. Run `gem build tablexi_dev-generators`
7. Run `gem push tablexi_dev-generators-<version>.gem` with file that was generated from the previous step
