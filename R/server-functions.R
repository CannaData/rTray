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

#' Interact with QZ from Server
#' 
#' @param session The \code{session} object passed to function given to
#'   \code{shinyServer}
#' @export
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


