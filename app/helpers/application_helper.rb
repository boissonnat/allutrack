require 'redcarpet'
module ApplicationHelper
    def markdown(text)
      renderer = Redcarpet::Render::HTML.new(render_options = {})
      markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      markdown.render(text).html_safe
    end
end
