require 'features_helper'

describe 'Renders correct text in DE Gateway', type: 'feature', bdd: true, no_klarna: true, only: :de do
  include_context "ordering with klarna"
  include WorkflowDriver::Process

  it 'Buy button text should contain DE compliant text (DE Specific)' do
    order_product(product_name:  'Ruby on Rails Bag', testing_data: @testing_data)

    on_the_payment_page do |page|
      expect(page.displayed?).to be(true)
      page.select_klarna(@testing_data)

      page.klarna_credit do |frame|
        expect(frame).to have_content('In 14 Tagen bezahlen')
      end

      page.continue(@testing_data)
    end

    Capybara.current_session.driver.quit
  end
end
