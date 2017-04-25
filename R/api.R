qz_certificate <- function(session, certificate = Sys.getenv("qz_certificate")) {
  
  url <- session$registerDataObj("qz_certificate", certificate, function(data, req) {
    
    shiny:::httpResponse(content = jsonlite::toJSON(certificate), content_type="text/json")
  })
  
  session$sendCustomMessage("qz_certificate", list(url = url))
  
}

qz_signature <- function(session, myKey = Sys.getenv("qz_key"),
                         password = Sys.getenv("qz_password")) {
  
  url <- session$registerDataObj("qz_signature", NULL, function(data, req) {
    query <- parseQueryString(req$QUERY_STRING)
    signed <- signature(query$toSign, myKey, password)
    shiny:::httpResponse(content = jsonlite::toJSON(signed), content_type = "text/json")
    
  })
  
  session$sendCustomMessage("qz_signature", list(url = url))
  
}

#' @export
#' @import shiny
#' @importFrom jsonlite toJSON
#' @param session The \code{session} object passed to function given to shinyServer.
#' @rdname qz_libs
#' 
server_api <- function(session) {
  qz_certificate(session)
  qz_signature(session)
}
