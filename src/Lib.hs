{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( 
    ) where

import Text.Blaze.Html5 as H
    ( (!), toHtml, body, div, docTypeHtml, head, script, title )
import Text.Blaze.Html5.Attributes as A

elmPage initTitle componentName =
    docTypeHtml $ do
        H.head $ do
            H.title $ toHtml initTitle
        body $ do
            H.div ! A.id "main" 
                  $ ""
            script ! src ("/script/" <> componentName <> ".js")
                   $ ""
            script "var app = Elm.Main.init({ node: document.querySelector('main') })"
