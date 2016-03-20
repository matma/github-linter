module GitHubLinter.Types where

import Prelude
import Data.Array
import Data.Foreign.Class

data Commit = Commit {
  id :: String
}

data PushEvent = PushEvent {
  ref :: String,
  commits :: Array Commit
}

instance showCommit :: Show Commit where
 show (Commit c) = "Commit: len=" ++ c.id

{--instance showArrayCommit :: Show Array Commit where--}
 {--show a = "Commit: len=" ++ length a--}

instance commitIsForeign :: IsForeign Commit where
  read json = do
    id <- readProp "id" json
    return $ Commit { id: id }

instance showPushEvent :: Show PushEvent where
 show (PushEvent p) = "PushEvent: ref=" ++ p.ref ++ ", commits" ++ show p.commits

instance pushEventIsForeign :: IsForeign PushEvent where
  read json = do
    ref <- readProp "ref" json
    commits <- readProp "commits" json
    return $ PushEvent { ref: ref, commits: commits }
