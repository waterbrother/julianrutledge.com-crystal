require "kemal"

#year = Time.now.year
year = 2022
port = 8080

get "/" do
  render "src/views/index.ecr", "src/views/main.ecr"
end

get "/about" do
  render "src/views/about.ecr", "src/views/main.ecr"
end

get "/news" do
  render "src/views/news.ecr", "src/views/main.ecr"
end

get "/code" do
  render "src/views/code.ecr", "src/views/main.ecr"
end

get "/music" do
  render "src/views/music.ecr", "src/views/main.ecr"
end

get "/contact" do
  render "src/views/contact.ecr", "src/views/main.ecr"
end

#NOTE to self: any files in ../public need to be copied to the execution dir
Kemal.config.env = "production"
Kemal.run port
