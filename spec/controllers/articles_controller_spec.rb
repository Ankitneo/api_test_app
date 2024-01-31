# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::V1::ArticlesController, type: :controller do
  describe 'GET index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @articles' do
      create(:article)
      get :index
      expect(assigns(:articles)).to eq(Article.all)
    end
  end

  describe 'GET show' do
    it 'returns a success response' do
      article = create(:article)
      get :show, params: { id: article.to_param }
      expect(response).to be_successful
    end

    it 'assigns @article' do
      article = create(:article)
      get :show, params: { id: article.to_param }
      expect(assigns(:article)).to eq(article)
    end
  end

  describe 'POST create' do
    context 'with valid parameters' do
      it 'creates a new Article' do
        expect do
          post :create, params: { article: { title: 'New Article', body: 'Content of the new article.' } }
        end.to change(Article, :count).by(1)
      end

      it 'returns a 201 status code' do
        post :create, params: { article: { title: 'New Article', body: 'Content of the new article.' } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status code' do
        post :create, params: { article: { title: '', body: 'Invalid article.' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns unprocessable entity status code' do
        post :create, params: { article: { title: 'new', body: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH/PUT update' do
    let(:article) { create(:article) }

    context 'with valid parameters' do
      it 'updates the requested article' do
        put :update, params: { id: article.to_param, article: { title: 'Updated Title' } }
        article.reload
        expect(article.title).to eq('Updated Title')
      end

      it 'returns a success response' do
        put :update, params: { id: article.to_param, article: { title: 'Updated Title' } }
        expect(response).to be_successful
      end

      it 'updates the requested article' do
        patch :update, params: { id: article.to_param, article: { title: 'Updated Title' } }
        article.reload
        expect(article.title).to eq('Updated Title')
      end

      it 'returns a success response' do
        patch :update, params: { id: article.to_param, article: { title: 'Updated Title' } }
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status code' do
        put :update, params: { id: article.to_param, article: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns unprocessable entity status code' do
        put :update, params: { id: article.to_param, article: { body: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE' do
    it 'destroys the requested article' do
      article = create(:article)
      expect do
        delete :destroy, params: { id: article.to_param }
      end.to change(Article, :count).by(-1)
    end

    it 'returns a success response' do
      article = create(:article)
      delete :destroy, params: { id: article.to_param }
      expect(response).to be_successful
    end
  end
end
