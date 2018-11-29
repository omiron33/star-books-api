Rails.application.routes.draw do
  
  scope '/api' do
    resources :libraries
  end
  
  get 'upload' => 'libraries#upload'

  

end
