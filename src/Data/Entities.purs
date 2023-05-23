module Data.Entities
  ( Article(..)
  , Slug(..)
  , Tags(..)
  , Tag(..)
  , Comment
  ) where

import Prelude
import Data.DateTime
import Data.String.NonEmpty.Internal (NonEmptyString)
import Data.Maybe (Maybe(..))
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.String.Regex (Regex, test)
import Data.String.Regex.Flags (noFlags)
import Data.List (List)
import Data.User (Author)

--- Data Declarations ---

newtype Slug = Slug String

derive newtype instance showSlug :: Show Slug

newtype CommentId = CommentId Int

derive newtype instance showCommentId :: Show CommentId

newtype Tag = Tag String

derive newtype instance showTag :: Show Tag

type Tags = List Tag

class Taggable r where
  hasTag :: Tag -> Tagged r -> Boolean
  addTag :: Tag -> Tagged r
  removeTag :: Tag -> Tagged r

type Tagged r =
  { tagList :: Tags
  | r
  }

type Timed r =
  { createdAt :: DateTime
  , updatedAt :: DateTime
  | r
  }

type Article =
  { author :: Author
  , title :: String
  , body :: Maybe String
  , description :: Maybe String
  , slug :: Maybe Slug
  }

type TaggedArticle = Tagged (article :: Article)
type TimedTaggedArticle = Timed (tagedArticle :: TaggedArticle)

data Comment = Comment
  { id :: CommentId
  , author :: Author
  , body :: String
  }

