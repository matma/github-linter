module Main where

import Prelude

import Node.HTTP
import Node.Stream
import Node.Encoding

import Data.Foldable (foldMap)

import Control.Monad.Eff.Console

main = do
  server <- createServer respond
  listen server 8080 (return unit)
  where
  respond req res = do
    setStatus (requestMethod req) res
    end (responseAsStream res) (return unit)

    where
    setStatus method res | method == "POST" = setStatusCode res 200
                         | otherwise        = setStatusCode res 404
