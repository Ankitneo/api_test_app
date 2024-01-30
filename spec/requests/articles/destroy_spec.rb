# frozen_string_literal: true

require './spec/spec_helper'
require 'rspec/rails'

RSpec.describe 'Articles', type: :request do
  let!(:article) { Article.create(title: 'Valid Title', body: 'this is a test') }

  it 'deletes an article' do
    expect do
      delete "/api/v1/articles/#{article.id}"
    end.to change(Article, :count).by(-1)

    expect(response.status).to eq(204)
  end
end
