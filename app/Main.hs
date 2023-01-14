{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Lib (elmPage)

import System.Environment (lookupEnv)

import Text.Read (readMaybe)

import Web.Spock
import Web.Spock.Config

import Control.Monad.Trans
import Data.IORef
import qualified Data.Text as T
import Data.Maybe (fromMaybe)
import Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import Network.Wai.Middleware.Static (staticPolicy, addBase)

data MySession = EmptySession
newtype MyAppState = DummyAppState (IORef Int)

renderElm title component = lazyBytes . renderHtml $ elmPage title component

main :: IO ()
main =
    do ref <- newIORef 0
       spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
       port <- lookupEnv "PORT"
       runSpock (fromMaybe 8080 (port >>= readMaybe)) (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app =
    do middleware (staticPolicy (addBase "static"))
       get root $ renderElm "Home" "Main"
       get "about" $ renderElm "About" "About"
       get ("api/hello" <//> var) $ \name ->
           do (DummyAppState ref) <- getState
              visitorNumber <- liftIO $ atomicModifyIORef' ref $ \i -> (i+1, i+1)
              text ("Hello " <> name <> ", you are visitor number " <> T.pack (show visitorNumber))
