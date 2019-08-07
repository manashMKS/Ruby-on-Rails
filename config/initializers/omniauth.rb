Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "308124359156-sa13sn0j8vv4tafbov67bi5eujsl9k01.apps.googleusercontent.com", "iQwoO8Nmp7p_vb-fE6BHlsmt"
  provider :github, "34ff925faa1064dbe83d", "ef84fb085aa8fd7f3075122e5f466d06183542cb",scope: 'user:email'
  provider :facebook, "377191289655646", "d9228fe94ee0ed53b669818f0a52a7d8"

end


