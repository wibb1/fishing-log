require "spec_helper"

feature "user sees the splash page" do
  scenario "user sees links to other sites" do
    


    
    # CSV.open("grocery_list.csv", "a", headers: true) do |file|
    #   name = "tacos"
    #   file.puts([name])
    # end

    # visit "/groceries"
    # expect(page).to have_content("tacos")
  end

  scenario "user sees all grocery items at root path due to a redirect" do
    # CSV.open("grocery_list.csv", "a", headers: true) do |file|
    #   name = "tacos"
    #   file.puts([name])
    # end

    # visit "/"
    # expect(page).to have_content("tacos")
    # expect(current_path).to eq("/groceries")
  end
end