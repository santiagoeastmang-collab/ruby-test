require "test_helper"

class ProductTest < ActiveSupport::TestCase
    include ActionMailer::TestHelper
    test "send email notifications when back in stock" do
        product = products(:beanie)

        product.update(inventory_count: 0)

        assert_emails 2 do
            product.update(inventory_count: 99)
        end
    end
end
