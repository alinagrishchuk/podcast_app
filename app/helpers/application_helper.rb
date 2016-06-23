module ApplicationHelper

  def nav_link(text, link)
    if current? link
      active_link(text)
    else
      content_tag(:li) do
        link(text, link)
      end
    end
  end

  private
    # check - link equal current page
    def current? link
      request.env['PATH_INFO'] == link
    end

    # create link view element
    def active_link(text)
      content_tag(:li) do
        content_tag :span, text, :class => 'active'
      end
    end

    def link(text, link)
      content_tag('li') do
        link_to text, link
      end
    end

end
