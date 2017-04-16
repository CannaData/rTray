#' Include qz JavaScript libraries
#' 
#' @export
#' @importFrom htmltools htmlDependency
#' 

qz_libs <- function() {
  htmltools::htmlDependency(
    "qz-tray","2.0", system.file(package = "rTray", "javascript", "qz"),
    script = c("rsvp-3.1.0.min.js", "sha-256.min.js", "qz-tray.js")
  )
}

#' @rdname qz_libs
#' @importFrom shiny includeScript
#' @export
#' 

rtray_lib <- function() {
  shiny::includeScript(
    system.file(package = "rTray", "javascript", "rTray.js")
  )
}