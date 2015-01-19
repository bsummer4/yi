{-# LANGUAGE OverloadedStrings, UnicodeSyntax #-}

import           Yi hiding (super)
import qualified Yi.Main as Yi
import           Yi.Modes
import           System.Exit
import           System.Environment
import qualified Yi.Mode.Haskell as Haskell
import           Yi.Modes

main ∷ IO ()
main = do
  let consoleConfig = Yi.ConsoleConfig [] False $ return "/dev/null"
      cfg = defaultVimConfig { modeTable=modes
                             , configCheckExternalChangesObsessively=False
                             }
  args ← getArgs
  case Yi.do_args cfg args of
    Left (Yi.Err err code) → putStrLn err >> exitWith code
    Right (finalCfg, cfgcon) → Yi.main (finalCfg,cfgcon) Nothing

modes = [ AnyMode Haskell.cleverMode
        , AnyMode Haskell.preciseMode
        , AnyMode Haskell.literateMode
        , AnyMode cppMode
        , AnyMode whitespaceMode
        , AnyMode fundamentalMode
        ]
