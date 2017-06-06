# Copyright (c) 2017 CannaData Solutions.
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, version 3.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Lesser Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

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