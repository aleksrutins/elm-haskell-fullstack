import Distribution.Simple
import System.Process (createProcess)
import Data.List

main = defaultMainWithHooks $ simpleUserHooks {
    postBuild = buildElm ["Main.elm"]
}

buildElm files args buildFlags pkgDescription localBuildInfo = do
    createProcess (proc "elm" ["make"] ++ (map ("frontend/" <>) files))