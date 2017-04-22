#' Sign messages from QZ Tray PEM file
#'
#' @import openssl
#' @param toSign message to sign
#' @param myKey path to PEM key file
#' @param password password for PEM key file
#'

signature <-
  function(toSign,
           myKey = Sys.getenv("qz_key"),
           password = Sys.getenv("qz_password")) {
    message <- serialize(toSign, NULL)
    
    key <- openssl::read_key(file = myKey, password = password)
    
    openssl::signature_create(message, key = key, password = password)
    
  }