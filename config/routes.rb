Rails.application.routes.draw do
          mount Blacklight::Engine => '/'

  
  concern :searchable, Blacklight::Routes::Searchable.new

resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
  concerns :searchable
end

  devise_for :users
  Hydra::BatchEdit.add_routes(self)
  # This must be the very last route in the file because it has a catch-all route for 404 errors.
  # This behavior seems to show up only in production mode.
  mount Sufia::Engine => '/'

  mount Hydra::Collections::Engine => '/'
  mount CurationConcerns::Engine, at: '/'
  resources :welcome, only: 'index'
  root 'sufia/homepage#index'
  curation_concerns_collections
  curation_concerns_basic_routes
  curation_concerns_embargo_management
  concern :exportable, Blacklight::Routes::Exportable.new

resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
  concerns :exportable
end

resources :bookmarks do
  concerns :exportable

  collection do
    delete 'clear'
  end
end

end
