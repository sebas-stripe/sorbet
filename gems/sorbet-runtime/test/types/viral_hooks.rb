# frozen_string_literal: true
require_relative '../test_helper'

class Opus::Types::Test::ViralHooksTest < Critic::Unit::UnitTest
  it "gives the hooks to a class which includes a module with hooks" do
    m = Module.new do
      extend T::Sig
      sig {void}
      def foo; end
    end
    assert_equal(true, T::Private::Methods.instance_variable_get(:@installed_hooks).include?(m))
    c = Class.new do
      include m
    end
    assert_equal(true, T::Private::Methods.instance_variable_get(:@installed_hooks).include?(c))
  end

  it "gives the hooks to a class which extends a module with hooks" do
    m = Module.new do
      extend T::Sig
      sig {void}
      def foo; end
    end
    assert_equal(true, T::Private::Methods.instance_variable_get(:@installed_hooks).include?(m))
    c = Class.new do
      extend m
    end
    assert_equal(true, T::Private::Methods.instance_variable_get(:@installed_hooks).include?(c))
  end
end
