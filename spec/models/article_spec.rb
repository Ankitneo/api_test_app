# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe Article, type: :model do
  context 'check article' do
    it 'checks article title' do
      article = Article.create(title: 'hello', body: 'this is test')
      article1 = Article.find_by(id: article.id)
      expect(article.title).to eq(article1.title)
    end

    it 'checks article body' do
      article = Article.create(title: 'hello', body: 'this is test')
      article1 = Article.find_by(id: article.id)
      expect(article.body).to eq(article1.body)
    end
  end

  context 'checks article title validation' do
    it 'validates presence of title' do
      article = Article.new(title: '', body: 'this is a test')
      expect(article.valid?).to be_falsey
      expect(article.errors[:title]).to include("can't be blank")
    end

    it 'creates a valid article' do
      article = Article.new(title: 'Valid Title', body: 'this is a test')
      expect(article.valid?).to be_truthy
    end

    it 'does not increase the article count with invalid article' do
      expect do
        Article.create(title: '', body: 'this is a test')
      end.not_to change(Article, :count)
    end

    it 'increases the article count with a valid article' do
      expect do
        Article.create(title: 'Valid Title', body: 'this is a test')
      end.to change(Article, :count).by(1)
    end
  end

  context 'checks article body validation' do
    it 'validates presence of title' do
      article = Article.new(title: 'hello', body: '')
      expect(article.valid?).to be_falsey
      expect(article.errors[:body]).to include("can't be blank")
    end

    it 'creates a valid article' do
      article = Article.new(title: 'Valid Title new', body: 'Valid body')
      expect(article.valid?).to be_truthy
    end

    it 'does not increase the article count with invalid article' do
      expect do
        Article.create(title: 'hello', body: '')
      end.not_to change(Article, :count)
    end

    it 'increases the article count with a valid article' do
      expect do
        Article.create(title: 'Title new', body: 'Valid Body')
      end.to change(Article, :count).by(1)
    end
  end
end
