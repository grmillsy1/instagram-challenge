require 'rails_helper'

  # ```
  # As a social media user
  # So that I can show my friends what I have been doing
  # I would like to upload my pictures to Instagram
  #
  # ```

  feature 'upload photo' do
    context 'no photos have been uploaded yet' do
      scenario 'can upload a photo to the homepage' do
        visit '/photos'
        expect(page).to have_content 'No photos uploaded yet.'
        expect(page).to have_link 'Click this link to add your first'
      end
    end

    context 'photos have been added' do
      before do
        Photo.create(tag: 'day at the beach')
      end
        scenario 'display photos and tags' do
          visit '/photos'
          expect(page).to have_content('day at the beach')
          expect(page).not_to have_content('No photos uploaded yet.')
          expect(page).to have_content('Upload a photo')
      end
    end

    context 'creating posts' do
      before do
        sign_up
        Photo.create(tag: 'day at the beach')
      end
      scenario 'user fills out a form, and can see the photo on the website' do
        visit '/photos'
        click_link 'Upload a photo'
        fill_in 'Tag', with: 'Day by the beach'
        click_button 'Create Photo'
        expect(page).to have_content 'Day by the beach'
        expect(current_path).to eq '/photos'
      end
    end

    context 'view posts' do
      let!(:wedding) { Photo.create(tag:'wedding') }
      scenario 'let a user view a photo' do
        visit '/photos'
        click_link 'wedding'
        expect(page).to have_content 'wedding'
        expect(current_path).to eq "/photos/#{wedding.id}"
      end
    end
  end
