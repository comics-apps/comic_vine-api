# ComicVine::Api

[![Gem Downloads](https://img.shields.io/gem/dt/comic_vine-api.svg)](https://rubygems.org/gems/comic_vine-api)
[![Build Status](https://travis-ci.org/comics-apps/comic_vine-api.svg?branch=master)](https://travis-ci.org/comics-apps/comic_vine-api)
[![Code Climate](https://codeclimate.com/github/comics-apps/comic_vine-api.svg)](https://codeclimate.com/github/comics-apps/comic_vine-api)

A simple ComicVine API client for Ruby, inspired by the koala's gem style.

This gem contains several advantages over other API clients:
* unlike with `comic_vine` gem, you can fetch series list
* you can write own http service class which can use different gem than `faraday`
* response is returned as pure Hash instead of mapping to different object
* default http service class allows you to override http options like proxy settings.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'comic_vine-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install comic_vine-api

## Usage

```ruby
api_key = 'foo'
options = {}
service = ComicVine::Api.new(api_key, **options)
```

There are two static methods:

* search

```ruby
service.search(...)
```

* types

```ruby
service.types
```

Rest of methods, for resources are creating dynamically. If API some method will change you can call `#redefine_api_methods` which recreate method from `types` API endpoint.
 
Gem provides also universal method which allows you to create custom call to API:

```ruby
service.api_call(path, args, options)
```

* path - append to `http://comicvine.gamespot.com/api/`
* args - query params
* options - options for http service class

Dynamic methods:

* `character(id, args)`
* `characters(args)`
* `chat(id, args)`
* `chats(args)`
* `concept(id, args)`
* `concepts(args)`
* `episode(id, args)`
* `episodes(args)`
* `issue(id, args)`
* `issues(args)`
* `location(id, args)`
* `locations(args)`
* `movie(id, args)`
* `movies(args)`
* `object(id, args)`
* `objects(args)`
* `origin(id, args)`
* `origins(args)`
* `person(id, args)`
* `people(args)`
* `power(id, args)`
* `powers(args)`
* `promo(id, args)`
* `promos(args)`
* `publisher(id, args)`
* `publishers(args)`
* `series(id, args)`
* `series_list(args)`
* `story_arc(id, args)`
* `story_arcs(args)`
* `team(id, args)`
* `teams(args)`
* `video(id, args)`
* `videos(args)`
* `video_type(id, args)`
* `video_types(args)`
* `video_category(id, args)`
* `video_categories(args)`
* `volume(id, args)`
* `volumes(args)`

Check official API docs what arguments you can use: http://comicvine.gamespot.com/api/documentation


## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Krzysztof Wawer/comic_vine-api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

