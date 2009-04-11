// 3 tests, 2 assertions, 1 failures, 1 errors

new Test.Unit.Runner({
  setup: function() {
    this.content = $('content');
    this.content.update('');
  },
  
  testHelloWorldSuccess: function() {
    this.assertEqual("", this.content.innerHTML);
    this.content.update('Hello world!');
    this.assertEqual("Hello world!", this.content.innerHTML);
  },
  
  testHelloWorldFailure: function() {
    this.assertEqual("Hello world!", this.content.innerHTML);
  },
  
  testHelloWorldError: function() {
    this.content.foo();
  },
});