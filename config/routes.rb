VlcClickr::Application.routes.draw do
	match "vlc/*method" =>'vlc#index'
	match "v/(*url)" => 'paths#movies'
	match "t/(*url)" => 'paths#tv'
	match "m/(*url)" => 'paths#music'
	root :to => 'paths#index'
end
