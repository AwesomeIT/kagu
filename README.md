# kagu
[![CircleCI](https://circleci.com/gh/birdfeed/kagu.svg?style=shield)](https://circleci.com/gh/birdfeed/kagu)
[![Code Climate](https://codeclimate.com/github/AwesomeIT/kagu/badges/gpa.svg)](https://codeclimate.com/github/AwesomeIT/kagu)

ActiveRecord models and specs for the [turaco](https://github.com/birdfeed/turaco) API and [myna](https://github.com/birdfeed/myna) Kafka-backed workers.

## Overview

- `Kagu::Models` contains ActiveRecord models.
- `Kagu::Documents` contains ElasticSearch repository objects (TBD).

## Models

To mimic Rails behaviors, we alias the constants from `Kagu::Models` into `Object` to avoid fully qualifying the path to our model. This is the exact same 'magic' done by Rails on load by `ActiveSupport`. 

## Creating a Migration

- Run `rake db:new_migration name=foo_bar_migration` and then edit the created file with your database changes.
- Run `rake db:migrate` to apply the migration.
- If needed: create a model under `lib/kagu/models`
- If needed: create a spec under `spec/lib/models`
- If needed: update `models.rb`
- Update version number
- Merge changes

To retrieve the new changes, run `bundle update kagu` in turaco and myna.

## Testing

In order to avoid code replication, `FactoryGirl` factories are also included in this gem. Everything should work with any Ruby test framework as long as you `require kagu/factories` in your `spec_helper` or `test_helper` files. 
