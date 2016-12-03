# Railbars

Railbars provides a bunch of view helpers for generating handlebar templates in your rails app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'railbars'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install railbars

## Usage

### Expressions

Expressions are simple values

```erb
  <p><%= hb('hello') %></p>
```

Output:

```html
  <p>{{hello}}</p>
```

### Helpers

If you have defined custom helpers and support literal params and hash params. They can be used like so:

```erb
  <p><%= hb('nameOfHelper', 'firstParam', 'secondParam', {firstHash: 'a', secondHash: 1}) %></p>
```

Output:

```html
  <p>{{#nameOfHelper firstParam secondParam firstHash="a" secondHash=1}}</p>
```

### Block Helpers

Like Helpers, block helpers support params, but have the added bonus of wrapping around a block:

```erb
  <%= hb('nameOfHelper', 'firstParam', 'secondParam', {firstHash: 'a', secondHash: 1}) do %>
    <p>Hello</p>
  <% end %>
```

Output:

```html
  {{#nameOfHelper firstParam secondParam firstHash="a" secondHash=1}}
    <p>Hello</p>
  {{/nameOfHelper}}
```

### Unescape

Handlebars Unescape are available through the `hbunescape` method:

```erb
  <p><%= hbunescape('hello') %></p>
```

Output:

```html
  <p>{{{hello}}}</p>
```

### Partials

Handlebars Partials are available through the `hbpartial` method:

```erb
  <p><%= hbpartial('hello') %></p>
```

Output:

```html
  <p>{{> hello}}}</p>
```

### Each

Built in helpers such as each are also provided:

```erb
  <%= hbeach('item') do %>
    <li>Element</li>
  <% end %>
```

Output:

```html
  {{#each item}}
    <li>Element</li>
  {{/each}}
```

### If

If, like else, also has a helper with similar syntax:

```erb
  <%= hbif('loggedIn') do %>
    <p>Logged In</p>
  <% end %>
```

Output:

```html
  {{#if loggedIn}}
    <p>Logged In</p>
  {{/each}}
```

### Else

Else is just a simple expression and can be placed within an if block:

```erb
  <%= hbif('loggedIn') do %>
    <p>Logged In</p>
    <%= hbelse %>
    <p>Logged Out</p>
  <% end %>
```

Output:

```html
  {{#if loggedIn}}
    <p>Logged In</p>
    {{#else }}
    <p>Logged Out</p>
  {{/each}}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mrlhumphreys/railbars. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

