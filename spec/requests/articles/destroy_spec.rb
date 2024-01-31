# frozen_string_literal: true

require './spec/spec_helper'
require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let!(:article) { create(:article) }

  it 'deletes an article' do
    expect do
      delete "/api/v1/articles/#{article.id}"
    end.to change(Article, :count).by(-1)

    expect(response.status).to eq(204)
  end
end
