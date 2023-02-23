final: prev: {
  haskell-nix = prev.haskell-nix // {
      compiler = __mapAttrs (_: ghc: ghc // {
        cachedDeps = final.haskell-nix.haskellLib.makeCompilerDeps ghc;
    }) prev.haskell-nix.compiler;
  };
  haskell = prev.haskell // {
      compiler = __mapAttrs (_: ghc: ghc // {
        cachedDeps = final.haskell-nix.haskellLib.makeCompilerDeps ghc;
    }) prev.haskell.compiler;
  };
}
