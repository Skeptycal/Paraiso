{-# LANGUAGE ExistentialQuantification,  NoImplicitPrelude #-}
{-# OPTIONS -Wall #-}

-- | all the components for constructing Orthotope Machine data flow draph.
module Language.Paraiso.OM.Graph
    (
     StaticID(..), StaticValue(..), Annotation(..),
     OMNode(..), OMGraph
    )where

import qualified Algebra.Ring as Ring
import Data.Dynamic
import qualified Data.Graph.Inductive as G
import Language.Paraiso.OM.Arithmetic as A
import Language.Paraiso.OM.Reduce as R
import Language.Paraiso.OM.DynValue
import Language.Paraiso.Tensor
import NumericPrelude

-- | The dataflow graph for Orthotope Machine. a is an additional annotation.
type OMGraph vector gauge a = G.Gr (OMNode vector gauge a) ()

newtype StaticID = StaticID String deriving (Eq, Show)
data StaticValue = StaticValue StaticID DynValue deriving (Eq, Show)

data Annotation = Comment String | Balloon


data (Vector vector, Ring.C gauge) => OMNode vector gauge a = 
  NValue DynValue a |
  NInst (Inst vector gauge)
 

data Inst vector gauge = 
  Imm TypeRep Dynamic |
  Load StaticID |
  Store StaticID |
  Reduce R.Operator |
  Shift (vector gauge) |
  Arith A.Operator

instance Arity (Inst vector gauge) where
  arity a = case a of
    Imm _ _   -> (0,1)
    Load _    -> (0,1)
    Store _   -> (1,0)
    Reduce _  -> (1,1)
    Shift _   -> (1,1)
    Arith op  -> arity op


