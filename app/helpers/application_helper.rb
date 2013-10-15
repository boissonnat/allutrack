require 'redcarpet'
module ApplicationHelper
    def markdown(text)
      renderer = Redcarpet::Render::HTML.new(render_options = {
          :prettify => true
      })
      markdown = Redcarpet::Markdown.new(renderer, extensions = {
          :strikethrough => true,
          :no_intra_emphasis => true,
          :tables => true,
          :fenced_code_blocks => true,
          :disable_indented_code_blocks => true,
          :highlight => true,
          :space_after_headers => true,
          :autolink => true
      })
      markdown.render(text).html_safe
    end
end
