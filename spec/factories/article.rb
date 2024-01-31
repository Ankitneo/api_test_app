# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :article do
    title { 'Sample Title Article' }
    body { 'Sample Body' }
  end
end
