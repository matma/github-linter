module Main where

import Prelude

import Node.HTTP
import Node.Stream

import Control.Monad.Eff.Console

main = do
  server <- createServer respond
  listen server 8080 (return unit)
  where
  respond req res = do
    let method = requestMethod req
    case method of
      "POST" -> do
         setStatusCode res 200
         void $ pipe (requestAsStream req) (responseAsStream res)
      _     -> do
         setStatusCode res 405
         end (responseAsStream res) (return unit)
