require "rails_helper"

feature "visitors can add trips" do
  scenario "visitor adds new trip successfully" do
    visit new_user_session_path

    fill_in 'Email', with: "thumb@aol.com"
    fill_in 'Password', with: "123456"
    click_button "Log In"
    
    visit edit_trip_path
    expect(page).to have_content "Edit Trip"
    expect(page).to have_no_content('Latitude')
    expect(page).to have_no_content('Longitude')
    expect(page).to have_no_content('Date')
    expect(page).to have_no_content('Time')

    @species_list = ["striped bass", "fluke", "bluefish", "bonita", "false ablicore", "scup", "tautog"]
    page.all('select#trip_species option').map(&:value).should == @species_list
    page.all('select#trip_success option').map(&:value).should == %w(Good Bad)

    # fill_in 'Name', with: "Name"
    # fill_in 'Spot Description', with: "body"
    # find("How was the fishing?[value='Good']").click
    # find("Species[value='striped bass']").click
    # find("Shared[value='Shared']").click
    # click_button "Submit"
    # expect(page).to have_current_path("/trips/react/#{params[:id]}")

  end
  scenario "visitor does not provide proper information for a trip" do
    visit new_trip_path

    click_button "Submit"
    expect(page).to have_content "Please fill out this field"
  end
end