require File.dirname(__FILE__) + '/common'
require File.dirname(__FILE__) + '/../lib/rdio'

class TestSearch < Test::Unit::TestCase

  def test_add_to_array
    assert_equal ['1'],Rdio::add_to_array(nil,'1')
    assert_equal ['1'],Rdio::add_to_array('','1')
    assert_equal '2,1',Rdio::add_to_array('2','1')
    assert_equal ['1'],Rdio::add_to_array([],'1')
    assert_equal ['2','1'],Rdio::add_to_array(['2'],'1')
    assert_equal ['1'],Rdio::add_to_array(nil,1)
    assert_equal ['1'],Rdio::add_to_array('',1)
    assert_equal '2,1',Rdio::add_to_array('2',1)
    assert_equal ['1'],Rdio::add_to_array([],1)
    assert_equal ['2','1'],Rdio::add_to_array(['2'],1)
  end

  def test_camel2underscores
    assert_equal nil,Rdio::camel2underscores(nil)
    assert_equal '',Rdio::camel2underscores('')
    assert_equal 'a',Rdio::camel2underscores('a')
    assert_equal 'a',Rdio::camel2underscores('A')
    assert_equal 'ab',Rdio::camel2underscores('Ab')
    assert_equal 'a_b',Rdio::camel2underscores('AB')
    assert_equal 'abc',Rdio::camel2underscores('Abc')
    assert_equal 'ab_c',Rdio::camel2underscores('AbC')
    assert_equal 'a_b_c',Rdio::camel2underscores('ABC')
    assert_equal 'a_b_cde',Rdio::camel2underscores('ABCde')
    assert_equal 'get_tracks_for_artist_in_collection',
      Rdio::camel2underscores('getTracksForArtistInCollection')
  end

  class C
    def to_s
      nil
    end
  end

  def test_to_o
    assert_equal nil,Rdio::to_o(nil)
    assert_equal nil,Rdio::to_o(C.new)
    assert_equal nil,Rdio::to_o('nil')
    assert_equal 123,Rdio::to_o(123)
    assert_equal 123,Rdio::to_o('123')
    assert_equal 123.456,Rdio::to_o(123.456)
    assert_equal 123.456,Rdio::to_o('123.456')
    assert_equal true,Rdio::to_o(true)
    assert_equal true,Rdio::to_o('true')
    assert_equal false,Rdio::to_o(false)
    assert_equal false,Rdio::to_o('false')
    assert_equal [],Rdio::to_o('[]')
    assert_equal [1,2,3],Rdio::to_o('[1,2,3]')
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
    assert_equal '',Rdio::keys(nil)
    assert_equal '',Rdio::keys([])
    assert_equal '1',Rdio::keys([1])
    assert_equal '1,2',Rdio::keys([1,2])
    assert_equal 'k',Rdio::keys([K.new])
    assert_equal 'k,k',Rdio::keys([K.new,K.new])
    assert_equal 'K',Rdio::keys([K])
    assert_equal 'K,K',Rdio::keys([K,K])
    assert_equal '',Rdio::keys([nil])
    assert_equal '',Rdio::keys([nil,nil])
  end

  def test_convert_args
    assert_equal nil,Rdio::convert_args(nil)
    assert_equal ({}),Rdio::convert_args({})
    assert_equal ({:one=>1}),Rdio::convert_args({:one=>1})
    assert_equal ({:one=>'k'}),Rdio::convert_args({:one=>K.new})
    assert_equal ({:one=>'k'}),Rdio::convert_args({:one=>[K.new]})
    assert_equal ({:one=>'k,k'}),Rdio::convert_args({:one=>[K.new,K.new]})
  end

end
