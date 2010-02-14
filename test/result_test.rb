require File.expand_path("test_helper", File.dirname(__FILE__))

context "the Dhun::Result" do

  should("assign @data") { Dhun::Result.new('success','testing') }.assigns(:data)

  context "success? method" do
    should("return true if result is :success") { Dhun::Result.new('success','testing').success? }.equals true
    should("return false if result is not :success") { Dhun::Result.new('fail','testing').success? }.equals false
  end

  context "error? method" do
    should("return true if result is error") { Dhun::Result.new('error','testing').error? }.equals true
    should("return false if result is error") { Dhun::Result.new('noterror','testing').error? }.equals false
  end

  context "[] method" do
    should("return 'hello'") { Dhun::Result.new('success','hello')[:message] }.equals("hello")
    should("return :success") { Dhun::Result.new('success','hello')['result'] }.equals(:success)
  end

  context "to_json method" do
    asserts("returns as json") do
      Dhun::Result.new('success','test').to_json
    end.equals("{\"result\":\"success\",\"message\":\"test\"}")
  end

  context "self.from_json_str method" do
    setup { @result = Dhun::Result.from_json_str "{\"message\":\"test\",\"result\":\"success\"}" }
    should("return an instance of Result") { @result }.kind_of(Dhun::Result)
    should("have result equal success") { @result.success? }
    should("have message equal test") { @result.data[:message] }.equals "test"
    asserts("Result does not have key 'result'") {  @result.data['result'] }.nil
    asserts("Result does not have key 'message") {  @result.data['message'] }.nil
  end

end
