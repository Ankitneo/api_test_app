# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'Sample Title Article' }
    body { 'Sample Body' }
  end
end
