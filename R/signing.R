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