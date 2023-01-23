# frozen_string_literal: true

module InputGroup
  class Game
    include ActiveModel::API

    attr_accessor :title
  end

  class TextFieldPreview < ViewComponent::Preview
    def default
      model = Game.new
      model.title = "Dig Dug"
      form = build_form(model)
      render(Felt::InputGroup::TextField.new(form: form, attribute: :title))
    end

    def with_label
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::TextField.new(form: form, attribute: :title, label: "Game Title"))
    end

    def with_hint
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::TextField.new(form: form, attribute: :title, hint: "Enter the title of the game"))
    end

    def with_help
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::TextField.new(form: form, attribute: :title, help: "Games can have different titles in different regions."))
    end

    def with_errors
      model = Game.new
      model.errors.add(:title, :invalid)
      form = build_form(model)
      render(Felt::InputGroup::TextField.new(form: form, attribute: :title))
    end

    def with_input_options
      model = Game.new
      form = build_form(model)
      render(Felt::InputGroup::TextField.new(form: form, attribute: :title, input_options: {autofocus: true}))
    end

    private

    def build_form(model)
      ActionView::Helpers::FormBuilder.new(
        model.class.to_s.underscore,
        model,
        build_template,
        {}
      )
    end

    def build_template
      ActionView::Base.new(
        :this,
        {}, # assigns?
        :there
      )
    end
  end
end
