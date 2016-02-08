require_relative "../lib/rps"

# The path being defined for this controller action is just "/", meaning 
# the root path. It's the homepage.
MyApp.get "/" do
  erb :"homepage"
end

MyApp.get "/:weaponone" do
	erb :"p2chooses"
end

MyApp.get "/:weaponone/:weapontwo" do
	@game_result = rps_justice(params[:weaponone], params[:weapontwo])
 	erb :"results"
end