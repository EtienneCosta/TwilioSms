{-# LANGUAGE OverloadedStrings #-}

module Main where 

import Twilio
import Twilio.Messages
import System.Environment 
import Control.Monad.IO.Class (liftIO)
import Data.Text.Internal
import Data.String
import System.IO
import Text.Read

{-

1º:
  Dentro do terminal declarar as "environment variables " com as credenciais fornecidas após a criação de conta no site https://www.twilio.com/

$ Export TWILIO_ACCOUNT_SID = xxxxxxxxxxx  
$ Export TWILIO_AUTH_TOKEN =  xxxxxxxxxxx 

2º:
 Basta correr a main e preencher os campos sugeridos.

Thats All :D 

-}

fetchSid:: IO String
fetchSid = getEnv "TWILIO_ACCOUNT_SID"

fetchToken::IO String
fetchToken = getEnv "TWILIO_AUTH_TOKEN"

main::IO()
main = 
    do 
putStrLn "Please Insert The Destination Number: "
destNumber <- getLine
putStrLn "Insert Your TWILIO Number: "
twilioNumber <- getLine
putStrLn "Insert Your Text Message: "
sms' <- getLine
let destN = Text.Read.read (show destNumber)::Text
    twilioN = Text.Read.read (show twilioNumber)::Text
    smss = Text.Read.read (show sms')::Text
runTwilio' fetchSid fetchToken $ do 
   let sms = PostMessage destN twilioN smss Nothing
   message <- post sms
   liftIO $ print message
