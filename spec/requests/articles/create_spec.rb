# frozen_string_literal: true

require './spec/spec_helper'
require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  it 'get articles' do
    article = create(:article)
    expect(article.title).to eq('Sample Title Article')
    expect(article.body).to eq('Sample Body')
    get '/api/v1/articles'
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(Article.count)
  end

  it 'valid article attributes' do
    post '/api/v1/articles', params: {
      article: {
        title: 'test',
        body: 'test body'
      }
    }
    expect(response.status).to eq(201)
    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:title]).to eq('test')
    expect(json[:body]).to eq('test body')

    expect do
      post '/api/v1/articles', params: { article: { title: 'test', body: 'test body' } }
    end.to change(Article, :count).by(1)

    expect(Article.last.title).to eq('test')
  end

  it 'invalid article attributes' do
    post '/api/v1/articles', params: {
      article: {
        title: '',
        body: 'test body'
      }
    }

    expect(response.status).to eq(422)

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:title]).to eq(["can't be blank"])

    expect do
      post '/api/v1/articles', params: { article: { title: '', body: 'test body' } }
    end.to change(Article, :count).by(0)
  end
end
