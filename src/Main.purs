module Main where

import Prelude

import Node.HTTP
import Node.Stream
import Node.Encoding

import Data.Foldable (foldMap)

import Control.Monad.Eff.Console

main = do
  server <- createServer respond -- (1)
  listen server 8080 $ void do   -- (2)
    log "Server is listening!"
  where
  respond req res = do           -- (3)
    log "Incoming request"
