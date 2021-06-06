<p align="center">
<a href="https://www.adjoint.io">
  <img width="250" src="./.assets/adjoint.png" alt="Adjoint Logo" />
</a>
</p>

[![CircleCI](http://circleci.com/gh/adjoint-io/bulletproofs.svg?style=shield)](https://circleci.com/gh/adjoint-io/bulletproofs)
[![Hackage](https://img.shields.io/hackage/v/bulletproofs.svg)](http://hackage.haskell.org/package/bulletproofs)
[![Build Status](https://github.com/adjoint-io/bulletproofs/workflows/Cabal%20CI/badge.svg)](https://github.com/adjoint-io/bulletproofs/actions)
[![Build Status](https://github.com/adjoint-io/bulletproofs/workflows/Stack%20CI/badge.svg)](https://github.com/adjoint-io/bulletproofs/actions)

Bulletproofs are short zero-knowledge arguments of knowledge that do not require a trusted setup.
Argument systems are proof systems with computational soundness.

Bulletproofs are suitable for proving statements on committed values, such as range proofs, verifiable shuffles, arithmetic circuits, etc.
They rely on the discrete logarithmic assumption and are made non-interactive using
the Fiat-Shamir heuristic.

The core algorithm of Bulletproofs is the inner-product algorithm presented by Groth [2].
The algorithm provides an argument of knowledge of two binding vector Pedersen commitments that satisfy a given inner product relation.
Bulletproofs build on the techniques of Bootle et al. [3] to introduce a communication efficient inner-product proof that reduces
overall communication complexity of the argument to only <img src="/tex/c9180fbdcebcd1d43138236079832280.svg?invert_in_darkmode&sanitize=true" align=middle width=62.21854814999998pt height=24.65753399999998pt/> where <img src="/tex/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode&sanitize=true" align=middle width=9.86687624999999pt height=14.15524440000002pt/> is the dimension
of the two vectors of commitments.


## Range proofs

Bulletproofs present a protocol for conducting short and aggregatable range proofs.
They encode a proof of the range of a committed number in an inner product, using polynomials.
Range proofs are proofs that a secret value lies in a certain interval.
Range proofs do not leak any information about the secret value, other
than the fact that they lie in the interval.

The proof algorithm can be sketched out in 5 steps:

Let <img src="/tex/6c4adbc36120d62b98deef2a20d5d303.svg?invert_in_darkmode&sanitize=true" align=middle width=8.55786029999999pt height=14.15524440000002pt/> be a value in <img src="/tex/55f3e69887b882407ce69a32f942ec8b.svg?invert_in_darkmode&sanitize=true" align=middle width=36.35090909999999pt height=24.65753399999998pt/> and <img src="/tex/780fe58ca23d4620755100bcd6df5857.svg?invert_in_darkmode&sanitize=true" align=middle width=18.20773514999999pt height=14.611878600000017pt/> a vector of bit such that
<img src="/tex/027c16cc98d01e325f81b02b717810ea.svg?invert_in_darkmode&sanitize=true" align=middle width=79.77706439999999pt height=22.968105600000015pt/>.
The components of <img src="/tex/780fe58ca23d4620755100bcd6df5857.svg?invert_in_darkmode&sanitize=true" align=middle width=18.20773514999999pt height=14.611878600000017pt/> are the binary digits of <img src="/tex/6c4adbc36120d62b98deef2a20d5d303.svg?invert_in_darkmode&sanitize=true" align=middle width=8.55786029999999pt height=14.15524440000002pt/>.
We construct a complementary vector <img src="/tex/a6a2d4d080eb7f2709d2667b008dd215.svg?invert_in_darkmode&sanitize=true" align=middle width=78.49842824999999pt height=22.968105600000015pt/>
and require that <img src="/tex/9ca3a8cc8ef0c73eb5f30bc2a79c10bf.svg?invert_in_darkmode&sanitize=true" align=middle width=85.89737144999998pt height=21.18721440000001pt/> holds.

- <img src="/tex/b4208d8b4738940db657353162d75988.svg?invert_in_darkmode&sanitize=true" align=middle width=96.00990794999998pt height=22.465723500000017pt/> - where <img src="/tex/53d147e7f3fe6e47ee05b88b166bd3f6.svg?invert_in_darkmode&sanitize=true" align=middle width=12.32879834999999pt height=22.465723500000017pt/> and <img src="/tex/e257acd1ccbe7fcb654708f1a866bfe9.svg?invert_in_darkmode&sanitize=true" align=middle width=11.027402099999989pt height=22.465723500000017pt/> are blinded Pedersen commitments to <img src="/tex/780fe58ca23d4620755100bcd6df5857.svg?invert_in_darkmode&sanitize=true" align=middle width=18.20773514999999pt height=14.611878600000017pt/> and <img src="/tex/43c0eea9d6fd13b6dcc00c115f09f827.svg?invert_in_darkmode&sanitize=true" align=middle width=19.15122824999999pt height=14.611878600000017pt/>.

&nbsp;&nbsp;&nbsp;&nbsp; <img src="/tex/682f94ba2740d7ac0151285bb5c0e2d5.svg?invert_in_darkmode&sanitize=true" align=middle width=221.92594214999994pt height=22.831056599999986pt/>

&nbsp;&nbsp;&nbsp;&nbsp; <img src="/tex/1cc942c32fa7a265ec264b6b89cb7a5e.svg?invert_in_darkmode&sanitize=true" align=middle width=215.08120259999995pt height=22.831056599999986pt/>

- <img src="/tex/60a45cf4b3b952bb99961cea76f438ec.svg?invert_in_darkmode&sanitize=true" align=middle width=89.67053534999998pt height=22.465723500000017pt/> - Verifier sends challenges <img src="/tex/deceeaf6940a8c7a5a02373728002b0f.svg?invert_in_darkmode&sanitize=true" align=middle width=8.649225749999989pt height=14.15524440000002pt/> and <img src="/tex/f93ce33e511096ed626b4719d50f17d2.svg?invert_in_darkmode&sanitize=true" align=middle width=8.367621899999993pt height=14.15524440000002pt/> to fix <img src="/tex/53d147e7f3fe6e47ee05b88b166bd3f6.svg?invert_in_darkmode&sanitize=true" align=middle width=12.32879834999999pt height=22.465723500000017pt/> and <img src="/tex/e257acd1ccbe7fcb654708f1a866bfe9.svg?invert_in_darkmode&sanitize=true" align=middle width=11.027402099999989pt height=22.465723500000017pt/>.

- <img src="/tex/0a5841e3d06796e4fe2365142851641a.svg?invert_in_darkmode&sanitize=true" align=middle width=105.79308629999998pt height=22.465723500000017pt/> - where <img src="/tex/b1aadae6dafc7da339f61626db58e355.svg?invert_in_darkmode&sanitize=true" align=middle width=16.15873379999999pt height=22.465723500000017pt/> and <img src="/tex/b48cd4fc1cc1b8c602c81734763b31f0.svg?invert_in_darkmode&sanitize=true" align=middle width=16.15873379999999pt height=22.465723500000017pt/> are commitments to
  the coefficients <img src="/tex/4ad941990ade99427ec9730e46ddcdd4.svg?invert_in_darkmode&sanitize=true" align=middle width=12.48864374999999pt height=20.221802699999984pt/>, of a polynomial <img src="/tex/4f4f4e395762a3af4575de74c019ebb5.svg?invert_in_darkmode&sanitize=true" align=middle width=5.936097749999991pt height=20.221802699999984pt/> constructed from the existing
  values in the protocol.

&nbsp;&nbsp;&nbsp;&nbsp; <img src="/tex/3b476246fe46073d297bf73ac65431d4.svg?invert_in_darkmode&sanitize=true" align=middle width=228.34261889999993pt height=24.65753399999998pt/>

&nbsp;&nbsp;&nbsp;&nbsp; <img src="/tex/3f647f042871be1fa7d4c2dd3a39c860.svg?invert_in_darkmode&sanitize=true" align=middle width=343.26980655pt height=26.76175259999998pt/>

&nbsp;&nbsp;&nbsp;&nbsp; <img src="/tex/8776955e6030428869cce9bc42d05f80.svg?invert_in_darkmode&sanitize=true" align=middle width=90.58874879999999pt height=22.831056599999986pt/>

&nbsp;&nbsp;&nbsp;&nbsp;  <img src="/tex/a279966ad1c6df42c3dfa8291334fbe7.svg?invert_in_darkmode&sanitize=true" align=middle width=131.93364524999998pt height=22.831056599999986pt/>, &nbsp;&nbsp;&nbsp;&nbsp; <img src="/tex/131fbdb12ac9849e6ca36f10a618834b.svg?invert_in_darkmode&sanitize=true" align=middle width=65.9370855pt height=24.65753399999998pt/>

- <img src="/tex/4ec1a874225b934747bb34ef5828b457.svg?invert_in_darkmode&sanitize=true" align=middle width=74.74281209999998pt height=22.465723500000017pt/> - Verifier challenges Prover with value <img src="/tex/332cc365a4987aacce0ead01b8bdcc0b.svg?invert_in_darkmode&sanitize=true" align=middle width=9.39498779999999pt height=14.15524440000002pt/>.

- <img src="/tex/f62b5cfd714aaeeb533f9ef8c3aa945f.svg?invert_in_darkmode&sanitize=true" align=middle width=131.58244935pt height=22.831056599999986pt/> - Prover sends several commitments that the verifier will then check.

&nbsp;&nbsp;&nbsp;&nbsp; <img src="/tex/d3e7839976018ff10b0004522caa8c03.svg?invert_in_darkmode&sanitize=true" align=middle width=195.8404503pt height=26.76175259999998pt/>

&nbsp;&nbsp;&nbsp;&nbsp; <img src="/tex/21c10ff9f2eb2b517eb136bd2fb72927.svg?invert_in_darkmode&sanitize=true" align=middle width=118.2106728pt height=22.648391699999998pt/>

See [Prover.hs](https://github.com/adjoint-io/bulletproofs/blob/master/Bulletproofs/RangeProof/Prover.hs "Prover.hs") for implementation details.

The interaction described is made non-interactive using the Fiat-Shamir Transform wherein all the random
challenges made by V are replaced with a hash of the transcript up until that point.

## Inner-product range proof

The size of the proof is further reduced by leveraging the compact <img src="/tex/a0dbe24a0fee4cdae71ca7c7cd9920f2.svg?invert_in_darkmode&sanitize=true" align=middle width=55.96170689999999pt height=24.65753399999998pt/> inner product proof.

The inner-product argument in the protocol allows to prove knowledge of vectors <img src="/tex/d6e48bf9a93b968d85cb6d6d6e33a0b8.svg?invert_in_darkmode&sanitize=true" align=middle width=5.251113449999989pt height=22.831056599999986pt/> and <img src="/tex/9f9c14b9a3c7d1e583ad84cde97887bc.svg?invert_in_darkmode&sanitize=true" align=middle width=7.785368249999991pt height=14.611878600000017pt/>, whose inner product is <img src="/tex/4f4f4e395762a3af4575de74c019ebb5.svg?invert_in_darkmode&sanitize=true" align=middle width=5.936097749999991pt height=20.221802699999984pt/> and
the commitment <img src="/tex/a609ac3c8189720abb255d49a1c40183.svg?invert_in_darkmode&sanitize=true" align=middle width=45.71334404999999pt height=22.648391699999998pt/> is a commitment of these two vectors. We can therefore replace sending
(<img src="/tex/3e7a0b9dae6212d3be6814d4732827c6.svg?invert_in_darkmode&sanitize=true" align=middle width=66.23462504999999pt height=22.831056599999986pt/>) with a transfer of (<img src="/tex/9261976c22c8fab73fb9c45ca5e5e760.svg?invert_in_darkmode&sanitize=true" align=middle width=38.58637694999999pt height=20.221802699999984pt/>) and an execution of an inner product argument.

Then, instead of sharing <img src="/tex/d6e48bf9a93b968d85cb6d6d6e33a0b8.svg?invert_in_darkmode&sanitize=true" align=middle width=5.251113449999989pt height=22.831056599999986pt/> and <img src="/tex/9f9c14b9a3c7d1e583ad84cde97887bc.svg?invert_in_darkmode&sanitize=true" align=middle width=7.785368249999991pt height=14.611878600000017pt/>, which has a communication cost of <img src="/tex/47c124971e1327d1d3882a141f95face.svg?invert_in_darkmode&sanitize=true" align=middle width=18.08608559999999pt height=21.18721440000001pt/> elements, the inner-product
argument transmits only <img src="/tex/7de3cd737846db6d62c7797dae0208ee.svg?invert_in_darkmode&sanitize=true" align=middle width=63.31054124999998pt height=22.831056599999986pt/> elements. In total, the prover sends only <img src="/tex/ae4d1a6a8432a8c26279981571ebaf60.svg?invert_in_darkmode&sanitize=true" align=middle width=90.52894949999998pt height=24.65753399999998pt/>
group elements and 5 elements in <img src="/tex/f627272d293c812bbe5497a7141010ca.svg?invert_in_darkmode&sanitize=true" align=middle width=17.73541934999999pt height=22.648391699999998pt/>

## Aggregating Logarithmic Proofs

We can construct a single proof of range of multiple values, while only incurring an additional space cost of <img src="/tex/bff392076b1ad2c01d7c637eed69f076.svg?invert_in_darkmode&sanitize=true" align=middle width=66.78477299999999pt height=24.65753399999998pt/> for
<img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> additional values <img src="/tex/6c4adbc36120d62b98deef2a20d5d303.svg?invert_in_darkmode&sanitize=true" align=middle width=8.55786029999999pt height=14.15524440000002pt/>, as opposed to a multiplicative factor of <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> when creating <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> independent range proofs.

The aggregate range proof makes use of the inner product argument. It uses (<img src="/tex/b105d53b0c1735325f002ac85419593b.svg?invert_in_darkmode&sanitize=true" align=middle width=104.96204894999998pt height=24.65753399999998pt/>) group elements and 5 elements in <img src="/tex/f627272d293c812bbe5497a7141010ca.svg?invert_in_darkmode&sanitize=true" align=middle width=17.73541934999999pt height=22.648391699999998pt/>.

See [Multi range proof example](https://github.com/adjoint-io/bulletproofs/tree/master#multi-range-proof)

## Usage

**Single range proof**

```haskell
import Data.Curve.Weierstrass.SECP256K1 (Fr)
import qualified Bulletproofs.RangeProof as RP
import Bulletproofs.Utils (commit)

testSingleRangeProof :: Integer -> (Fr, Fr) -> IO Bool
testSingleRangeProof upperBound (v, vBlinding) = do
  let vCommit = commit v vBlinding

  -- Prover
  proofE <- runExceptT (RP.generateProof upperBound (v, vBlinding))

  -- Verifier
  case proofE of
    Left err -> panic (show err)
    Right proof@RP.RangeProof{..}
      -> pure (RP.verifyProof upperBound vCommit proof)
```

**Multi range proof**

```haskell
import Data.Curve.Weierstrass.SECP256K1 (Fr)
import qualified Bulletproofs.MultiRangeProof as MRP
import Bulletproofs.Utils (commit)

testMultiRangeProof :: Integer -> [(Fr, Fr)] -> IO Bool
testMultiRangeProof upperBound vsAndvBlindings = do
  let vCommits = fmap (uncurry commit) vsAndvBlindings

  -- Prover
  proofE <- runExceptT (MRP.generateProof upperBound vsAndvBlindings)

  -- Verifier
  case proofE of
    Left err -> panic (show err)
    Right proof@RP.RangeProof{..}
      -> pure (MRP.verifyProof upperBound vCommits proof)
```


Note that the upper bound <img src="/tex/6dbb78540bd76da3f1625782d42d6d16.svg?invert_in_darkmode&sanitize=true" align=middle width=9.41027339999999pt height=14.15524440000002pt/> must be such that <img src="/tex/62f327ee7716dc7200264b15c6316a6c.svg?invert_in_darkmode&sanitize=true" align=middle width=47.67313649999999pt height=21.839370299999988pt/>, where <img src="/tex/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode&sanitize=true" align=middle width=9.86687624999999pt height=14.15524440000002pt/> is also a power of 2.
This implementation uses the elliptic curve secp256k1, a Koblitz curve, which
has 128 bit security.
See [Range proofs examples](./example/Example/RangeProof.hs) for further details.

## Zero-knowledge proofs for Arithmetic Circuits

An arithmetic circuit over a field and variables <img src="/tex/aff58f35eb363816321c112e32d55a1a.svg?invert_in_darkmode&sanitize=true" align=middle width=74.79657734999999pt height=24.65753399999998pt/> is a directed acyclic graph whose vertices are called gates.

Arithmetic circuit can be described alternatively as a list of multiplication gates with a collection of linear consistency equations
relating the inputs and outputs of the gates. Any circuit described as an acyclic graph can be efficiently converted into this alternative description.

Bulletproofs present a protocol to generate zero-knowledge argument for arithmetic circuits using the inner product argument,
which allows to get a proof of size <img src="/tex/b1be659baa5db44599cdcb3279deb68c.svg?invert_in_darkmode&sanitize=true" align=middle width=98.74815885pt height=24.65753399999998pt/> elements and include committed values as inputs to the arithmetic circuit.

In the protocol, the Prover proves that the hadamard product of <img src="/tex/780fe58ca23d4620755100bcd6df5857.svg?invert_in_darkmode&sanitize=true" align=middle width=18.20773514999999pt height=14.611878600000017pt/> and <img src="/tex/43c0eea9d6fd13b6dcc00c115f09f827.svg?invert_in_darkmode&sanitize=true" align=middle width=19.15122824999999pt height=14.611878600000017pt/> and a set of linear constraints hold.
The input values <img src="/tex/6c4adbc36120d62b98deef2a20d5d303.svg?invert_in_darkmode&sanitize=true" align=middle width=8.55786029999999pt height=14.15524440000002pt/> used to generate the proof are then committed and shared with the Verifier.

```haskell
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

  pure (verifyProof commitments proof arithCircuit)
```
See [Aritmetic circuit example](./example/Example/ArithmeticCircuit.hs) for further details.

**References**:

1.  Bunz B., Bootle J., Boneh D., Poelstra A., Wuille P., Maxwell G.
    "Bulletproofs: Short Proofs for Confidential Transactions and More". Stanford, UCL, Blockstream, 2017

2. Groth J. "Linear Algebra with Sub-linear Zero-Knowledge Arguments". University College London, 2009

3. Bootle J., Cerully A., Chaidos P., Groth J, Petit C. "Efficient Zero-Knowledge Arguments for
Arithmetic Circuits in the Discrete Log Setting". University College London and University of Oxford, 2016.

**Notation**:

- <img src="/tex/c0463eeb4772bfde779c20d52901d01b.svg?invert_in_darkmode&sanitize=true" align=middle width=8.219209349999991pt height=14.611911599999981pt/> : Hadamard product
- <img src="/tex/211dca2f7e396e7b572b4982e8ab3d19.svg?invert_in_darkmode&sanitize=true" align=middle width=4.5662248499999905pt height=14.611911599999981pt/> :Inner product
- <img src="/tex/f3acd3ad07cbb3204b505285686c149b.svg?invert_in_darkmode&sanitize=true" align=middle width=9.18943409999999pt height=14.611878600000017pt/>: Vector

## Disclaimer

This is experimental code meant for research-grade projects only. Please do not
use this code in production until it has matured significantly.

## License

```
Copyright 2018-2019 Adjoint Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
