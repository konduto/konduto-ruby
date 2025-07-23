# frozen_string_literal: true

require 'minitest/autorun'
require 'factory_girl'

class KondutoUtilsTest < MiniTest::Test
  include FactoryGirl::Syntax::Methods

  def test_parameterize_key_with_single_word
    assert_equal 'classe', KondutoUtils.parameterize_key('Classe')
  end

  def test_parameterize_key_with_pascal_case
    assert_equal 'some_classe', KondutoUtils.parameterize_key('SomeClasse')
  end

  def test_parameterize_key_with_camel_case
    assert_equal 'some_classe_name', KondutoUtils.parameterize_key('someClasseName')
  end

  def test_parameterize_key_with_long_pascal_case
    assert_equal 'another_classe_with_a_long_name', KondutoUtils.parameterize_key('AnotherClasseWithALongName')
  end

  def test_parameterize_key_with_acronym
    assert_equal 'http_request_handler', KondutoUtils.parameterize_key('HTTPRequestHandler')
  end

  def test_parameterize_key_with_symbol
    assert_equal 'some_key', KondutoUtils.parameterize_key(:SomeKey)
  end

  def test_parameterize_key_with_snake_case
    assert_equal 'already_snake_case', KondutoUtils.parameterize_key('already_snake_case')
  end

  def test_parameterize_key_with_empty_string
    assert_equal '', KondutoUtils.parameterize_key('')
  end

  def test_parameterize_key_with_numbers
    assert_equal 'version2_controller', KondutoUtils.parameterize_key('Version2Controller')
  end
end
