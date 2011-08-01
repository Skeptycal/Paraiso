{-# LANGUAGE MultiParamTypeClasses, OverloadedStrings, RankNTypes #-}
{-# OPTIONS -Wall #-}
module ClarisDef (
  Program(..), Text
  ) where

import           Data.ListLike.String (StringLike)
import           Data.String (IsString)

type Text = (StringLike text, IsString text) => text
data Program = Program

  