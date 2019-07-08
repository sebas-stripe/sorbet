# frozen_string_literal: true
# typed: strict

# Used as a mixin to any class so that you can call `sig`.
# Docs at https://sorbet.org/docs/sigs
module T::Sig
  module WithoutRuntime
    # At runtime, does nothing, but statically it is treated exactly the same
    # as T::Sig#sig. Only use it in cases where you can't use T::Sig#sig.
    def self.sig(&blk) # rubocop:disable PrisonGuard/BanBuiltinMethodOverride
      T::Private::Methods::DeclarationBlock.new(T.unsafe(nil), T.unsafe(nil), T.unsafe(nil))
    end

    # At runtime, does nothing, but statically it is treated exactly the same
    # as T::Sig#sig. Only use it in cases where you can't use T::Sig#sig.
    T::Sig::WithoutRuntime.sig do
      params(
        blk: T.proc.bind(T::Private::Methods::DeclBuilder).void
      )
      .returns(T::Private::Methods::DeclarationBlock)
    end
    def self.sig(&blk) # rubocop:disable PrisonGuard/BanBuiltinMethodOverride, Lint/DuplicateMethods
      T::Private::Methods::DeclarationBlock.new(T.unsafe(nil), T.unsafe(nil), T.unsafe(nil))
    end
  end

  # Declares a method with type signatures and/or
  # abstract/override/... helpers. See the documentation URL on
  # {T::Helpers}
  T::Sig::WithoutRuntime.sig do
    params(
      blk: T.proc.bind(T::Private::Methods::DeclBuilder).void
    )
    .returns(T::Private::Methods::DeclarationBlock)
  end
  def sig(&blk) # rubocop:disable PrisonGuard/BanBuiltinMethodOverride
    T::Private::Methods.declare_sig(self, &blk)
  end
end
