# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe 'Articles routing', type: :routing do
  it 'routes to api/v1/articles#index' do
    expect(get: 'api/v1/articles').to route_to('api/v1/articles#index')
  end

  it 'routes to api/v1/articles#create' do
    expect(post: 'api/v1/articles').to route_to('api/v1/articles#create')
  end

  it 'routes to api/v1/articles#show' do
    expect(get: 'api/v1/articles/1').to route_to('api/v1/articles#show', id: '1')
  end

  it 'routes to api/v1/articles#update' do
    expect(put: 'api/v1/articles/1').to route_to('api/v1/articles#update', id: '1')
  end

  it 'routes to api/v1/articles#destroy' do
    expect(delete: 'api/v1/articles/1').to route_to('api/v1/articles#destroy', id: '1')
  end

  it 'not reachable routes' do
    expect(delete: 'articles/1').not_to be_routable
    expect(put: 'articles/1').not_to be_routable
  end
end
