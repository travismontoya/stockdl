module StockDB 
 ( createDB
 , writeStock
 ) where

import System.Process
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow


-- | Function to create the database if one doesn't exist for the stock.
-- This also has the DB model, it's fields are the ones that are downloaded
-- from yahoo finances.
--
-- if this is changed a lot of the code will fail in StockDL.hs
dbModel       :: String
dbModel       = "CREATE TABLE STOCKS(ID INT PRIMARY KEY,\ 
                                    \SYMBOL TEXT,\
                                    \DATE   TEXT,\
                                    \OPEN   REAL,\
                                    \HIGH   REAL,\
                                    \LOW    REAL,\
                                    \CLOSE  REAL,\
                                    \VOLUME REAL,\
                                    \ADJCLOSE REAL);"
                                
createDB      :: [Char] -> IO ()
createDB name = callCommand ("sqlite3 " ++ name ++ " " ++ dbModel)

writeStock db = undefined 
