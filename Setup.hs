{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE Strict #-}
import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.Types.PackageDescription
import Distribution.Types.LocalBuildInfo
import System.Process (callCommand)
import Data.List
import Data.Foldable

main = defaultMainWithHooks $ simpleUserHooks {
    postBuild = buildElm ["Main", "About"]
}

buildElm :: [String]
                -> Args
                -> Distribution.Simple.Setup.BuildFlags
                -> Distribution.Types.PackageDescription.PackageDescription
                -> Distribution.Types.LocalBuildInfo.LocalBuildInfo
                -> IO ()
buildElm modules args buildFlags pkgDescription localBuildInfo =
    for_ modules $ \mod -> do
        callCommand $ "elm make frontend/" <> mod <> ".elm --optimize --output=frontend-dist/" <> mod <> ".js"