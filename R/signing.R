#' Sign messages from QZ Tray PEM file
#'
#' @import openssl
#' @param toSign message to sign
#'

qz_signature <-
  function(toSign,
           myKey = Sys.getenv("qz_key"),
           password = Sys.getenv("qz_password")) {
    message <- serialize(enc2utf8(toSign), NULL)
    
    key <- openssl::read_key(file = myKey, password = password)
    
    openssl::signature_create(message, key = key, password = password)
    
  }