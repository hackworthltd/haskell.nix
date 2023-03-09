{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  {
    flags = {
      internal-interpreter = false;
      dynamic-system-linker = true;
      build-tool-depends = true;
      };
    package = {
      specVersion = "2.2";
      identifier = { name = "ghc"; version = "9.6.0.20230302"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "glasgow-haskell-users@haskell.org";
      author = "The GHC Team";
      homepage = "http://www.haskell.org/ghc/";
      url = "";
      synopsis = "The GHC API";
      description = "GHC's functionality can be useful for more things than just\ncompiling Haskell programs. Important use cases are programs\nthat analyse (and perhaps transform) Haskell code. Others\ninclude loading Haskell code dynamically in a GHCi-like manner.\nFor this reason, a lot of GHC's functionality is made available\nthrough this package.\n\nSee <https://gitlab.haskell.org/ghc/ghc/-/wikis/commentary/compiler>\nfor more information.";
      buildType = "Custom";
      isLocal = true;
      setup-depends = [
        (hsPkgs.buildPackages.base or (pkgs.buildPackages.base or (errorHandler.setupDepError "base")))
        (hsPkgs.buildPackages.Cabal or (pkgs.buildPackages.Cabal or (errorHandler.setupDepError "Cabal")))
        (hsPkgs.buildPackages.directory or (pkgs.buildPackages.directory or (errorHandler.setupDepError "directory")))
        (hsPkgs.buildPackages.process or (pkgs.buildPackages.process or (errorHandler.setupDepError "process")))
        (hsPkgs.buildPackages.filepath or (pkgs.buildPackages.filepath or (errorHandler.setupDepError "filepath")))
        ];
      detailLevel = "FullDetails";
      licenseFiles = [ "LICENSE" ];
      dataDir = ".";
      dataFiles = [];
      extraSrcFiles = [
        "GHC/Builtin/primops.txt.pp"
        "GHC/Builtin/bytearray-ops.txt.pp"
        "Unique.h"
        "CodeGen.Platform.h"
        "Bytecodes.h"
        "ClosureTypes.h"
        "FunTypes.h"
        "MachRegs.h"
        "ghc-llvm-version.h"
        ];
      extraTmpFiles = [];
      extraDocFiles = [];
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
          (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
          (hsPkgs."process" or (errorHandler.buildDepError "process"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."binary" or (errorHandler.buildDepError "binary"))
          (hsPkgs."time" or (errorHandler.buildDepError "time"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."array" or (errorHandler.buildDepError "array"))
          (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          (hsPkgs."hpc" or (errorHandler.buildDepError "hpc"))
          (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
          (hsPkgs."exceptions" or (errorHandler.buildDepError "exceptions"))
          (hsPkgs."stm" or (errorHandler.buildDepError "stm"))
          (hsPkgs."ghc-boot" or (errorHandler.buildDepError "ghc-boot"))
          (hsPkgs."ghc-heap" or (errorHandler.buildDepError "ghc-heap"))
          (hsPkgs."ghci" or (errorHandler.buildDepError "ghci"))
          ] ++ (if system.isWindows
          then [ (hsPkgs."Win32" or (errorHandler.buildDepError "Win32")) ]
          else [ (hsPkgs."unix" or (errorHandler.buildDepError "unix")) ]);
        build-tools = (pkgs.lib).optionals (flags.build-tool-depends) [
          (hsPkgs.buildPackages.alex.components.exes.alex or (pkgs.buildPackages.alex or (errorHandler.buildToolDepError "alex:alex")))
          (hsPkgs.buildPackages.happy.components.exes.happy or (pkgs.buildPackages.happy or (errorHandler.buildToolDepError "happy:happy")))
          (hsPkgs.buildPackages.genprimopcode.components.exes.genprimopcode or (pkgs.buildPackages.genprimopcode or (errorHandler.buildToolDepError "genprimopcode:genprimopcode")))
          (hsPkgs.buildPackages.deriveConstants.components.exes.deriveConstants or (pkgs.buildPackages.deriveConstants or (errorHandler.buildToolDepError "deriveConstants:deriveConstants")))
          ];
        buildable = true;
        modules = [
          "GHC"
          "GHC/Builtin/Names"
          "GHC/Builtin/Names/TH"
          "GHC/Builtin/PrimOps"
          "GHC/Builtin/PrimOps/Casts"
          "GHC/Builtin/PrimOps/Ids"
          "GHC/Builtin/Types"
          "GHC/Builtin/Types/Literals"
          "GHC/Builtin/Types/Prim"
          "GHC/Builtin/Uniques"
          "GHC/Builtin/Utils"
          "GHC/ByteCode/Asm"
          "GHC/ByteCode/InfoTable"
          "GHC/ByteCode/Instr"
          "GHC/ByteCode/Linker"
          "GHC/ByteCode/Types"
          "GHC/Cmm"
          "GHC/Cmm/BlockId"
          "GHC/Cmm/CallConv"
          "GHC/Cmm/CLabel"
          "GHC/Cmm/CommonBlockElim"
          "GHC/Cmm/Config"
          "GHC/Cmm/ContFlowOpt"
          "GHC/Cmm/Dataflow"
          "GHC/Cmm/Dataflow/Block"
          "GHC/Cmm/Dataflow/Collections"
          "GHC/Cmm/Dataflow/Graph"
          "GHC/Cmm/Dataflow/Label"
          "GHC/Cmm/DebugBlock"
          "GHC/Cmm/Expr"
          "GHC/Cmm/Graph"
          "GHC/Cmm/Info"
          "GHC/Cmm/Info/Build"
          "GHC/Cmm/InitFini"
          "GHC/Cmm/LayoutStack"
          "GHC/Cmm/Lexer"
          "GHC/Cmm/Lint"
          "GHC/Cmm/Liveness"
          "GHC/Cmm/MachOp"
          "GHC/Cmm/Node"
          "GHC/Cmm/Opt"
          "GHC/Cmm/Parser"
          "GHC/Cmm/Parser/Config"
          "GHC/Cmm/Parser/Monad"
          "GHC/Cmm/Pipeline"
          "GHC/Cmm/ProcPoint"
          "GHC/Cmm/Reg"
          "GHC/Cmm/Sink"
          "GHC/Cmm/Switch"
          "GHC/Cmm/Switch/Implement"
          "GHC/Cmm/ThreadSanitizer"
          "GHC/CmmToAsm"
          "GHC/Cmm/LRegSet"
          "GHC/CmmToAsm/AArch64"
          "GHC/CmmToAsm/AArch64/CodeGen"
          "GHC/CmmToAsm/AArch64/Cond"
          "GHC/CmmToAsm/AArch64/Instr"
          "GHC/CmmToAsm/AArch64/Ppr"
          "GHC/CmmToAsm/AArch64/RegInfo"
          "GHC/CmmToAsm/AArch64/Regs"
          "GHC/CmmToAsm/BlockLayout"
          "GHC/CmmToAsm/CFG"
          "GHC/CmmToAsm/CFG/Dominators"
          "GHC/CmmToAsm/CFG/Weight"
          "GHC/CmmToAsm/Config"
          "GHC/CmmToAsm/CPrim"
          "GHC/CmmToAsm/Dwarf"
          "GHC/CmmToAsm/Dwarf/Constants"
          "GHC/CmmToAsm/Dwarf/Types"
          "GHC/CmmToAsm/Format"
          "GHC/CmmToAsm/Instr"
          "GHC/CmmToAsm/Monad"
          "GHC/CmmToAsm/PIC"
          "GHC/CmmToAsm/PPC"
          "GHC/CmmToAsm/PPC/CodeGen"
          "GHC/CmmToAsm/PPC/Cond"
          "GHC/CmmToAsm/PPC/Instr"
          "GHC/CmmToAsm/PPC/Ppr"
          "GHC/CmmToAsm/PPC/RegInfo"
          "GHC/CmmToAsm/PPC/Regs"
          "GHC/CmmToAsm/Ppr"
          "GHC/CmmToAsm/Reg/Graph"
          "GHC/CmmToAsm/Reg/Graph/Base"
          "GHC/CmmToAsm/Reg/Graph/Coalesce"
          "GHC/CmmToAsm/Reg/Graph/Spill"
          "GHC/CmmToAsm/Reg/Graph/SpillClean"
          "GHC/CmmToAsm/Reg/Graph/SpillCost"
          "GHC/CmmToAsm/Reg/Graph/Stats"
          "GHC/CmmToAsm/Reg/Graph/TrivColorable"
          "GHC/CmmToAsm/Reg/Graph/X86"
          "GHC/CmmToAsm/Reg/Linear"
          "GHC/CmmToAsm/Reg/Linear/AArch64"
          "GHC/CmmToAsm/Reg/Linear/Base"
          "GHC/CmmToAsm/Reg/Linear/FreeRegs"
          "GHC/CmmToAsm/Reg/Linear/JoinToTargets"
          "GHC/CmmToAsm/Reg/Linear/PPC"
          "GHC/CmmToAsm/Reg/Linear/StackMap"
          "GHC/CmmToAsm/Reg/Linear/State"
          "GHC/CmmToAsm/Reg/Linear/Stats"
          "GHC/CmmToAsm/Reg/Linear/X86"
          "GHC/CmmToAsm/Reg/Linear/X86_64"
          "GHC/CmmToAsm/Reg/Liveness"
          "GHC/CmmToAsm/Reg/Target"
          "GHC/CmmToAsm/Reg/Utils"
          "GHC/CmmToAsm/Types"
          "GHC/CmmToAsm/Utils"
          "GHC/CmmToAsm/X86"
          "GHC/CmmToAsm/X86/CodeGen"
          "GHC/CmmToAsm/X86/Cond"
          "GHC/CmmToAsm/X86/Instr"
          "GHC/CmmToAsm/X86/Ppr"
          "GHC/CmmToAsm/X86/RegInfo"
          "GHC/CmmToAsm/X86/Regs"
          "GHC/CmmToC"
          "GHC/CmmToLlvm"
          "GHC/CmmToLlvm/Base"
          "GHC/CmmToLlvm/CodeGen"
          "GHC/CmmToLlvm/Config"
          "GHC/CmmToLlvm/Data"
          "GHC/CmmToLlvm/Mangler"
          "GHC/CmmToLlvm/Ppr"
          "GHC/CmmToLlvm/Regs"
          "GHC/Cmm/Dominators"
          "GHC/Cmm/Reducibility"
          "GHC/Cmm/Type"
          "GHC/Cmm/Utils"
          "GHC/Core"
          "GHC/Core/Class"
          "GHC/Core/Coercion"
          "GHC/Core/Coercion/Axiom"
          "GHC/Core/Coercion/Opt"
          "GHC/Core/ConLike"
          "GHC/Core/DataCon"
          "GHC/Core/FamInstEnv"
          "GHC/Core/FVs"
          "GHC/Core/InstEnv"
          "GHC/Core/Lint"
          "GHC/Core/Lint/Interactive"
          "GHC/Core/LateCC"
          "GHC/Core/Make"
          "GHC/Core/Map/Expr"
          "GHC/Core/Map/Type"
          "GHC/Core/Multiplicity"
          "GHC/Core/Opt/Arity"
          "GHC/Core/Opt/CallArity"
          "GHC/Core/Opt/CallerCC"
          "GHC/Core/Opt/ConstantFold"
          "GHC/Core/Opt/CprAnal"
          "GHC/Core/Opt/CSE"
          "GHC/Core/Opt/DmdAnal"
          "GHC/Core/Opt/Exitify"
          "GHC/Core/Opt/FloatIn"
          "GHC/Core/Opt/FloatOut"
          "GHC/Core/Opt/LiberateCase"
          "GHC/Core/Opt/Monad"
          "GHC/Core/Opt/OccurAnal"
          "GHC/Core/Opt/Pipeline"
          "GHC/Core/Opt/Pipeline/Types"
          "GHC/Core/Opt/SetLevels"
          "GHC/Core/Opt/Simplify"
          "GHC/Core/Opt/Simplify/Env"
          "GHC/Core/Opt/Simplify/Iteration"
          "GHC/Core/Opt/Simplify/Monad"
          "GHC/Core/Opt/Simplify/Utils"
          "GHC/Core/Opt/SpecConstr"
          "GHC/Core/Opt/Specialise"
          "GHC/Core/Opt/StaticArgs"
          "GHC/Core/Opt/Stats"
          "GHC/Core/Opt/WorkWrap"
          "GHC/Core/Opt/WorkWrap/Utils"
          "GHC/Core/PatSyn"
          "GHC/Core/Ppr"
          "GHC/Types/TyThing/Ppr"
          "GHC/Core/Predicate"
          "GHC/Core/Reduction"
          "GHC/Core/Rules"
          "GHC/Core/Rules/Config"
          "GHC/Core/Seq"
          "GHC/Core/SimpleOpt"
          "GHC/Core/Stats"
          "GHC/Core/Subst"
          "GHC/Core/Tidy"
          "GHC/CoreToIface"
          "GHC/CoreToStg"
          "GHC/CoreToStg/Prep"
          "GHC/Core/TyCo/FVs"
          "GHC/Core/TyCo/Compare"
          "GHC/Core/TyCon"
          "GHC/Core/TyCon/Env"
          "GHC/Core/TyCon/RecWalk"
          "GHC/Core/TyCon/Set"
          "GHC/Core/TyCo/Ppr"
          "GHC/Core/TyCo/Rep"
          "GHC/Core/TyCo/Subst"
          "GHC/Core/TyCo/Tidy"
          "GHC/Core/Type"
          "GHC/Core/RoughMap"
          "GHC/Core/Unfold"
          "GHC/Core/Unfold/Make"
          "GHC/Core/Unify"
          "GHC/Core/UsageEnv"
          "GHC/Core/Utils"
          "GHC/Data/Bag"
          "GHC/Data/Bitmap"
          "GHC/Data/Bool"
          "GHC/Data/BooleanFormula"
          "GHC/Data/EnumSet"
          "GHC/Data/FastMutInt"
          "GHC/Data/FastString"
          "GHC/Data/FastString/Env"
          "GHC/Data/FiniteMap"
          "GHC/Data/Graph/Base"
          "GHC/Data/Graph/Color"
          "GHC/Data/Graph/Collapse"
          "GHC/Data/Graph/Directed"
          "GHC/Data/Graph/Inductive/Graph"
          "GHC/Data/Graph/Inductive/PatriciaTree"
          "GHC/Data/Graph/Ops"
          "GHC/Data/Graph/Ppr"
          "GHC/Data/Graph/UnVar"
          "GHC/Data/IOEnv"
          "GHC/Data/List/Infinite"
          "GHC/Data/List/SetOps"
          "GHC/Data/Maybe"
          "GHC/Data/OrdList"
          "GHC/Data/Pair"
          "GHC/Data/SmallArray"
          "GHC/Data/Stream"
          "GHC/Data/Strict"
          "GHC/Data/StringBuffer"
          "GHC/Data/TrieMap"
          "GHC/Data/Unboxed"
          "GHC/Data/UnionFind"
          "GHC/Driver/Backend"
          "GHC/Driver/Backend/Internal"
          "GHC/Driver/Backpack"
          "GHC/Driver/Backpack/Syntax"
          "GHC/Driver/CmdLine"
          "GHC/Driver/CodeOutput"
          "GHC/Driver/Config"
          "GHC/Driver/Config/Cmm"
          "GHC/Driver/Config/Cmm/Parser"
          "GHC/Driver/Config/CmmToAsm"
          "GHC/Driver/Config/CmmToLlvm"
          "GHC/Driver/Config/Core/Lint"
          "GHC/Driver/Config/Core/Lint/Interactive"
          "GHC/Driver/Config/Core/Opt/Arity"
          "GHC/Driver/Config/Core/Opt/LiberateCase"
          "GHC/Driver/Config/Core/Opt/Simplify"
          "GHC/Driver/Config/Core/Opt/WorkWrap"
          "GHC/Driver/Config/Core/Rules"
          "GHC/Driver/Config/CoreToStg"
          "GHC/Driver/Config/CoreToStg/Prep"
          "GHC/Driver/Config/Diagnostic"
          "GHC/Driver/Config/Finder"
          "GHC/Driver/Config/HsToCore"
          "GHC/Driver/Config/HsToCore/Ticks"
          "GHC/Driver/Config/HsToCore/Usage"
          "GHC/Driver/Config/Linker"
          "GHC/Driver/Config/Logger"
          "GHC/Driver/Config/Parser"
          "GHC/Driver/Config/Stg/Debug"
          "GHC/Driver/Config/Stg/Lift"
          "GHC/Driver/Config/Stg/Pipeline"
          "GHC/Driver/Config/Stg/Ppr"
          "GHC/Driver/Config/StgToCmm"
          "GHC/Driver/Config/Tidy"
          "GHC/Driver/Config/StgToJS"
          "GHC/Driver/Env"
          "GHC/Driver/Env/KnotVars"
          "GHC/Driver/Env/Types"
          "GHC/Driver/Errors"
          "GHC/Driver/Errors/Ppr"
          "GHC/Driver/Errors/Types"
          "GHC/Driver/Flags"
          "GHC/Driver/GenerateCgIPEStub"
          "GHC/Driver/Hooks"
          "GHC/Driver/LlvmConfigCache"
          "GHC/Driver/Main"
          "GHC/Driver/Make"
          "GHC/Driver/MakeFile"
          "GHC/Driver/Monad"
          "GHC/Driver/Phases"
          "GHC/Driver/Pipeline"
          "GHC/Driver/Pipeline/Execute"
          "GHC/Driver/Pipeline/LogQueue"
          "GHC/Driver/Pipeline/Phases"
          "GHC/Driver/Pipeline/Monad"
          "GHC/Driver/Plugins"
          "GHC/Driver/Plugins/External"
          "GHC/Driver/Ppr"
          "GHC/Driver/Session"
          "GHC/Hs"
          "GHC/Hs/Binds"
          "GHC/Hs/Decls"
          "GHC/Hs/Doc"
          "GHC/Hs/DocString"
          "GHC/Hs/Dump"
          "GHC/Hs/Expr"
          "GHC/Hs/Syn/Type"
          "GHC/Hs/Extension"
          "GHC/Hs/ImpExp"
          "GHC/Hs/Instances"
          "GHC/Hs/Lit"
          "GHC/Hs/Pat"
          "GHC/Hs/Stats"
          "GHC/HsToCore"
          "GHC/HsToCore/Arrows"
          "GHC/HsToCore/Binds"
          "GHC/HsToCore/Breakpoints"
          "GHC/HsToCore/Coverage"
          "GHC/HsToCore/Docs"
          "GHC/HsToCore/Errors/Ppr"
          "GHC/HsToCore/Errors/Types"
          "GHC/HsToCore/Expr"
          "GHC/HsToCore/Foreign/C"
          "GHC/HsToCore/Foreign/Call"
          "GHC/HsToCore/Foreign/Decl"
          "GHC/HsToCore/Foreign/JavaScript"
          "GHC/HsToCore/Foreign/Prim"
          "GHC/HsToCore/Foreign/Utils"
          "GHC/HsToCore/GuardedRHSs"
          "GHC/HsToCore/ListComp"
          "GHC/HsToCore/Match"
          "GHC/HsToCore/Match/Constructor"
          "GHC/HsToCore/Match/Literal"
          "GHC/HsToCore/Monad"
          "GHC/HsToCore/Pmc"
          "GHC/HsToCore/Pmc/Check"
          "GHC/HsToCore/Pmc/Desugar"
          "GHC/HsToCore/Pmc/Ppr"
          "GHC/HsToCore/Pmc/Solver"
          "GHC/HsToCore/Pmc/Solver/Types"
          "GHC/HsToCore/Pmc/Types"
          "GHC/HsToCore/Pmc/Utils"
          "GHC/HsToCore/Quote"
          "GHC/HsToCore/Ticks"
          "GHC/HsToCore/Types"
          "GHC/HsToCore/Usage"
          "GHC/HsToCore/Utils"
          "GHC/Hs/Type"
          "GHC/Hs/Utils"
          "GHC/Iface/Binary"
          "GHC/Iface/Env"
          "GHC/Iface/Errors"
          "GHC/Iface/Ext/Ast"
          "GHC/Iface/Ext/Binary"
          "GHC/Iface/Ext/Debug"
          "GHC/Iface/Ext/Fields"
          "GHC/Iface/Ext/Types"
          "GHC/Iface/Ext/Utils"
          "GHC/Iface/Load"
          "GHC/Iface/Make"
          "GHC/Iface/Recomp"
          "GHC/Iface/Recomp/Binary"
          "GHC/Iface/Recomp/Flags"
          "GHC/Iface/Rename"
          "GHC/Iface/Syntax"
          "GHC/Iface/Tidy"
          "GHC/Iface/Tidy/StaticPtrTable"
          "GHC/IfaceToCore"
          "GHC/Iface/Type"
          "GHC/JS/Make"
          "GHC/JS/Ppr"
          "GHC/JS/Syntax"
          "GHC/JS/Transform"
          "GHC/Linker"
          "GHC/Linker/Config"
          "GHC/Linker/Dynamic"
          "GHC/Linker/ExtraObj"
          "GHC/Linker/Loader"
          "GHC/Linker/MacOS"
          "GHC/Linker/Static"
          "GHC/Linker/Static/Utils"
          "GHC/Linker/Types"
          "GHC/Linker/Unit"
          "GHC/Linker/Windows"
          "GHC/Llvm"
          "GHC/Llvm/MetaData"
          "GHC/Llvm/Ppr"
          "GHC/Llvm/Syntax"
          "GHC/Llvm/Types"
          "GHC/Parser"
          "GHC/Parser/Annotation"
          "GHC/Parser/CharClass"
          "GHC/Parser/Errors/Basic"
          "GHC/Parser/Errors/Ppr"
          "GHC/Parser/Errors/Types"
          "GHC/Parser/Header"
          "GHC/Parser/Lexer"
          "GHC/Parser/HaddockLex"
          "GHC/Parser/PostProcess"
          "GHC/Parser/PostProcess/Haddock"
          "GHC/Parser/Types"
          "GHC/Parser/Utils"
          "GHC/Platform"
          "GHC/Platform/ARM"
          "GHC/Platform/AArch64"
          "GHC/Platform/Constants"
          "GHC/Platform/NoRegs"
          "GHC/Platform/PPC"
          "GHC/Platform/Profile"
          "GHC/Platform/Reg"
          "GHC/Platform/Reg/Class"
          "GHC/Platform/Regs"
          "GHC/Platform/RISCV64"
          "GHC/Platform/LoongArch64"
          "GHC/Platform/S390X"
          "GHC/Platform/Wasm32"
          "GHC/Platform/Ways"
          "GHC/Platform/X86"
          "GHC/Platform/X86_64"
          "GHC/Plugins"
          "GHC/Prelude"
          "GHC/Prelude/Basic"
          "GHC/Rename/Bind"
          "GHC/Rename/Doc"
          "GHC/Rename/Env"
          "GHC/Rename/Expr"
          "GHC/Rename/Fixity"
          "GHC/Rename/HsType"
          "GHC/Rename/Module"
          "GHC/Rename/Names"
          "GHC/Rename/Pat"
          "GHC/Rename/Splice"
          "GHC/Rename/Unbound"
          "GHC/Rename/Utils"
          "GHC/Runtime/Context"
          "GHC/Runtime/Debugger"
          "GHC/Runtime/Eval"
          "GHC/Runtime/Eval/Types"
          "GHC/Runtime/Heap/Inspect"
          "GHC/Runtime/Heap/Layout"
          "GHC/Runtime/Interpreter"
          "GHC/Runtime/Interpreter/Types"
          "GHC/Runtime/Loader"
          "GHC/Settings"
          "GHC/Settings/Config"
          "GHC/Settings/Constants"
          "GHC/Settings/IO"
          "GHC/Stg/BcPrep"
          "GHC/Stg/CSE"
          "GHC/Stg/Debug"
          "GHC/Stg/FVs"
          "GHC/Stg/Lift"
          "GHC/Stg/Lift/Analysis"
          "GHC/Stg/Lift/Config"
          "GHC/Stg/Lift/Monad"
          "GHC/Stg/Lint"
          "GHC/Stg/InferTags"
          "GHC/Stg/InferTags/Rewrite"
          "GHC/Stg/InferTags/TagSig"
          "GHC/Stg/InferTags/Types"
          "GHC/Stg/Pipeline"
          "GHC/Stg/Stats"
          "GHC/Stg/Subst"
          "GHC/Stg/Syntax"
          "GHC/Stg/Utils"
          "GHC/StgToByteCode"
          "GHC/StgToCmm"
          "GHC/StgToCmm/ArgRep"
          "GHC/StgToCmm/Bind"
          "GHC/StgToCmm/CgUtils"
          "GHC/StgToCmm/Closure"
          "GHC/StgToCmm/Config"
          "GHC/StgToCmm/DataCon"
          "GHC/StgToCmm/Env"
          "GHC/StgToCmm/Expr"
          "GHC/StgToCmm/ExtCode"
          "GHC/StgToCmm/Foreign"
          "GHC/StgToCmm/Heap"
          "GHC/StgToCmm/Hpc"
          "GHC/StgToCmm/InfoTableProv"
          "GHC/StgToCmm/Layout"
          "GHC/StgToCmm/Lit"
          "GHC/StgToCmm/Monad"
          "GHC/StgToCmm/Prim"
          "GHC/StgToCmm/Prof"
          "GHC/StgToCmm/Sequel"
          "GHC/StgToCmm/TagCheck"
          "GHC/StgToCmm/Ticky"
          "GHC/StgToCmm/Types"
          "GHC/StgToCmm/Utils"
          "GHC/StgToJS"
          "GHC/StgToJS/Apply"
          "GHC/StgToJS/Arg"
          "GHC/StgToJS/Closure"
          "GHC/StgToJS/CodeGen"
          "GHC/StgToJS/CoreUtils"
          "GHC/StgToJS/DataCon"
          "GHC/StgToJS/Deps"
          "GHC/StgToJS/Expr"
          "GHC/StgToJS/ExprCtx"
          "GHC/StgToJS/FFI"
          "GHC/StgToJS/Heap"
          "GHC/StgToJS/Ids"
          "GHC/StgToJS/Literal"
          "GHC/StgToJS/Monad"
          "GHC/StgToJS/Object"
          "GHC/StgToJS/Prim"
          "GHC/StgToJS/Profiling"
          "GHC/StgToJS/Printer"
          "GHC/StgToJS/Regs"
          "GHC/StgToJS/Rts/Types"
          "GHC/StgToJS/Rts/Rts"
          "GHC/StgToJS/Sinker"
          "GHC/StgToJS/Stack"
          "GHC/StgToJS/StaticPtr"
          "GHC/StgToJS/StgUtils"
          "GHC/StgToJS/Symbols"
          "GHC/StgToJS/Types"
          "GHC/StgToJS/Utils"
          "GHC/StgToJS/Linker/Linker"
          "GHC/StgToJS/Linker/Types"
          "GHC/StgToJS/Linker/Utils"
          "GHC/Stg/Unarise"
          "GHC/SysTools"
          "GHC/SysTools/Ar"
          "GHC/SysTools/BaseDir"
          "GHC/SysTools/Cpp"
          "GHC/SysTools/Elf"
          "GHC/SysTools/Info"
          "GHC/SysTools/Process"
          "GHC/SysTools/Tasks"
          "GHC/SysTools/Terminal"
          "GHC/Tc/Deriv"
          "GHC/Tc/Deriv/Functor"
          "GHC/Tc/Deriv/Generate"
          "GHC/Tc/Deriv/Generics"
          "GHC/Tc/Deriv/Infer"
          "GHC/Tc/Deriv/Utils"
          "GHC/Tc/Errors"
          "GHC/Tc/Errors/Hole"
          "GHC/Tc/Errors/Hole/FitTypes"
          "GHC/Tc/Errors/Ppr"
          "GHC/Tc/Errors/Types"
          "GHC/Tc/Gen/Annotation"
          "GHC/Tc/Gen/App"
          "GHC/Tc/Gen/Arrow"
          "GHC/Tc/Gen/Bind"
          "GHC/Tc/Gen/Default"
          "GHC/Tc/Gen/Export"
          "GHC/Tc/Gen/Expr"
          "GHC/Tc/Gen/Foreign"
          "GHC/Tc/Gen/Head"
          "GHC/Tc/Gen/HsType"
          "GHC/Tc/Gen/Match"
          "GHC/Tc/Gen/Pat"
          "GHC/Tc/Gen/Rule"
          "GHC/Tc/Gen/Sig"
          "GHC/Tc/Gen/Splice"
          "GHC/Tc/Instance/Class"
          "GHC/Tc/Instance/Family"
          "GHC/Tc/Instance/FunDeps"
          "GHC/Tc/Instance/Typeable"
          "GHC/Tc/Module"
          "GHC/Tc/Plugin"
          "GHC/Tc/Solver"
          "GHC/Tc/Solver/Canonical"
          "GHC/Tc/Solver/Rewrite"
          "GHC/Tc/Solver/InertSet"
          "GHC/Tc/Solver/Interact"
          "GHC/Tc/Solver/Monad"
          "GHC/Tc/Solver/Types"
          "GHC/Tc/TyCl"
          "GHC/Tc/TyCl/Build"
          "GHC/Tc/TyCl/Class"
          "GHC/Tc/TyCl/Instance"
          "GHC/Tc/TyCl/PatSyn"
          "GHC/Tc/TyCl/Utils"
          "GHC/Tc/Types"
          "GHC/Tc/Types/Constraint"
          "GHC/Tc/Types/Evidence"
          "GHC/Tc/Types/EvTerm"
          "GHC/Tc/Types/Origin"
          "GHC/Tc/Types/Rank"
          "GHC/Tc/Utils/Backpack"
          "GHC/Tc/Utils/Concrete"
          "GHC/Tc/Utils/Env"
          "GHC/Tc/Utils/Instantiate"
          "GHC/Tc/Utils/Monad"
          "GHC/Tc/Utils/TcMType"
          "GHC/Tc/Utils/TcType"
          "GHC/Tc/Utils/Unify"
          "GHC/Tc/Utils/Zonk"
          "GHC/Tc/Validity"
          "GHC/ThToHs"
          "GHC/Types/Annotations"
          "GHC/Types/Avail"
          "GHC/Types/Basic"
          "GHC/Types/BreakInfo"
          "GHC/Types/CompleteMatch"
          "GHC/Types/CostCentre"
          "GHC/Types/CostCentre/State"
          "GHC/Types/Cpr"
          "GHC/Types/Demand"
          "GHC/Types/Error"
          "GHC/Types/Error/Codes"
          "GHC/Types/FieldLabel"
          "GHC/Types/Fixity"
          "GHC/Types/Fixity/Env"
          "GHC/Types/ForeignCall"
          "GHC/Types/ForeignStubs"
          "GHC/Types/Hint"
          "GHC/Types/Hint/Ppr"
          "GHC/Types/HpcInfo"
          "GHC/Types/Id"
          "GHC/Types/IPE"
          "GHC/Types/Id/Info"
          "GHC/Types/Id/Make"
          "GHC/Types/Literal"
          "GHC/Types/Meta"
          "GHC/Types/Name"
          "GHC/Types/Name/Cache"
          "GHC/Types/Name/Env"
          "GHC/Types/Name/Occurrence"
          "GHC/Types/Name/Reader"
          "GHC/Types/Name/Set"
          "GHC/Types/Name/Shape"
          "GHC/Types/Name/Ppr"
          "GHC/Types/PkgQual"
          "GHC/Types/ProfAuto"
          "GHC/Types/RepType"
          "GHC/Types/SafeHaskell"
          "GHC/Types/SourceError"
          "GHC/Types/SourceFile"
          "GHC/Types/SourceText"
          "GHC/Types/SrcLoc"
          "GHC/Types/Target"
          "GHC/Types/Tickish"
          "GHC/Types/TypeEnv"
          "GHC/Types/TyThing"
          "GHC/Types/Unique"
          "GHC/Types/Unique/DFM"
          "GHC/Types/Unique/DSet"
          "GHC/Types/Unique/FM"
          "GHC/Types/Unique/Map"
          "GHC/Types/Unique/MemoFun"
          "GHC/Types/Unique/SDFM"
          "GHC/Types/Unique/Set"
          "GHC/Types/Unique/Supply"
          "GHC/Types/Var"
          "GHC/Types/Var/Env"
          "GHC/Types/Var/Set"
          "GHC/Unit"
          "GHC/Unit/Env"
          "GHC/Unit/External"
          "GHC/Unit/Finder"
          "GHC/Unit/Finder/Types"
          "GHC/Unit/Home"
          "GHC/Unit/Home/ModInfo"
          "GHC/Unit/Info"
          "GHC/Unit/Module"
          "GHC/Unit/Module/Deps"
          "GHC/Unit/Module/Env"
          "GHC/Unit/Module/Graph"
          "GHC/Unit/Module/Imported"
          "GHC/Unit/Module/Location"
          "GHC/Unit/Module/ModDetails"
          "GHC/Unit/Module/ModGuts"
          "GHC/Unit/Module/ModIface"
          "GHC/Unit/Module/WholeCoreBindings"
          "GHC/Unit/Module/ModSummary"
          "GHC/Unit/Module/Status"
          "GHC/Unit/Module/Warnings"
          "GHC/Unit/Parser"
          "GHC/Unit/Ppr"
          "GHC/Unit/State"
          "GHC/Unit/Types"
          "GHC/Utils/Asm"
          "GHC/Utils/Binary"
          "GHC/Utils/Binary/Typeable"
          "GHC/Utils/BufHandle"
          "GHC/Utils/CliOption"
          "GHC/Utils/Constants"
          "GHC/Utils/Error"
          "GHC/Utils/Exception"
          "GHC/Utils/Fingerprint"
          "GHC/Utils/FV"
          "GHC/Utils/GlobalVars"
          "GHC/Utils/IO/Unsafe"
          "GHC/Utils/Json"
          "GHC/Utils/Lexeme"
          "GHC/Utils/Logger"
          "GHC/Utils/Misc"
          "GHC/Utils/Monad"
          "GHC/Utils/Monad/State/Strict"
          "GHC/Utils/Outputable"
          "GHC/Utils/Panic"
          "GHC/Utils/Panic/Plain"
          "GHC/Utils/Ppr"
          "GHC/Utils/Ppr/Colour"
          "GHC/Utils/TmpFs"
          "GHC/Utils/Trace"
          "GHC/Wasm/ControlFlow"
          "GHC/Wasm/ControlFlow/FromCmm"
          "GHC/CmmToAsm/Wasm"
          "GHC/CmmToAsm/Wasm/Asm"
          "GHC/CmmToAsm/Wasm/FromCmm"
          "GHC/CmmToAsm/Wasm/Types"
          "GHC/CmmToAsm/Wasm/Utils"
          "Language/Haskell/Syntax"
          "Language/Haskell/Syntax/Basic"
          "Language/Haskell/Syntax/Binds"
          "Language/Haskell/Syntax/Concrete"
          "Language/Haskell/Syntax/Decls"
          "Language/Haskell/Syntax/Expr"
          "Language/Haskell/Syntax/Extension"
          "Language/Haskell/Syntax/ImpExp"
          "Language/Haskell/Syntax/Lit"
          "Language/Haskell/Syntax/Module/Name"
          "Language/Haskell/Syntax/Pat"
          "Language/Haskell/Syntax/Type"
          ];
        cSources = [
          "cbits/cutils.c"
          "cbits/genSym.c"
          "cbits/keepCAFsForGHCi.c"
          ];
        hsSourceDirs = [ "." ];
        includeDirs = [ "." ];
        includes = [
          "Unique.h"
          "Bytecodes.h"
          "ClosureTypes.h"
          "FunTypes.h"
          "ghc-llvm-version.h"
          ];
        };
      };
    } // rec { src = (pkgs.lib).mkDefault ../compiler; }