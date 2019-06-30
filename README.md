# Apple Store Inventory Checker

[![Gem Version](https://badge.fury.io/rb/apple_store_inventory_checker.svg)](https://badge.fury.io/rb/apple_store_inventory_checker)
[![CircleCI](https://circleci.com/gh/rickpeyton/apple-store-inventory-checker.svg?style=svg)](https://circleci.com/gh/rickpeyton/apple-store-inventory-checker)
[![Maintainability](https://api.codeclimate.com/v1/badges/df6fd8e126fe44f99348/maintainability)](https://codeclimate.com/github/rickpeyton/apple-store-inventory-checker/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/df6fd8e126fe44f99348/test_coverage)](https://codeclimate.com/github/rickpeyton/apple-store-inventory-checker/test_coverage)
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&identifier=77203066)](https://dependabot.com)

## Description

Apple has a habit of failing to provide enough supply to meet demand early in a product's lifecycle.

When a new product comes out I want to check the inventory at my local stores so that I will know when I can walk in and buy it.

### How I use this

I have a Ruby Lambda on AWS (https://github.com/rickpeyton/powerbeats-notifier-lambda) that is triggered every three hours by a Cloudwatch event.

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

The first argument is the item number. You might be able to pull this out of the URL, but the best way to be sure is to pull it off of the XHR request Apple makes to their "pickup-message" endpoint when you load the product Apple Store page.

Max Distance is optional and is an integer representation of the miles you want to search for Apple Stores from your zip code. The default is 15.

```ruby
retrieve_results = AppleStoreInventoryChecker.retrieve("MV6Y2LL/A", zip: "37064", max_distance: 160)

first_result = retrieve_results.first # AppleStoreInventoryChecker::Result

first_result.product # Powerbeats Pro - Totally Wireless Earphones - Black
first_result.in_stock? # false
first_result.distance # 4.76
first_result.store # CoolSprings Galleria
first_result.city # Franklin
first_result.state # TN
first_result.phone # 615-435 0620
first_result.url # http://www.apple.com/retail/coolspringsgalleria

in_stock_results = retrieve_results.select(&:in_stock?)

in_stock_results.first.product # Powerbeats Pro - Totally Wireless Earphones - Black
in_stock_results.first.in_stock? # true
in_stock_results.first.distance # 158.76
in_stock_results.first.store # West Town Mall
in_stock_results.first.city # Knoxville
in_stock_results.first.state # TN
in_stock_results.first.phone # 865-824 2507
in_stock_results.first.url # http://www.apple.com/retail/westtownmall
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
