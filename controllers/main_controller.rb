require_relative "../lib/rps"

# The path being defined for this controller action is just "/", meaning 
# the root path. It's the homepage.
MyApp.get "/" do
  erb :"homepage"
end