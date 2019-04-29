# AttributesTable

A helper to create a localized, bootstrap-styled table of an ActiveModel's attributes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'attributes_table'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attributes_table

## Usage

In your view call the helper to render a bootstrap panel with heading and a table in the body:

```erbruby
<%= attributes_table @record, "Panel Title" do |t| %>
  <%= t.attribute :string %>
  <%= t.attribute :number, class: ('special' if @record.special) %>
  <%= t.attribute :boolean %>
  <%= t.attribute :enumerized %>
  <%= t.attribute :active do %>
    <%= @ticket.active ? "Aktiv" : "Passiv" %>
  <% end %>
<% end %>
```

Will result in:

```html
<div class="panel panel-default"><div class="panel-heading">Panel Title</div><table class="table attributes-table"><tbody>
    <tr><td class="attribute-label">Localized attribute name</td><td class="attribute-value">Value</td></tr>
    <tr><td class="attribute-label">Number</td><td class="attribute-value special">148</td></tr>
    <tr><td class="attribute-label">Boolean</td><td class="attribute-value">Yes</td></tr>
    <tr><td class="attribute-label">Enumerized</td><td class="attribute-value">Uses the i18n methods of enumerize gem</td></tr>
    <tr><td class="attribute-label">Active</td><td class="attribute-value">Aktiv</td></tr>
</tbody></table></div>
```

### Displayed values

It uses the localized attribute name for the first column. The name is localized using `ActiveModel.human_attribute_name()`

It displays the attributes value in the right column using these transformations:

- nil is displayed as empty cell
- boolean values are localized using 'default.true' and 'default.false' keys
- if the model responds to `attribute_name_text` the return values of this method is displayed. This allows to support enumerized values from the great Enumerize gem
- Date, DateTime and Time values are passed to the l helper without format option
- if the values responds to `to_s` this value is used
 
Otherwise the value is output like it is. Which is probably the same as calling `to_s`

### Pundit Integration

The helper expects to find a Pundit Policy for the model. It calls `visible_attributes` on the policy to determine which attributes to display. If the array retirned by `visible_attributes` does not include the attribute name, no table row is rendered.

This behaviour is richt now  

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the (currently nonexisting) tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tonklon/attributes_table.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
