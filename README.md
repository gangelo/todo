# `todo`

[![Ruby](https://github.com/gangelo/todo/actions/workflows/ruby.yml/badge.svg)](https://github.com/gangelo/todo/actions/workflows/ruby.yml)
[![GitHub version](http://badge.fury.io/gh/gangelo%2Ftodo.svg?refresh=15)](https://badge.fury.io/gh/gangelo%2Ftodo)
[![Gem Version](https://badge.fury.io/rb/todo.svg?refresh=15)](https://badge.fury.io/rb/todo)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/gems/todo/)
[![Report Issues](https://img.shields.io/badge/report-issues-red.svg)](https://github.com/gangelo/todo/issues)
[![License](http://img.shields.io/badge/license-MIT-yellowgreen.svg)](#license)

`todo` is a [ruby gem](https://rubygems.org/gems/todo) that enables anyone practicing the [Agile methodology](https://www.agilealliance.org/agile101/) to record, keep track of and manage their [daily standup (TODO)](https://www.agilealliance.org/glossary/daily-meeting/) activities.

- `todo` uses _no_ network connections whatsoever.
- `todo` stores all of its data _locally_, in .json files.
- `todo` is a simple (but powerful) command-line tool for users who _love_ to work within the terminal.
- `todo` versioning follows the [semantic versioning standard](https://semver.org/) (MAJOR.MINOR.PATCH).
  - See the [CHANGELOG.md](https://github.com/gangelo/todo/blob/main/CHANGELOG.md) before upgrading to a MAJOR `todo` version.
  - See the [Exporting TODO entries](https://github.com/gangelo/todo/wiki/Exporting-TODO-entries) wiki on how to export (backup) your data.

# Installation
```shell
gem install todo
```

# Documentation
The [todo wiki](https://github.com/gangelo/todo/wiki) is currently the gold standard for `todo` documentation.

# Examples
* The [todo wiki](https://github.com/gangelo/todo/wiki) is repleat with practical examples on how to use `todo`.
* Visit the [How I use todo daily as an Agile developer](https://github.com/gangelo/todo/wiki/How-I-use-todo-daily-as-an-Agile-developer) wiki for examples of how _I_ use `todo` on a daily basis.

# Supported ruby versions
`todo` _should_ work with any ruby version `['>= 3.0.7', '< 4.0']`; however, `todo` is currently tested against the ubuntu-latest, macos-latest and windows-latest platforms, using the following ruby versions:
- 3.0.7
- 3.1
- 3.2
- 3.3

Copyright (c) 2023-2024 Gene Angelo. See [LICENSE](https://github.com/gangelo/todo/blob/main/LICENSE.txt) for details.
