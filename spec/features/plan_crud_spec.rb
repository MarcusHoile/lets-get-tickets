require 'spec_helper'

describe 'Plans CRUD', type: :feature, js: true do
  subject { page }

  describe 'Create a plan' do
    before { visit('/') }

    describe 'Home page' do
      it 'has the right content' do
        expect(page).to have_content('Create a Plan')
        expect(page).to have_content('View Demo')
        expect(page).to have_content('Make plans, book your friends')
      end
    end

    describe 'filling out and submitting the form' do
      before do
        within('.cta') do
          find_link('Create a Plan').click
        end
      end

      context 'valid params' do
        before do
          fill_out_form_with_valid_params
          submit_form
        end

        it 'creates a plan and goes to show page' # do
          # expect(current_path).to eq(plan_path(Plan.last))
        # end
      end

      context 'invalid params' do
        before do
          fill_out_form_with_invalid_params
          submit_form
        end

        it 'reloads page' do
          expect(current_path).to eq new_plan_path
        end

        it 'shows errors'

        it 'displays dates in right format' do
          expect(find_field('When').value).to eq '29/10/2015 10:00'
        end

        describe 'resubmitting form' do
          before do
            fill_in 'Deadline', with: '29/09/2015 11:11'
            fill_in 'Price', with: 99
            submit_form
          end

          it 'creates a plan and goes to show page'
        end
      end
    end
  end

  def fill_out_form_with_valid_params
    # have to find and fill elements as they will fail on CI builds
    # the find will enable capybara to wait for elements
    find(:css, "input[id$='plan_what']").set("Some Gig")
    find(:css, "input[id$='plan_when']").set("29/10/2015 10:00")
    find(:css, "input[id$='plan_deadline']").set('29/09/2015 11:11')
    find(:css, "input[id$='plan_where']").set('Some Place')
    find(:css, "input[id$='plan_price']").set(99)
  end

  def fill_out_form_with_invalid_params
    find(:css, "input[id$='plan_what']").set("Some Gig")
    find(:css, "input[id$='plan_when']").set("29/10/2015 10:00")
    find(:css, "input[id$='plan_where']").set('Some Place')
    find(:css, "input[id$='plan_price']").set('invalid')
  end

  def submit_form
    find('input[name="commit"]').click
  end
end
