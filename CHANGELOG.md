# Changelog

All notable changes to this project will be documented in this file.

## [3.0.3] - 2024-08-03

### Changes
[x] Update ruby gems.
[x] Update rexml gem to patch CVE.

## [3.0.2] - 2024-05-18

### Changes
[x] Update ruby gems.
[x] Update GitHub Actions to include testing against ruby versions '3.0.7', '3.1', '3.2' and '3.3' on ubuntu-latest, macos-latest and windows-latest.

## [3.0.1] - 2024-02-19

### Changes
[x] Update ruby gems.
[x] Update Gemfile to include gem groups for development and testing.
[x] Update .gemspec file post_install_message to include wiki link for new todo project command.

## [3.0.0] - 2024-02-17

### Enhancements
[x] Added `todo project` command to manage TODO projects. See `todo help project` or the [todo wiki](https://github.com/gangelo/todo/wiki) for more information.
[x] The `todo add` command how allows you to add entries using mnemonics and relative date mnemonics (RDMs) in addition to absolute dates. For example, `todo add -d -7 "My entry"` will add an entry one week in the past from the current day. See `todo help add` for more information.

### Changes
[x] Update ruby gems.
[x] Major updates to the migration process.
[x] `todo import` now has the --override true|false (default: false) OPTION. If true, the import process will ignore the project name found in the import file and import the entries into the current project. If false, the import process will use the project name found in the import file.
[x] Change `todo export` file name for exports. When exporting all TODO entry groups for a project, the file name will be:

"todo-export-<transformed project name>-<timestamp>-all-entry-groups-<from date>-thru-<to date>.csv"

When exporting TODO entry groups for a project between two given dates, the file name will be:

"todo-export-<transformed project name>-<timestamp>-entry-groups-<from date>-thru-<to date>.csv"

- Where <transformed project name> = is the project name transformed to a format appropriate to be part of a file name.
- Where <timestamp> = is the current timestamp in the format: YYYYMMDDHHMMSS
- Where <from date> = is the from date in the format: YYYY-MM-DD
- Where <to date> = is the to date in the format: YYYY-MM-DD

When exporting all TODO entry groups for a project, the <from date> and <to date> will represent the earliest and most recent entry group dates for the project, respectfully. For example:

```
# Where current date is 2024-01-29, and the earliest entry group date is 2023-08-11 and the most recent entry group date is 2024-01-27.
$ todo x a
```

todo-export-default-20240129130013-all-entry-groups-2023-08-11-thru-2024-01-27.csv

When exporting TODO entry groups between a to and from date for a project, the <from date> and <to date> will represent the from and to dates entered by the user on the command line, respectfully. For example:

```
# Where current date is 2024-01-29, and the from date entered on the command line is2023-08-11 and the from date entered on the command line is 2024-01-27.
todo x dd -f n -t -257
```

todo-export-default-20240129125946-entry-groups-2023-05-17-thru-2024-01-29.csv

### Bug Fixes
[x] Fix bug that did not gracefully handle invalid DATEs for the `todo add --date DATE` command.


## [2.4.4] - 2024-01-28
### Changes
[x] Update ruby gems.

## [2.4.3] - 2024-01-07
### Changes
[x] Code refactors, nothing discernable to the end user.

### Bug Fixes
[x] Fixed bug displaying incorrect editor if the editor session fails to open.

## [2.4.2] - 2024-01-06
### Changes
[x] Correct gemspec to allow ruby ['>= 3.0.1', '< 4.0'].

## [2.4.1] - 2024-01-05
### Changes
[x] Move gem version to footer.
[x] Update ruby gems.

## [2.4.0] - 2024-01-01
### Enhancements
[x] Add `todo import` command to import TODO entries from a comma-delimited csv file. See `todo help import` for more information.
[x] Update README.md to reflect new `todo import` command.

### Changes
[x] Update ruby gems.

## [2.3.2] 2023-12-30
### Changes
[x] Display a "Nothing to export" message if no entries are found, rather than prompting the user "export 0 entry groups" when using the `todo export` command.
[x] Add specs for Export::AllPresenter and Export::DatesPresenter

## [2.3.1] 2023-12-25
### Changes
[x] Update gemspec spec.post_install_message to reflect new `todo export` command.

## [2.3.0] 2023-12-25

### Enhancements
[x] Added `todo export` command to export all TODO entries or TODO entries between two given dates. Entries are written to a comma-delimited csv file located in your OS temp folder. For more information see `todo help export` or the README.md file.

### Changes
[x] Updated README.md to reflect new `todo export` command.
[x] Fix misspelling of "cancelable" to "cancellable" in the codebase.
[x] Update ruby gems.

## [2.2.2] 2023-12-23
### Changes
[x] README.md updates.

### Bug fix
[x] Fix `todo config` shortcut command mapping bug that caused `todo c` to display `todo delete` command help instead of `todo config` command help.

## [2.2.1] 2023-12-23
### Changes
[x] Add specs for `todo browse` command.
[x] Code refactors, nothing discernable to the end user.

## [2.2.0] 2023-12-23
Stable release.

## [2.2.0.rc.2] 2023-12-23
### Enhancements
[x] Added "christmas" theme, see `todo theme list` or `todo theme show christmas` for more information.

### Changes
[x] Refactors Todo::VERSION_REGEX to include rc releases (e.g. 2.2.0.rc.1, 2.2.0.rc.2, etc.).

## [2.2.0.rc.1] 2023-12-23
### Enhancements
[x] Added `todo browse` command to interactively page through TODO entries.
[x] Added "light" theme for terminals with light backgrounds, see `todo theme list` or `todo theme show light` for more information.

### Changes
[x] Refactors to use activesupport Time#in_time_zone, including tests.
[x] Various code refactors to support the aforementioned change.

## [2.1.4] 2023-12-19
### Changes
[x] Minor code refactors.

### Bug fixes
[x] Fix bug in relative date mnemonic (RDMs) regex matcher that incorrectly matched dates whose separater happened to be a "-" (e.g. 2023-12-31). The old regex (/[+-]\d+/) incorrectly interpreted this as an RDM. This bug would cause the `todo list dates` command (for example) to create erroneous, relative dates.

## [2.1.3] 2023-12-17
### Bug fixes
[x] Fix bug that did not recognize the `include_all` configuration option when using the `todo list dates` command. The `include_all` configuration option is now recognized and used properly when using the `todo list dates` command. See `todo help list dates` for more information.

## [2.1.2] 2023-12-17
### Changes
[x] WIP, continued I18n integration. See [2.1.0] for more information.
[x] Removed shortcut mappings for all commands (see `todo help`) to remove dash ("-") preceeding command shortcuts. For example, `todo -a` (i.e. shortcut for `todo add`) is now `todo a`, `todo -c` (i.e. shortcut for `todo config`) is now `todo c`, etc. This was done to avoid confusion as this format is typically used for options, not shortcut commands. The only exception is `todo version` which will accept shortcuts `todo v` and `todo -v`, as `-v` is generally used to display version information.
[x] Various code refactors.
[x] Massive updates to README.md.

### Bug fixes
[x] Fix bug that did not apply the current theme to `todo help add` help.

## [2.1.1] 2023-12-17
### Bug fixes
[x] Fix bug that did not included I18n locale files in yanked version 2.1.0.

## [2.1.0] 2023-12-16
### Enhancements
[x] Added `todo delete` command to incorporate color themes. See `todo help delete` for more information.

### Bug fixes
[x] Fix bug that failed to show "(nothing to display for <day>, <date> <local time designator> through <day>, <date> <local time designator>)" for `todo list dates` command when no entries existed for the entry groups associated with the given dates.

### Miscellaneous
[x] WIP, begin I18n support/integration.
[x] Update ruby gems.
[x] Updated README.md to reflect new `todo delete` command.
[x] Fix rubocop violations.

## [2.0.8] 2023-12-02
### Changes
[x] Update ruby gems.

## [2.0.7] 2023-11-24
### Changes
[x] Update ruby gems.
[x] Remove stale/unnecessary code.

## [2.0.6] 2023-10-30
### Changes
[x] Update ruby gems.

## [2.0.5] 2023-10-30
### Changes
[x] Update ruby gems.

## [2.0.4] 2023-08-28
### Changes
[x] Update ruby gems.

## [2.0.3] 2023-08-17
### Changes
[x] Bump activesupport from 7.0.5 to 7.0.7
[x] Bump simplecov from 0.21.2 to 0.22.0

## [2.0.2] 2023-08-17
### Changes
[x] Bumps activemodel from 7.0.5 to 7.0.7.
[x] Update colorize requirement from ~> 0.8.1 to >= 0.8.1, < 1.2.0
[x] Bump rubocop-rspec from 2.22.0 to 2.23.2
[x] Bump rubocop-performance from 1.18.0 to 1.19.0
[x] Bump rubocop from 1.52.0 to 1.56.0
[x] Fix rubocop violations

## [2.0.1] 2023-08-16
### Changes
[x] Bump to official release.
[x] None (see below).

## [2.0.0] 2023-08-16 (yanked)

## [2.0.0.alpha.1] 2023-08-16
### Changes
[x] Major refactors to the `todo` codebase.
[x] Added `todo theme` command to incorporate color themes. See `todo help theme` for more information.
[x] Added `todo info` command to display details about the current todo release. See `todo help info` for more information.
[x] Added "migrations", which is really a method of backup whereby user data is backed up to the todo folder under `backup/<migration version>`. Backups will occur whenever a breaking change is made to any of the todo models (ColorTheme, Configuration, EntryGroup or MigrationVersion). In this way, users can create their own scripts to migrate their associated model `.json`` files to the latest model version, and move them back into the appropriate todo folder structure so data can be retained.
[x] Changes to command help to be more uniform.

### Bug fixes
[x] Various bug fixes.

## [2.0.0.alpha.0] 2023-06-26 (yanked)

## [1.2.1] 2023-06-02
### Bug fixes

[x] Fixed a bug that raises an error `NoMethodError` for `entry_group_file_exists?` if the `carry_over_entries_to_today` configuration option is set to true, and attempting to edit today's todo entries.

## [1.2.0] 2023-05-26
### Changes
[x] Various refactors.
[x] Bring test coverage to >= 85%.

## [1.1.2] 2023-05-26
### Changes
[x] Various refactors.
[x] Add more test coverage.

## [1.1.1] 2023-05-23
See previous alpha releases for changes.

## [1.1.1.alpha.2] 2023-05-23
### Changes
[x] For convenience, the `todo list date` command now takes a MNEMONIC in addition to a DATE. See `todo list help date` for more information.

### Bug fixes
[x] Fix a bug that did not display `todo list dates SUBCOMMAND` date list properly when the `--from` option was a date mnemonic and the `--to` optoin was a relative time mnemonic (e.g. `todo list dates -f today -t +1`). In this case, TODO dates `Time.now` and `Time.now.tomorrow` should be displayed; instead, the bug would consider the `--to` option as relative to `Time.now`, so only 1 TODO date (`Time.now` would be returned).

## [1.1.0.alpha.1] 2023-05-23
### Changes

[x] Added new configuration option `carry_over_entries_to_today` (`true|false`, default: `false`); if true, when editing TODO entries **for the first time** on any given day (e.g. `todo edit today`), TODO entries from the previous day will be copied to the editing session. If there are no TODO entries from the previous day, `todo` will search backwards up to 7 days to find a TODO date that has entries to copy. If after searching back 7 days, no TODO entries are found, the editor session will simply start with no previous TODO entries.
[x] Added new configuration option `include_all` (`true|false`, default: `false`); if true, when using todo commands that list date ranges (e.g. `todo list dates`), the displayed list will include dates that have no todo entries. If false, the displayed list will only include dates that have todo entries. For all other `todo list` commands, if true, this option will behave in the aforementioned manner. If false, the displayed list will unconditionally display the first and last dates regardless of whether or not the TODO date has entries or not; all other dates will not be displayed if the TODO date has no entries.
[x] Changed the look of the editor template when editing entry group entries.

## [1.0.0] 2023-05-18
### First official release
[x] NOTE: If you have been using the alpha version of `todo`, you will need to delete the `entries` folder (e.g. `/Users/<whoami>/todo/entries` on a nix os) as the old entries .json files are incompatible with this official release.

### Changes from the alpha version
[x] When editing an entry group, editor commands are no longer necessary. Simply add, remove or change entries as needed. See the README.md for more information.
[x] When editing an entry group and saving the results, take note of the folowing behavior:
  - Entering duplicate entries are not allowed, only one entry with a given description is allowed per entry group.
  - Entering entries whose descriptions are < 2 or > 256 characters will fail validation and will not be saved.
  - When editing and encountering any of the aforementioned, the errors will be displayed to the console after the editor file is saved.
[x] Sha's are no longer being used, as I've not found a good use (currently) to use them. I may add them back in the future if I find a good use for them (tracking entries across entry groups, etc.).
[x] When adding an entry (`todo add OPTION`), it used to be that after the entry was added, the entry group for the date being edited would be displayed, as well as "yesterday's" date. This is no longer the case; now, only the entry group for the date being edited is displayed.

## [0.1.0.alpha.5] 2023-05-12
### Changes
[x] `todo edit SUBCOMMAND` will now allow editing of an entry group for a date that does not yet exist. This will allow you to add entries in the editor using `+|a|add DESCRIPTION`. Be sure to follow the instructions in the editor when editing entry group entries.
[x] `todo edit SUBCOMMAND` will gracefully display an error if the entry sha (Entry#uuid) or entry discription (Entry#description) are not unique. In this case, the entry will not be added to the entry group.
  NOTE: Not all edge cases are being handled currently by `todo edit SUBCOMMAND`.
[x] `todo add OPTION` will raise an error if the entry discription (Entry#description) are not unique. This will be handled gracefully in a future release.

## [0.1.0.alpha.4] 2023-05-09
### Changes
[x] Gemfile gemspec description changes.

## [0.1.0.alpha.3] 2023-05-09
### Changes
[x] Entry groups are now editable using the `todo edit SUBCOMMAND` command. See the README.md or `todo help edit` for more information.
[x] Added `editor` configuration option to specify the editor to use when editing an entry group. This configuration option is used if the $EDITOR environment variable is not set.

### Bug fixes
[x] Fix bug that failed to load default configuration values properly when provided (surfaced in specs).

## [0.1.0.alpha.2] 2023-05-08
ATTENTION: After installing this pre-release, run `todo config info` and take note of the `entries_folder` config option value (e.g. something like '/Users/<whoami>/todo/entries' on a nix os). You'll need to delete the entry group files therein ( \<YYYY\>\-\<MM\>\-\<DD\>.json e.g. 2023-05-07.json) to avoid errors when running this version of `todo`.

WIP (not fully implemented yet)

[x] Added `todo edit` command to edit an existing entry.

### Changes
[x] Remove Entry#long_description and make Entry#description longer (to 256 bytes max).
[x] Added `todo` short-cut commands|options `a|-a`, `c|-c`, `e|-e` and `l|-l` for `add`, `config`, `edit` and `list` commands respectively. For example, can now do `todo a` or `todo -a` instead of `todo add`.
[x] Added `todo list` short-cut subcommand|options `d|-d`, `n|-n`, `t|-t` and `y|-y` for `date DATE`, `today`, `tomorrow` and `yesterday` subcommands respectively. For example, can now do `todo n` or `todo -n` instead of `todo today` to list your TODO entries for "today".
[x] `todo list` commands now lists all TODO entries from the date being requested (SUBCOMMAND i.e. `today`, `tomorrow`, `yesterday` or `date`), back to and including the previous Friday IF the date being being requested falls on a Monday or weekend. This is so that the TODO entries for the weekend and previous Friday can be shared at TODO if you hold a TODO on the weekend (if you're insane enough to work and have TODO on the weekend) or on a Monday if you happened to work on the weekend as well.
[x] `todo config info` now displays the default configuration being used if no configuration file is being used.

### Bug fixes
[x] Fix bug that fails to load/use configuration file options when a config file exists.

## [0.1.0.alpha.1] 2023-05-06

Initial (alpha) release. See README.md for instructions.
