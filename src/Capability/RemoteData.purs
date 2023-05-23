module Capability.RemoteData
  ( RemoteData(..)
  , ComponentState(..)
  , follow
  ) where

import Prelude
import Effect (Effect)
import Effect.Exception (Error)
import Data.Typelevel.Undefined
import Data.User (Username, UserProfile, AuthUser, UnfollowedAuthor)
import Data.List.Lazy (List)
import Data.Entities (Article, Tag, Slug)
import Data.Either (Either)

--- Data Declaration ---

class Monad m <= GetPublicResource m where
  getArticle :: Slug -> m (Either Error Article)
  getArticlesByTag :: Tag -> m (Either Error (List Article))
  getUserProfile :: Username -> m (Either Error UserProfile)

data RemoteData err res
  = NotAsked
  | Loading
  | Failure err
  | Success res

type ComponentState a = { stuff :: RemoteData Error (List a) }

-- | Token should not be used directly
follow
  :: UnfollowedAuthor
  -> AuthUser
  -> Effect Unit
follow = undefined

