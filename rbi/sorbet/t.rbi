# typed: __STDLIB_INTERNAL
module T::Sig
  # We could provide a more-complete signature, but these are already
  # parsed in C++, so there's no need to emit errors twice.

  sig do
    params(
      blk: T.proc.bind(T::Private::Methods::DeclBuilder).void
    )
    .returns(T::Private::Methods::DeclarationBlock)
  end
  def sig(&blk); end
end
module T::Sig::WithoutRuntime
  # At runtime, does nothing, but statically it is treated exactly the same
  # as T::Sig#sig. Only use it in cases where you can't use T::Sig#sig.
  sig do
    params(
      blk: T.proc.bind(T::Private::Methods::DeclBuilder).void
    )
    .returns(T::Private::Methods::DeclarationBlock)
  end
  def self.sig(&blk); end
end

module T
  extend T::Sig

  sig {params(value: T.untyped).returns(T.untyped)}
  def self.unsafe(value); end

  # These are implemented in C++ when they appear in type context; We
  # implement them here in Ruby so they also exist if they are called
  # in value context. Several of these methods additionally have a C++
  # implementation filled in value context; In that case the prototype
  # here still applies, but additional checking and/or analysis is
  # performed in C++ for that method.

  sig {params(value: T.untyped, type: T.untyped, checked: T::Boolean).returns(BasicObject)}
  def self.let(value, type, checked: true); end

  sig {params(value: T.untyped, type: T.untyped, checked: T::Boolean).returns(BasicObject)}
  def self.assert_type!(value, type, checked: true); end

  sig {params(value: T.untyped, type: T.untyped, checked: T::Boolean).returns(BasicObject)}
  def self.cast(value, type, checked: true); end

  sig {params(type: T.untyped).returns(BasicObject)}
  def self.nilable(type); end

  sig {returns(T::Private::Methods::DeclBuilder)}
  def self.proc; end

  def self.class_of(klass); end
  def self.noreturn; end
  def self.enum(values); end
  def self.untyped; end

  sig {params(type_a: T.untyped, type_b: T.untyped, types: T.untyped).returns(BasicObject)}
  def self.any(type_a, type_b, *types); end

  sig {params(type_a: T.untyped, type_b: T.untyped, types: T.untyped).returns(BasicObject)}
  def self.all(type_a, type_b, *types); end

  def self.reveal_type(value); end
  def self.type_parameter(name); end
  def self.self_type; end
  def self.type_alias(type); end

  sig {params(arg: T.untyped).returns(T.untyped)}
  def self.must(arg); end

  def self.coerce(type); end
end

module T::Generic
  include T::Helpers

  sig {params(params: T.untyped).returns(T::Private::Methods::DeclBuilder)}
  def type_parameters(*params); end

  def type_member(variance=:invariant, fixed: nil); end
  def type_template(variance=:invariant, fixed: nil); end
  def [](*types); end
end

module T::Helpers
  def abstract!;  end
  def interface!; end
  def mixes_in_class_methods(mod); end
end

module T::Array
  def self.[](type); end
end
module T::Hash
  def self.[](keys, values); end
end
module T::Set
  def self.[](type); end
end
module T::Range
  def self.[](type); end
end
module T::Enumerable
  def self.[](type); end
end
module T::Enumerator
  def self.[](type); end
end

module T::CFGExport
end

class T::InexactStruct
  def initialize(rules={}); end
  def prop(name, type, rules={}); end
  def const(name, type, rules={}); end
end
class T::Struct < T::InexactStruct; end

T::Boolean = T.type_alias(T.any(TrueClass, FalseClass))
