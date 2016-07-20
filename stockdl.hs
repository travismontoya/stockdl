--------------------------------------------------------------------------------
-- stockdl.hs - Downloads the entire history of a stock symbol from yahoo
-- Copyright (C) 2016 Travis Montoya
--
-- NOTE: This is part of a larger project for algorithmic trading.
--------------------------------------------------------------------------------
module Main where

import Network.HTTP
import System.Environment (getArgs)

-- This is currently being changed to allow the user to specify a period of time
-- of the historical data (IE: 7/01/2016-7/20/2016), for now it downloads ALL of
-- the data yahoo has for the specific symbol.
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
       | symlen < 6 && symlen > 0 = downloadData (requestUrl x) (x ++ ".csv")
       | otherwise                = putStrLn "Invalid stock symbol"
       where symlen = length x

main                   :: IO ()
main                   = getArgs >>= parseArgs
