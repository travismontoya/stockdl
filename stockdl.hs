--------------------------------------------------------------------------------
-- stockdl.hs - Downloads the entire history of a stock symbol from yahoo
-- Copyright (C) 2016 Travis Montoya
--
-- NOTE: This is part of a larger project for algorithmic trading.
--------------------------------------------------------------------------------
module Main where

import Network.HTTP
import System.Environment (getArgs)

requestUrl             :: [Char] -> [Char]
requestUrl sym         = "http://chart.finance.yahoo.com/table.csv?s=" ++ sym

getData                :: String -> IO String
getData url            = simpleHTTP (getRequest url) >>= getResponseBody

downloadData           :: String -> [Char] -> IO ()
downloadData url name  = do putStrLn $ "Downloading historical data to " ++ name
                            (getData url) >>= writeFile name

parseArgs              :: [[Char]] -> IO ()
parseArgs []           = putStrLn "usage: stockdl <sym>"
parseArgs (x:_)
       | symlen <= 5 && symlen >= 1 = downloadData (requestUrl x) (x ++ ".csv")
       | otherwise                  = putStrLn "Invalid stock symbol"
       where symlen = length x

main                   :: IO ()
main                   = getArgs >>= parseArgs
