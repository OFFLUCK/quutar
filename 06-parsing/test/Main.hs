import           Test.Tasty       (TestName, TestTree, defaultMain, testGroup)
import           Test.Tasty.HUnit (assertFailure, testCase, (@?=))
import           Text.Megaparsec  (errorBundlePretty, parse)

import           Expr             (Expr (..))
import           Expr.Parse       (expr)

main :: IO ()
main =
  defaultMain $
    testGroup "parsing"
      [ caseParseExpr "positive integer" "4"     $ Number 4
      , caseParseExpr "negative integer" "-4"    $ Number (-4)
      , caseParseExpr "floating"         "-4.18" $ Number (-4.18)
      , caseParseExpr "var"              "x"       Var
      ]

caseParseExpr :: TestName -> String -> Expr -> TestTree
caseParseExpr description input expected =
  testCase description $
    case parse expr "input" input of
      Left errorBundle -> assertFailure $ errorBundlePretty errorBundle
      Right e          -> e @?= expected
