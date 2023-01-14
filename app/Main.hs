{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import System.Environment (lookupEnv)

import Text.Read (readMaybe)

import Web.Spock
import Web.Spock.Config

import Control.Monad.Trans
import Data.IORef
import qualified Data.Text as T

data MySession = EmptySession
newtype MyAppState = DummyAppState (IORef Int)

main :: IO ()
main =
    do ref <- newIORef 0
       spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
       port <- lookupEnv "PORT"
       runSpock (case (port >>= readMaybe) :: Maybe Int of
            Just portNum -> portNum
            Nothing -> 8080) (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app =
    do get root $
           text "Hello World!"
       get ("api/hello" <//> var) $ \name ->
           do (DummyAppState ref) <- getState
              visitorNumber <- liftIO $ atomicModifyIORef' ref $ \i -> (i+1, i+1)
              text ("Hello " <> name <> ", you are visitor number " <> T.pack (show visitorNumber))