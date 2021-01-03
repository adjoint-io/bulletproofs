module Example.ArithmeticCircuit where

import Protolude

import Data.Curve.Weierstrass.SECP256K1 (Fr)
import Data.Field.Galois (rnd)

import Bulletproofs.ArithmeticCircuit
import Bulletproofs.Utils (hadamard, commit)

--  Example:
--  2 linear constraints (q = 2):
--  aL[0] + aL[1] + aL[2] + aL[3] = v[0]
--  aR[0] + aR[1] + aR[2] + aR[3] = v[1]
--
--  4 multiplication constraints (implicit) (n = 4):
--  aL[0] * aR[0] = aO[0]
--  aL[1] * aR[1] = aO[1]
--  aL[2] * aR[2] = aO[2]
--  aL[3] * aR[3] = aO[3]
--
--  2 input values (m = 2)

arithCircuitExample :: ArithCircuit Fr
arithCircuitExample = ArithCircuit
  { weights = GateWeights
    { wL = [[1, 1, 1, 1]
           ,[0, 0, 0, 0]]
    , wR = [[0, 0, 0, 0]
           ,[1, 1, 1, 1]]
    , wO = [[0, 0, 0, 0]
           ,[0, 0, 0, 0]]
    }
  , commitmentWeights = [[1, 0]
                        ,[0, 1]]
  , cs = [0, 0]
  }

testArithCircuitProof :: ([Fr], [Fr]) -> ArithCircuit Fr -> IO Bool
testArithCircuitProof (aL, aR) arithCircuit = do
  let m = 2

  -- Multiplication constraints
  let aO = aL `hadamard` aR

  -- Linear constraints
      v0 = sum aL
      v1 = sum aR

  commitBlinders <- replicateM m rnd
  let commitments = zipWith commit [v0, v1] commitBlinders

  let arithWitness = ArithWitness
        { assignment = Assignment aL aR aO
        , commitments = commitments
        , commitBlinders = commitBlinders
        }

  proof <- generateProof arithCircuit arithWitness

  pure $ verifyProof commitments proof arithCircuit

runExample :: IO ()
runExample = do
  let aL = [1,2,3,4]
      aR = [5,6,7,8]
  proof <- testArithCircuitProof (aL, aR) arithCircuitExample
  putText $ "Arithmetic circuit proof success: " <> show proof
