# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{headless-squirrel}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eloy Duran"]
  s.date = %q{2009-06-17}
  s.default_executable = %q{jstest}
  s.description = %q{A OS X command line tool to run JavaScript (Prototype) unit tests from the comfort of your terminal.}
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
    "lib/headless_squirrel.rb",
    "lib/headless_squirrel/console.rb",
    "lib/headless_squirrel/runner.rb",
    "lib/headless_squirrel/test.rb",
    "lib/headless_squirrel/test_case.rb",
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
    "test/regression/scriptaculous/unit/_ajax_inplaceeditor_ipce_alt_text.html",
    "test/regression/scriptaculous/unit/_ajax_inplaceeditor_ipce_collection.js",
    "test/regression/scriptaculous/unit/_ajax_inplaceeditor_result.html",
    "test/regression/scriptaculous/unit/_ajax_inplaceeditor_result2.html",
    "test/regression/scriptaculous/unit/_ajax_inplaceeditor_tagged.html",
    "test/regression/scriptaculous/unit/_ajax_inplaceeditor_text.html",
    "test/regression/scriptaculous/unit/_ajax_updater_result.html",
    "test/regression/scriptaculous/unit/_autocomplete_result.html",
    "test/regression/scriptaculous/unit/_autocomplete_result_nobr.html",
    "test/regression/scriptaculous/unit/ajax_autocompleter_test.html",
    "test/regression/scriptaculous/unit/ajax_inplaceeditor_test.html",
    "test/regression/scriptaculous/unit/assets/builder.js",
    "test/regression/scriptaculous/unit/assets/controls.js",
    "test/regression/scriptaculous/unit/assets/dragdrop.js",
    "test/regression/scriptaculous/unit/assets/effects.js",
    "test/regression/scriptaculous/unit/assets/javascripttest.rb",
    "test/regression/scriptaculous/unit/assets/prototype.js",
    "test/regression/scriptaculous/unit/assets/scriptaculous.js",
    "test/regression/scriptaculous/unit/assets/slider.js",
    "test/regression/scriptaculous/unit/assets/sound.js",
    "test/regression/scriptaculous/unit/assets/unittest.js",
    "test/regression/scriptaculous/unit/bdd_test.html",
    "test/regression/scriptaculous/unit/builder_test.html",
    "test/regression/scriptaculous/unit/dragdrop_test.html",
    "test/regression/scriptaculous/unit/effects_test.html",
    "test/regression/scriptaculous/unit/element_test.html",
    "test/regression/scriptaculous/unit/icon.png",
    "test/regression/scriptaculous/unit/index.html",
    "test/regression/scriptaculous/unit/loading_test.html",
    "test/regression/scriptaculous/unit/position_clone_test.html",
    "test/regression/scriptaculous/unit/slider_test.html",
    "test/regression/scriptaculous/unit/sortable_test.html",
    "test/regression/scriptaculous/unit/string_test.html",
    "test/regression/scriptaculous/unit/unittest_test.html",
    "test/regression/scriptaculous/upstream",
    "test/test_helper.rb",
    "test/unit/runner_test.rb",
    "test/unit/test_case_test.rb",
    "test/unit/test_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/Fingertips/headless-squirrel/tree/master}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A command-line JavaScript test runner for the Mac.}
  s.test_files = [
    "test/regression/scriptaculous/unit/assets/javascripttest.rb",
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
