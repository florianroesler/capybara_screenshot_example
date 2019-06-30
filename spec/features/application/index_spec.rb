require 'rails_helper'

describe 'Index page', type: 'feature', js: true do
  before do
    visit root_path
  end

  it 'navigates to categories_explore_index_path' do
    fill_in 'fill_me', with: 'My Input'
    click_button 'Submits'
  end
end
