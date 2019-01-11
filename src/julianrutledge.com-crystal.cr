require "kemal"

year = Time.now.year

get "/" do
  render "src/views/index.ecr", "src/views/main.ecr"
end

get "/about" do
  render "src/views/about.ecr", "src/views/main.ecr"
end

get "/news" do
  render "src/views/news.ecr", "src/views/main.ecr"
end

get "/portfolio" do
  render "src/views/portfolio.ecr", "src/views/main.ecr"
end

get "/contact" do
  render "src/views/contact.ecr", "src/views/main.ecr"
end

Kemal.run
