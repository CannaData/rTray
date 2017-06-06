#' Interact with QZ from Server
#' 
#' @param session The \code{session} object passed to function given to
#'   \code{shinyServer}
#' @export
#' @importFrom shinyjs delay
qz_init <- function(session) {
  session$sendCustomMessage("qz_init", list())
}

#' @export
#' @rdname qz_init
qz_connect <- function(session) {
  session$sendCustomMessage("qz_connect", list())
}

#' @export
#' @rdname qz_init

list_printers <- function(session) {
  session$sendCustomMessage("list_printers", list())
}

#' @export
#' @rdname qz_init

list_hid <- function(session) {
  session$sendCustomMessage("list_hid", list())
}

#' @export
#' @param vendor hex code for vendorId
#' @param product hex code for productId
#' @rdname qz_init

hid_read <- function(session, vendor, product) {
  session$sendCustomMessage("hid_read", list(vendor = vendor, product = product))
}

