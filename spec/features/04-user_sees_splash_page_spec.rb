require "rails_helper"

feature "user sees the splash page" do
  scenario "user sees links to other sites" do
    visit "/"
    expect(page).to have_content("The Fishing Log")
    expect(current_path).to eq("/")
  end

  scenario "user sees link to home page" do
    # expect(page).to have_content("Fising ")
  end
end