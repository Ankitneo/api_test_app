# frozen_string_literal: true

require './spec/spec_helper'
require 'rspec/rails'

RSpec.describe 'Articles', type: :request do
  let(:article) { Article.create(title: 'Valid Title', body: 'this is a test') }

  it 'valid article attributes' do
    put "/api/v1/articles/#{article.id}", params: {
      article: {
        title: 'test',
        body: 'test body'
      }
    }

    expect(response.status).to eq(200)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:title]).to eq('test')
    expect(json[:body]).to eq('test body')
    expect do
      put "/api/v1/articles/#{article.id}",
          params: { article: { title: 'updated title', body: 'updated body' } }
    end.not_to change(Article, :count)
    expect(Article.last.title).to eq('updated title')
  end

  it 'invalid article attributes' do
    put "/api/v1/articles/#{article.id}", params: {
      article: {
        title: '',
        body: 'test body'
      }
    }

    expect(response.status).to eq(422)

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:title]).to eq(["can't be blank"])

    expect do
      put "/api/v1/articles/#{article.id}",
          params: { article: { title: '', body: 'invalid body' } }
    end.not_to change(Article, :count)
  end
end
