import Test.DocTest

main :: IO ()
main = doctest ["-isrc", "src/Chap7.hs", "src/Math.hs"]

