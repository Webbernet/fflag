Fflag::Engine.routes.draw do
  get :toggles, to: 'toggle#index', as: 'FFtoggle_toggles'
  put :state, to: 'toggle#update', as: 'FFtoggle_update_toggle'
end
