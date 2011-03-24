require File.dirname(__FILE__) + '/common'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestSearch < Test::Unit::TestCase

  def test_add_to_array
    assert_equal ['1'],add_to_array(nil,'1')
    assert_equal ['1'],add_to_array('','1')
    assert_equal '2,1',add_to_array('2','1')
    assert_equal ['1'],add_to_array([],'1')
    assert_equal ['2','1'],add_to_array(['2'],'1')
    assert_equal ['1'],add_to_array(nil,1)
    assert_equal ['1'],add_to_array('',1)
    assert_equal '2,1',add_to_array('2',1)
    assert_equal ['1'],add_to_array([],1)
    assert_equal ['2','1'],add_to_array(['2'],1)
  end

  def test_camel2underscores
    assert_equal nil,camel2underscores(nil)
    assert_equal '',camel2underscores('')
    assert_equal 'a',camel2underscores('a')
    assert_equal 'a',camel2underscores('A')
    assert_equal 'ab',camel2underscores('Ab')
    assert_equal 'a_b',camel2underscores('AB')
    assert_equal 'abc',camel2underscores('Abc')
    assert_equal 'ab_c',camel2underscores('AbC')
    assert_equal 'a_b_c',camel2underscores('ABC')
    assert_equal 'a_b_cde',camel2underscores('ABCde')
    assert_equal 'get_tracks_for_artist_in_collection',
      camel2underscores('getTracksForArtistInCollection')
  end

  class C
    def to_s
      nil
    end
  end

  def test_to_o
    assert_equal nil,to_o(nil)
    assert_equal nil,to_o(C.new)
    assert_equal nil,to_o('nil')
    assert_equal 123,to_o(123)
    assert_equal 123,to_o('123')
    assert_equal 123.456,to_o(123.456)
    assert_equal 123.456,to_o('123.456')
    assert_equal true,to_o(true)
    assert_equal true,to_o('true')
    assert_equal false,to_o(false)
    assert_equal false,to_o('false')
    assert_equal [],to_o('[]')
    assert_equal [1,2,3],to_o('[1,2,3]')
  end

  class K
    def to_k
      'k'
    end
  end

  def test_to_k
    assert_equal nil,nil.to_k
    assert_equal 's','s'.to_k
    assert_equal 'k',K.new.to_k
    assert_equal 'K',K.to_k
  end

  def test_keys
    assert_equal '',keys(nil)
    assert_equal '',keys([])
    assert_equal '1',keys([1])
    assert_equal '1,2',keys([1,2])
    assert_equal 'k',keys([K.new])
    assert_equal 'k,k',keys([K.new,K.new])
    assert_equal 'K',keys([K])
    assert_equal 'K,K',keys([K,K])
    assert_equal '',keys([nil])
    assert_equal '',keys([nil,nil])
  end

  def test_convert_args
    assert_equal nil,convert_args(nil)
    assert_equal ({}),convert_args({})
    assert_equal ({:one=>1}),convert_args({:one=>1})
    assert_equal ({:one=>'k'}),convert_args({:one=>K.new})
    assert_equal ({:one=>'k'}),convert_args({:one=>[K.new]})
    assert_equal ({:one=>'k,k'}),convert_args({:one=>[K.new,K.new]})
  end

end
