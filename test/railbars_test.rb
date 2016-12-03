require 'test_helper'
require 'action_view'

ActionView::Base.send :include, Railbars::ViewHelpers

class RailbarsTest < Minitest::Test
  def action_view
    ActionView::Base.new
  end

  def test_hb_as_block
    assert_equal "{{#block_helper up down strange=\"charm\"}}&lt;p&gt;content&lt;/p&gt;{{/block_helper}}", action_view.hb('block_helper', 'up', 'down', strange: 'charm') { '<p>content</p>' }
  end

  def test_hb_as_helper
    assert_equal "{{helper_name up down strange=\"charm\"}}", action_view.hb('helper_name', 'up', 'down', strange: 'charm')
  end

  def test_hb_as_expression
    assert_equal "{{value}}", action_view.hb('value')
  end

  def test_hbexp
    assert_equal "{{value}}", action_view.hbexp('value')
  end

  def test_hbblock
    assert_equal "{{#block_helper up down strange=\"charm\"}}&lt;p&gt;content&lt;/p&gt;{{/block_helper}}", action_view.hbblock('block_helper', 'up', 'down', strange: 'charm') { '<p>content</p>' }
  end

  def test_hbhelper
    assert_equal "{{helper_name up down strange=\"charm\"}}", action_view.hbhelper('helper_name', 'up', 'down', strange: 'charm')
  end

  def test_hbunescape
    assert_equal "{{{value}}}", action_view.hbunescape('value')
  end

  def test_hbpartial
    assert_equal "{{> partial_name up down strange=\"charm\" }}", action_view.hbpartial('partial_name', 'up', 'down', strange: 'charm')
  end

  def test_hbeach
    assert_equal "{{#each item}}&lt;li&gt;value&lt;/li&gt;{{/each}}", action_view.hbeach('item') { '<li>value</li>' }
  end

  def test_hbif
    assert_equal "{{#if condition}}&lt;p&gt;content&lt;/p&gt;{{/if}}", action_view.hbif('condition') { '<p>content</p>' }
  end

  def test_hbelse
    assert_equal "{{else}}", action_view.hbelse
  end

  def test_hbparams_with_list
    assert_equal "up down strange charm", action_view.hbparams('up', 'down', 'strange', 'charm')
  end

  def test_hbparams_with_hash
    assert_equal "up=\"down\" strange=\"charm\"", action_view.hbparams({up: 'down', strange: 'charm'})
  end

  def test_hbparams_with_list_and_hash
    assert_equal "up down strange charm foo=1 bar=3", action_view.hbparams('up', 'down', 'strange', 'charm', {foo: 1, bar: 3})
  end

  def test_translate_values_with_nothing
    assert_nil action_view.translate_values([])
  end

  def test_translate_values_with_values
    assert_equal "up down strange charm", action_view.translate_values(['up', 'down', 'strange', 'charm'])
  end

  def test_translate_hash_with_nothing
    assert_nil action_view.translate_hash({})
  end

  def test_translate_hash_with_strings
    assert_equal "up=\"down\" strange=\"charm\"", action_view.translate_hash({up: 'down', strange: 'charm'})
  end

  def test_translate_hash_with_numbers
    assert_equal "foo=1 bar=3", action_view.translate_hash({foo: 1, bar: 3})
  end
end
