module Data.User
  ( AuthUser(..)
  , Author(..)
  , User
  , Email
  , Token
  , UnfollowedAuthor
  , UserProfile
  , UserProfileFields
  , ProfilePhoto
  , Username
  , mkEmail
  ) where

import Prelude
import Data.DateTime
import Data.String.NonEmpty.Internal (NonEmptyString)
import Data.Maybe (Maybe(..))
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.String.Regex (Regex, test)
import Data.String.Regex.Flags (noFlags)

--- Data declaration

newtype ProfilePhoto = ProfilePhoto NonEmptyString

derive newtype instance showProfilePhoto :: Show ProfilePhoto

newtype Username = Username NonEmptyString

derive newtype instance showUsername :: Show Username

data AuthUser = AuthUser Username Token

newtype Token = Token String

newtype UnfollowedAuthor = UnfollowedAuthor UserProfile

data Author
  = Following UserProfile
  | NotFollowing UnfollowedAuthor
  | You UserProfile

type UserProfileFields r =
  { username :: Username
  , bio :: Maybe String
  , image :: Maybe ProfilePhoto
  | r
  }

type UserProfile = UserProfileFields ()

type User =
  { username :: Username
  , bio :: Maybe String
  , image :: Maybe ProfilePhoto
  }

newtype Email = Email String

derive newtype instance emailShow :: Show Email

--- API ---

emailStrRegex = "^\\w+([+-.']\\w)*@\\w+([+-.']\\w)*\\.\\w{2,6}$"

emailRegex :: Regex
emailRegex = unsafeRegex emailStrRegex noFlags

mkEmail :: String -> Maybe Email
mkEmail emailStr
  | test emailRegex emailStr = Just <<< Email $ emailStr
  | otherwise = Nothing
