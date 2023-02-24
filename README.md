# Felt

A set of view components for rendering forms in Rails applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'felt'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install felt

## Usage

```
<% form_for(person) do |form| %>
  <%= render(Felt::InputGroup::TextField.new(:form => form, :attribute => :name)) %>
<% end %>
```

## Felt is unstyled by default

By default Felt only includes a bunch of markup and serverside behavior. If you want your input fields to not be unstyled, you have to configure things a bit.

To configure the classes you want to apply to your markup, use an initializer. For example, to style your inputs using Flowbite styles:

```
# config/initializers/felt.rb
Felt.classes = {
  :input_group => {
    :error => "mt-2 text-sm text-red-600 dark:text-red-500",
    :hint => "mt-2 text-sm text-gray-500 dark:text-gray-400",
    :label => "block mb-2 text-sm font-medium text-gray-900 dark:text-white",
    :input => "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
  }
}
```

If you're using Tailwind 3.0+ remember to add this initializer to your content settings so your classes aren't purged:

```
// tailwind.config.js
module.exports = {
  content: [
    './config/initializers/felt.rb',
  ],
  ...
}
```

## Goals

* Form input fields must support the following properties:
  * Placeholders
  * Labels
  * Disabled states
  * Error states
  * Hints/helper text
* Classes must be customizable so we can change the inputs we don't like. Ie if inputs should have square corners, not rounded.
* Markup must be customizable so we can change anything we don't like.

## Based on existing UI libraries

Default styles should come from an existing UI library. We cannot design and support a full UI library on top of building the components. Let's stand on the shoulders of giants.

### Possible choices

* [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/components/selection-and-input/text-fields)
* [Atlassian Design System](https://atlassian.design/components/form/examples)
* [Base Web](https://baseweb.design/components/form-control/)
* [Bootstrap](https://getbootstrap.com/docs/5.3/forms/overview/)
* [Flowbite](https://flowbite.com/docs/forms/input-field/)
* [GOV.UK Design System](https://design-system.service.gov.uk/components/text-input/)
* [Material](https://m3.material.io/components/text-fields/specs)
* [Polaris](https://polaris.shopify.com/components/form-layout)
* [Tailwind UI](https://tailwindui.com/)

## Anatomy of a form field

What does a form control or an input group consist of?

* Input: The actual input field. This can be a text field or a checkbox or a dropdown list or something entirely different.

* Hint: Use hint text for help that’s relevant to the majority of users, like how their information will be used, or where to find it. This is shown above the input.

* Help: A short text providing detailed help to the user. This is shown below the input.

## Architectural decisions

* Components don't use the `*Component` suffix. This makes naming and usage less verbose. And while it does stray against general ViewComponent recommendations (https://viewcomponent.org/adrs/0002-naming-conventions-for-view-components.html), the pros outweigh the cons in my opinion. Also, if it is good enough for Primer, it is good enough for us (https://viewcomponent.org/adrs/0002-naming-conventions-for-view-components.html).

* Where applicable component names should match those of their Rails counterparts. Ie a component that replaces `#text_field` should be named `Felt::TextField` etc.

* We use sidecar folders for all components.

* When in doubt, fail towards Rails. For example, the Rails option to set the value of a checkbox input field is `checked_value`. In my view it would make more sense to use `value`, but for an easier learning curve, using the terms from Rails is probably best.

## To Do

* [ ] Remove hardcoded classes from CheckboxField...
* [ ] Leading icons
* [ ] Trailing icons
* [ ] Error state for labels
* [ ] Error state for the entire input group
* [ ] Support all Rails form builder tags
* [ ] ARIA!
* [ ] Create a standard set of styles that can be distributed with the gem, so it looks proper - perhaps based on Flowbite?
* [ ] Should I18n scope be "felt", not "form"?

## Glossary and terms

| Felt        | Base Web      | Bootstrap    | Flowbite    | GOV UK     | Tailwind UI |
|-------------|---------------|--------------|-------------|------------|-------------|
| Help        | Caption       |              | Helper      |            | Help        |
| Hint        |               |              |             | Hint       | |
| Input       | Input         |              |             |            | |
| Input Group | Form Control  | Form control | Input field | Form group | Input group |
| Label       | Label         |              |             | Label      | Label       |
| Placeholder | Placeholder   |              |             |            | |
|             |               | Input group  | Input group |            | Add-on      |

## Stacked vs horizontal input groups

- Bootstrap stacks fields by default, but also supports horizontal and inline forms (https://getbootstrap.com/docs/5.3/forms/layout/).
- Polaris stacks fields by default, but also supports horizontal groups of fields (https://polaris.shopify.com/components/form-layout).

## Similar projects and inspirations

* https://github.com/heartcombo/simple_form
* https://github.com/pantographe/view_component-form

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/koppen/felt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/koppen/felt/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Felt project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/koppen/felt/blob/main/CODE_OF_CONDUCT.md).
