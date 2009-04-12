# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = %q{js-test-san}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eloy Duran"]
  s.date = %q{2009-04-12}
  s.default_executable = %q{jstest}
  s.description = %q{A JavaScript test runner which runs from the comfort of the terminal. OS X only.}
  s.email = %q{eloy.de.enige@gmail.com}
  s.executables = ["jstest"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "bin/jstest",
    "lib/js_test_san.rb",
    "lib/js_test_san/runner.rb",
    "lib/js_test_san/test.rb",
    "lib/js_test_san/test_case.rb",
    "test/fixtures/a_unit_test.html",
    "test/fixtures/a_unit_test.js",
    "test/regression/prototype/unit/ajax_test.html",
    "test/regression/prototype/unit/array_test.html",
    "test/regression/prototype/unit/assets/prototype.js",
    "test/regression/prototype/unit/assets/unittest.css",
    "test/regression/prototype/unit/assets/unittest.js",
    "test/regression/prototype/unit/assets/unittest_transport.js",
    "test/regression/prototype/unit/base_test.html",
    "test/regression/prototype/unit/class_test.html",
    "test/regression/prototype/unit/date_test.html",
    "test/regression/prototype/unit/dom_test.html",
    "test/regression/prototype/unit/element_mixins_test.html",
    "test/regression/prototype/unit/enumerable_test.html",
    "test/regression/prototype/unit/event_test.html",
    "test/regression/prototype/unit/fixtures/ajax.html",
    "test/regression/prototype/unit/fixtures/ajax.js",
    "test/regression/prototype/unit/fixtures/array.html",
    "test/regression/prototype/unit/fixtures/class.js",
    "test/regression/prototype/unit/fixtures/content.html",
    "test/regression/prototype/unit/fixtures/data.json",
    "test/regression/prototype/unit/fixtures/dom.css",
    "test/regression/prototype/unit/fixtures/dom.html",
    "test/regression/prototype/unit/fixtures/dom.js",
    "test/regression/prototype/unit/fixtures/element_mixins.html",
    "test/regression/prototype/unit/fixtures/element_mixins.js",
    "test/regression/prototype/unit/fixtures/empty.html",
    "test/regression/prototype/unit/fixtures/empty.js",
    "test/regression/prototype/unit/fixtures/enumerable.html",
    "test/regression/prototype/unit/fixtures/enumerable.js",
    "test/regression/prototype/unit/fixtures/event.html",
    "test/regression/prototype/unit/fixtures/form.html",
    "test/regression/prototype/unit/fixtures/function.js",
    "test/regression/prototype/unit/fixtures/hash.js",
    "test/regression/prototype/unit/fixtures/hello.js",
    "test/regression/prototype/unit/fixtures/logo.gif",
    "test/regression/prototype/unit/fixtures/object.html",
    "test/regression/prototype/unit/fixtures/object.js",
    "test/regression/prototype/unit/fixtures/position.html",
    "test/regression/prototype/unit/fixtures/selector.html",
    "test/regression/prototype/unit/fixtures/string.js",
    "test/regression/prototype/unit/fixtures/unittest.html",
    "test/regression/prototype/unit/form_test.html",
    "test/regression/prototype/unit/function_test.html",
    "test/regression/prototype/unit/hash_test.html",
    "test/regression/prototype/unit/number_test.html",
    "test/regression/prototype/unit/object_test.html",
    "test/regression/prototype/unit/periodical_executer_test.html",
    "test/regression/prototype/unit/position_test.html",
    "test/regression/prototype/unit/prototype_test.html",
    "test/regression/prototype/unit/range_test.html",
    "test/regression/prototype/unit/regexp_test.html",
    "test/regression/prototype/unit/selector_test.html",
    "test/regression/prototype/unit/string_test.html",
    "test/regression/prototype/unit/tests/ajax_test.js",
    "test/regression/prototype/unit/tests/array_test.js",
    "test/regression/prototype/unit/tests/base_test.js",
    "test/regression/prototype/unit/tests/class_test.js",
    "test/regression/prototype/unit/tests/date_test.js",
    "test/regression/prototype/unit/tests/dom_test.js",
    "test/regression/prototype/unit/tests/element_mixins_test.js",
    "test/regression/prototype/unit/tests/enumerable_test.js",
    "test/regression/prototype/unit/tests/event_test.js",
    "test/regression/prototype/unit/tests/form_test.js",
    "test/regression/prototype/unit/tests/function_test.js",
    "test/regression/prototype/unit/tests/hash_test.js",
    "test/regression/prototype/unit/tests/number_test.js",
    "test/regression/prototype/unit/tests/object_test.js",
    "test/regression/prototype/unit/tests/periodical_executer_test.js",
    "test/regression/prototype/unit/tests/position_test.js",
    "test/regression/prototype/unit/tests/prototype_test.js",
    "test/regression/prototype/unit/tests/range_test.js",
    "test/regression/prototype/unit/tests/regexp_test.js",
    "test/regression/prototype/unit/tests/selector_test.js",
    "test/regression/prototype/unit/tests/string_test.js",
    "test/regression/prototype/unit/tests/unittest_test.js",
    "test/regression/prototype/unit/unittest_test.html",
    "test/regression/prototype/upstream",
    "test/test_helper.rb",
    "test/unit/runner_test.rb",
    "test/unit/test_case_test.rb",
    "test/unit/test_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/alloy/js-test-san/tree/master}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A JavaScript test runner which runs from the comfort of the terminal. OS X only.}
  s.test_files = [
    "test/test_helper.rb",
    "test/unit/runner_test.rb",
    "test/unit/test_case_test.rb",
    "test/unit/test_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
