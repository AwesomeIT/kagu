# kagu
[![CircleCI](https://circleci.com/gh/birdfeed/kagu.svg?style=shield)](https://circleci.com/gh/birdfeed/kagu)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/85a7a177226f4eb5acfafa89c04c8be2)](https://www.codacy.com/app/birdfeed/kagu?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=birdfeed/kagu&amp;utm_campaign=Badge_Grade)

ActiveRecord models and specs for the [turaco](https://github.com/birdfeed/turaco) API and [myna](https://github.com/birdfeed/myna) Kafka-backed workers.

## Overview

- `Kagu::Models` contains ActiveRecord models.
- `Kagu::Documents` contains ElasticSearch repository objects (TBD).

## Models

To mimic Rails behaviors, we alias the constants from `Kagu::Models` into `Object` to avoid fully qualifying the path to our model. This is the exact same 'magic' done by Rails on load by `ActiveSupport`. 
