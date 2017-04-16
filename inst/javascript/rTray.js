/*
Copyright (c) 2017 CannaData Solutions.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Lesser Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

Shiny.addCustomMessageHandler('qz_connect', function(bool) {
    /// Authentication setup ///
    qz.security.setCertificatePromise(function(resolve, reject) {
        //Preferred method - from server
        //        $.ajax("assets/signing/digital-certificate.txt").then(resolve, reject);
        //Alternate method 1 - anonymous
        resolve();
    });

    qz.security.setSignaturePromise(function(toSign) {
        return function(resolve, reject) {
            //Preferred method - from server
            //            $.ajax("/secure/url/for/sign-message?request=" + toSign).then(resolve, reject);
            //Alternate method - unsigned
            resolve();
        };
    });
    qz.websocket.connect().then(function() {
        if (bool) {
            console.log("Connected!");
        }
    });
});

Shiny.addCustomMessageHandler('list_printers', function(NULL) {
  alert("test1")
    qz.printers.find().then(function(data) {
        Shiny.onInputChange("list_printers", JSON.stringify(data));
    }).catch(function(e) {
        console.error(e);
    });
});

Shiny.addCustomMessageHandler('qz_init', function(NULL) {
    window.location.assign("qz:launch");
});