module Test.Main where

import Prelude

import Data.Array

import Test.Assert

import Node.FS
import Node.FS.Sync
import Node.Encoding

import Data.Either

import Data.Foreign
import Data.Foreign.Class

import GitHubLinter.Types

getPushEventFromJSON = do
  content <- readTextFile UTF8 "test/push_event.json"
  return $ readJSON content :: F PushEvent

checkParsedMessage p =
  p.ref == "refs/heads/changes"

main = do
  push_event <- getPushEventFromJSON
  case push_event of
    Right (PushEvent p) -> assert' "Wrong value after parsing!" $ checkParsedMessage p
    Left  _ -> assert' "Error during decoding" false
