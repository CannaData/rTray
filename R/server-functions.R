#' Interact with QZ from Server
#' 
#' @param session The \code{session} object passed to function given to
#'   \code{shinyServer}
#' @export
qz_launch <- function(session) {
  session$sendCustomMessage("qz_init", list())
  shinyjs::delay(5000, {
    session$sendCustomMessage("qz_connect", list(bool=TRUE))
  })
}

#' @export
#' @rdname qz_launch

list_printers <- function(session) {
  session$sendCustomMessage("list_printers", list())
}

#' @export
#' @rdname qz_launch

list_hid <- function(session) {
  session$sendCustomMessage("list_hid", list())
}

#' @export
#' @param vendor hex code for vendorId
#' @param product hex code for productId
#' @rdname qz_launch

hid_read <- function(session, vendor, product) {
  session$sendCustomMessage("hid_read", list(vendor = vendor, product = product))
}

