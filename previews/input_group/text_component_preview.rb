# frozen_string_literal: true

module InputGroup
  class Game
    include ActiveModel::API

    attr_accessor :title
    attr_accessor :description
  end

  class TextComponentPreview < ViewComponent::Preview
    def default
      model = Game.new
      model.title = "Dig Dug"
      model.description = "Diggin' game"
      form = build_form(model)
      render(Felt::InputGroup::TextComponent.new(form: form, attribute: :title))
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
