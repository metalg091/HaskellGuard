{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Data.Aeson(FromJSON, ToJSON)
import GHC.Generics

main :: IO()
main = do
    scotty 3000 api

api :: ScottyM()
api = do
    get "/api/test" $ genHelloWord

genHelloWord :: ActionM()
genHelloWord = do
     text "Hello, World!"
