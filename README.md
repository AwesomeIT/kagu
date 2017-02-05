# kagu
ActiveRecord models and specs for the [turaco](https://github.com/birdfeed/turaco) API and [myna](https://github.com/birdfeed/myna) Kafka-backed workers.

## Overview

- `Kagu::Models` contains ActiveRecord models.
- `Kagu::Documents` contains ElasticSearch repository objects (TBD).

## Models

To mimic Rails behaviors, we alias the constants from `Kagu::Models` into `Object` to avoid fully qualifying the path to our model. This is the exact same 'magic' done by Rails on load by `ActiveSupport`. 