{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Data.Aeson
import GHC.Generics

data Data = Data { ident :: Int, name :: String } deriving (Show, Generic)
instance ToJSON Data
instance FromJSON Data

data Response = Response { success :: Bool, dt :: [Data], revisionDate :: String } deriving (Show, Generic)
instance ToJSON Response where
    toJSON (Response success dt revisionDate) = object ["success" .= success, "data" .= dt, "revisionDate" .= revisionDate]
    toEncoding (Response success dt revisionDate) = pairs ("success" .= success <> "data" .= dt <> "revisionDate" .= revisionDate)

newtype Unlock = Unlock { password :: String } deriving (Show, Generic)
instance ToJSON Unlock
instance FromJSON Unlock



main :: IO()
main = do
    scotty 3000 api

api :: ScottyM()
api = do
    get "/api/test" $ genHelloWord
    post "/lock" $ lock
    post "/unlock" $ unlock

genHelloWord :: ActionM()
genHelloWord = do
     text "Hello, World!"

lock :: ActionM()
lock = do
    text "implement locking..."

unlock :: ActionM()
unlock = do
    unlockData <- jsonData :: ActionM Unlock
    json $ createResponse [unlockData]

createResponse :: [a] -> Response
createResponse db = Response { success = True, dt = [Data { ident = 0, name = "you" }], revisionDate = "2018-01-01" }
