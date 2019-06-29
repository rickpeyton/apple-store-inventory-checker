# Apple Store Inventory Checker

[![Gem Version](https://badge.fury.io/rb/apple_store_inventory_checker.svg)](https://badge.fury.io/rb/apple_store_inventory_checker)
[![CircleCI](https://circleci.com/gh/rickpeyton/apple_store_inventory_checker.svg?style=svg)](https://circleci.com/gh/rickpeyton/apple_store_inventory_checker)
[![Maintainability](https://api.codeclimate.com/v1/badges/df6fd8e126fe44f99348/maintainability)](https://codeclimate.com/github/rickpeyton/apple-store-inventory-checker/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/df6fd8e126fe44f99348/test_coverage)](https://codeclimate.com/github/rickpeyton/apple-store-inventory-checker/test_coverage)
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&identifier=77203066)](https://dependabot.com)

## Description

Apple has a habit of failing to provide enough supply to meet demand early in a product's lifecycle.

When a new product comes out I want to check the inventory at my local stores so that I will know when I can walk in and buy it.

### How I use this

I intend to setup a Ruby Lambda on AWS that will be triggered a few times a day by a Cloudwatch event.

If the item I am looking for is in stock I will receive an text message.

## Installation

Add this line to your application's Gemfile

```
gem 'apple_store_inventory_checker'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install apple_store_inventory_checker
```

## Usage

```ruby
results = AppleStoreInventoryChecker.retrieve("MV6Y2LL/A", zip: "37064", max_distance: 160)

first_result = results.first # AppleStoreInventoryChecker::Result

first_result.product # Powerbeats Pro - Totally Wireless Earphones - Black
first_result.in_stock? # false
first_result.distance # 4.76
first_result.store # CoolSprings Galleria
first_result.city # Franklin
first_result.state # TN
first_result.phone # 615-435 0620
first_result.url # http://www.apple.com/retail/coolspringsgalleria

fourth_result = results[4]

fourth_result.product # Powerbeats Pro - Totally Wireless Earphones - Black
fourth_result.in_stock? # true
fourth_result.distance # 158.76
fourth_result.store # West Town Mall
fourth_result.city # Knoxville
fourth_result.state # TN
fourth_result.phone # 865-824 2507
fourth_result.url # http://www.apple.com/retail/westtownmall
```

## Releases

CircleCi is used to push releases to rubygems.org

To release

* Edit the version.rb file
* `bundle`
* Commit that to your master branch
* Create and push a git tag with the same name as your version

Example

```
git tag -a 0.1.0
git push origin 0.1.0
```
