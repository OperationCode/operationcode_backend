# Monkey patch the `test` DSL to enable VCR and configure a cassette named
# based on the test method. This means that a test written like this:
#
# class OrderTest < ActiveSupport::TestCase
#   test "user can place order" do
#     ...
#   end
# end
#
# will automatically use VCR to intercept and record/play back any external
# HTTP requests using `cassettes/order_test/_user_can_place_order.yml`.
#
class ActiveSupport::TestCase
  def self.test(test_name, &block)
    return super if block.nil?

    cassette = [name, test_name].map do |str|
      str.underscore.gsub(/[^A-Z]+/i, "_")
    end.join("/")

    super(test_name) do
      VCR.use_cassette(cassette) do
        instance_eval(&block)
      end
    end
  end
end
