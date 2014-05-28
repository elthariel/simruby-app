class Page < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 4}
  validates :slug, presence: true, format: {with: /[a-z\-]+/}
  validates :content, presence: true, length: {minimum: 25}

  before_validation :title_to_slug

  def html
    # Here i create a RedCloth object with out content, ask it to output html
    # code. Then i ask rails to make the html safe (removing js, etc.) so it can
    # display it on the page. It won't allow it otherwise and use a text node.
    RedCloth.new(content).to_html.html_safe
  end

  protected
  def title_to_slug
    self.slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') unless slug and slug.length > 0
  end

end
