# Rubocop Generator

## Purpose

The rubocop generator is designed to be used in the following different situations:

1) On initial setup of rubocop in a project, to set up the tool.
2) When updates to the rubocop cops occur (new versions of [Rubocop](https://github.com/bbatsov/rubocop/) are provided, with new rules)
3) When setting up a new developer environment, to help them run rubocop as part of their development workflow

### Situation: Initial Project Setup

The rubocop generator sets up a project for rubocop by doing the following actions:

- Install `.rubocop.yml` file - the base config file when `rubocop` runs
- Install `.rubocop-txi.yml` file - the TableXI agreed-upon standard for ruby syntax
- Install `.rubocop_todo.yml` file - For short-term project variations from the rubocop/txi standard
- Install `.rubocop-project_overrides.yml` file - For long-term project decisions

#### Usage with Github PR

Each project is expected to run rubocop as part of their PR process.

There are 2 supported paths to do this:
- run rubocop in CircleCI
- run rubocop as part of CodeClimate

##### Option 1) Run rubocop as part of Circle CI

If you want to run rubocop as part of the CircleCI execution, you should add rubocop to your circle.yml file.

On Circle CI 1.0, the following is recommended.

```
test:
  post:
    - bundle exec rubocop --config .rubocop.yml

```

On Circle CI 2.0, the following is recommended:

```
# Add this immediately after your `rspec` command
- run: bundle exec rubocop --config .rubocop.yml
```

##### Option 2) Run rubocop as part of CodeClimate

If you are using CodeClimate code analysis on your project, you can choose to let CodeClimate run your rubocop when doing the analysis.

Benefits of using this approach:

- The code analysis and rspec execution are done in parallel, or separate systems, and thus can be complete faster

Downsides of using this approach:

- When the version of rubocop is updated, CodeClimate analysis will use the latest version automatically, no matter what version of rubocop is specified by your project.
- Sometimes new versions of rubocop are available well in advance of CodeClimate supporting that version, making it impossible for your project to update the version of rubocop until CodeClimate catches up.

In order to deal with the rubocop-version issue, we recommend [specifying the version of rubocop on CodeClimate](https://docs.codeclimate.com/v1.0/docs/rubocop#section-using-rubocop-s-newer-versions).

Create a .codeclimate.yml file with the following:

```yml
engines:
  rubocop:
    enabled: true
```

#### Update your README

The following is recommended to be added to your README, so that new developers get the benefits of the pre-commit hooks for rubocop:

## Development Setup

CircleCI runs rubocop as part of the CI process, and thus it is recommended that you run rubocop as a git hook as part of your git workflow.

Follow the [New Development Environment](#situation-setting-up-a-new-development-environment) instructions to set up automatic rubocop execution.

### Situation: Update rubocop rules

When a new version of rubocop is released, sometimes TableXI decides some of the new cops are not desired on our projects, or existing cops need to be adjusted, and so we update the .rubocop-txi.yml.

running `rails g tablexi_dev:rubocop` will replace the existing `.rubocop-txi.yml` with the latest version.

#### Expected steps:

- Run `bundle update rubocop` in order to install the latest rubocop
- Run `rubocop` in order to see what cops are currently in violation
- [optional] Run `rubocop -a` to perform auto-correct of any cops which can be auto-corrected
- [optional] Manually correct any remaining violations
- Choose not to fix some cops:
  - [optional] add `# rubocop:disable CopModule/CopName` to any lines whose cops you disagree with
  - [optional]
  - Run `rubocop --auto-gen-config` in order to have rubocop analyze your project, and create a `.rubocop_todo.yml` for any deviations
- Inspect the `.rubocop_todo.yml` contents, and address them, or move them into the `.rubocop-project_overrides.yml` if they are going to become permanent project-specific deviations from the standard.

### Situation: Setting up a new development environment

Each project is expected to run rubocop as part of the PR process, and thus it is highly encouraged that each developer put in place a process to run `rubocop` before they push the changes to github (ie: before triggering the CI build).

#### Development Editor Linters

Most Editors have the ability to automatically run rubocop, and display warnings inline in your editor. This helps you to see the warnings as you change code, so that you can fix them as you write them.

- [SublimeText](https://www.sublimetext.com/) has support for this through the [SublimeLinter-rubocop](https://github.com/SublimeLinter/SublimeLinter-rubocop) linter.
- [Atom](https://atom.io/) has support for this through the [linter-rubocop](https://atom.io/packages/linter-rubocop) linter, which depends on [this linter](https://github.com/steelbrain/linter).

#### Git Hooks

To run rubocop before pushing to CI, we recommend installing a git pre-commit or pre-push hook into your git project. These are available through the `tablexi_dev-generators` gem.

Note: git hooks cannot be easily committed to the repository, and so they must be installed on each developer's machine manually. This also gives each developer the flexibility to choose the workflow that works best for them.

To install a git hook on your development environment, run:

`bundle exec rails g tablexi_dev:rubocop`

and follow the prompts to install the hooks that you desire.

##### Option 1: git pre-commit hook

Running rubocop in a pre-commit hook provides the following benefits:

- It only runs rubocop against files that you have changed
- It runs rubocop each time you commit, and thus fewer lines of code change have occurred.

It has the following downsides:

- It introduces some delay to `git commit` step, as it has to run
- It may introduce changes to your code unexpectedly, since it auto-corrects the changed files if it can, before doing the `git commit`.

##### Option 2: git pre-push hook

Running rubocop in a pre-push hook provides the following benefits:

- It runs only directly before you are pushing to github
- It runs rubocop against the whole repository, ensuring that the whole repo will pass the rules.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
