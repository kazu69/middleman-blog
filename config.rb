# Setting
# Time.zone = "Tokyo"

# slim
require 'slim'

# Susy grids in Compass
require 'susy'

# Change Compass configuration
compass_config do |config|
  config.output_style = :compact
end

# i18n
activate :i18n

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

# Helpers
# Methods defined in the helpers block are available in templates
helpers do
  def copyright_years(start_year)
    end_year = Date.today.year
    if start_year == end_year
      start_year.to_s
    else
      start_year.to_s + '-' + end_year.to_s
    end
  end

  # Holder.js image placeholder helper
  def img_holder(opts = {})
    return "Missing Image Dimension(s)" unless opts[:width] && opts[:height]
    return "Invalid Image Dimension(s)" unless opts[:width].to_s =~ /^\d+$/ && opts[:height].to_s =~ /^\d+$/

    img  = "<img data-src=\"holder.js/#{opts[:width]}x#{opts[:height]}/auto"
    img << "/#{opts[:bgcolor]}:#{opts[:fgcolor]}" if opts[:fgcolor] && opts[:bgcolor]
    img << "/text:#{opts[:text].gsub(/'/,"\'")}" if opts[:text]
    img << "\" width=\"#{opts[:width]}\" height=\"#{opts[:height]}\">"

    img
  end

end

configure :development do
  set :debug_assets, true
end

# application setting
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :slim, { pretty: true, sort_attrs: false, format: :html5 }
page '/feed.xml', layout: false
page 'article/*', layout: :layout_article
# autoprefixer
activate :autoprefixer, browsers: ['last 2 versions', 'ie 8', 'ie 9']


# blog setting
activate :blog do |blog|
  blog.prefix = 'articles'
  blog.layout = 'layouts/layout_article'
  blog.default_extension = '.md'
  blog.permalink = ":year/:month/:day/:title.html"
  blog.taglink = "tags/:tag.html"
  blog.summary_separator = /<!-- more -->/
  blog.summary_length = 120
  blog.year_link = ":year.html"
  blog.month_link = ":year/:month.html"
  blog.day_link = ":year/:month/:day.html"
  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"
  blog.paginate = true
end

# middleman-syntax setting
activate :syntax, line_numbers: true
set :layouts_dir, 'layouts'
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

# Build-specific configuration
configure :build do

# Requires middleman-favicon-maker
  # activate :favicon_maker, icons: {
  #   'favicon_base.svg' =>  [
  #     { icon: "apple-touch-icon-152x152-precomposed.png" },
  #     { icon: "apple-touch-icon-114x114-precomposed.png" },
  #     { icon: "apple-touch-icon-72x72-precomposed.png" },
  #   ]
  # }

  # For example, change the Compass output style for deployment
   activate :minify_css

  # Minify Javascript on build
   activate :minify_javascript

  # Enable cache buster
   activate :cache_buster

  # Use relative URLs
  activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end

after_configuration do
    sprockets.append_path "#{root}/bower_components/"
end

