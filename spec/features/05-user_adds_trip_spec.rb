require "rails_helper"

feature "visitors can add trips" do
  scenario "visitor adds new trip successfully" do
    
    visit new_trip_path
    expect(page).to have_content "New Trip"
    click_button "Submit"
    
    @species_list = ["striped bass", "fluke", "bluefish", "bonita", "false ablicore", "scup", "tautog"]
    page.all('select#trip_success option').map(&:value).should == %w(Good Bad)
    page.all('select#trip_species option').map(&:value).should == @species_list

    # fill_in 'Name', with: "Name"
    # fill_in 'Spot Description', with: "body"
    # fill_in 'Latitude', with: "40.8"
    # fill_in 'Longitude', with: "-70.8"
    # fill_in 'Date', with: Date.current.strftime("%m%d%Y")
    # fill_in 'Date', with: Time.current.strftime("%H:%M%p")    
    # find("How was the fishing?[value='Good']").click
    # find("Species[value='striped bass']").click
    # find("Shared[value='Shared']").click
    # click_button "Submit"

    expect(page).to have_current_path("/trips/react/#{params[:id]}")
  end

  scenario "visitor does not provide proper information for a trip" do
    visit new_trip_path

    click_button "Submit"
    expect(page).to have_content "Please fill out this field"

    click_button "Sign Out"
    expect(page).to have_content "Signed out successfully"
  end
end