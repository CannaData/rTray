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

// rTray namespace
rTray = function() {
    return {
        qz_certificate: function(parameters) {
            /// Authentication setup ///
            console.log("certificate");
            qz.security.setCertificatePromise(function(resolve, reject) {
                $.ajax({
                    url: parameters.url
                }).then(resolve, reject);
            });

        },

        qz_signature: function(parameters) {
            console.log("signature");
            qz.security.setSignaturePromise(function(toSign) {
                return function(resolve, reject) {
                    console.log($.ajax(parameters.url + "?request=" + toSign));
                    $.ajax({
                        url: parameters.url,
                        data: {
                            toSign: toSign
                        }
                    }).then(resolve, reject);
                };
            });
        },

        qz_connect: function(parameters) {
            console.log("connect");
            qz.websocket.connect().then(function() {
                if (parameters.bool) {
                    console.log("Connected!");
                }
            });
        },

        qz_init: function(params) {
            console.log("init");
            window.location.assign("qz:launch");
        },

        list_printers: function(params) {
            console.log("printers");
            qz.printers.find().then(function(data) {
                Shiny.onInputChange("list_printers", data);
            }).catch(function(e) {
                console.error(e);
            });
        },

        list_hid: function(params) {
            console.log("hid");
            qz.hid.listDevices().then(function(data) {
                Shiny.onInputChange("list_hid", data);
            }).catch(function(e) {
                console.error(e);
            });
        },

        read_barcodes: function() {

        }

    };
}();

// Register functions with Shiny
$(function() {
    Shiny.addCustomMessageHandler('qz_certificate', rTray.qz_certificate);
    Shiny.addCustomMessageHandler('qz_signature', rTray.qz_signature);
    Shiny.addCustomMessageHandler('qz_connect', rTray.qz_connect);
    Shiny.addCustomMessageHandler('qz_init', rTray.qz_init);
    Shiny.addCustomMessageHandler('list_printers', rTray.list_printers);
    Shiny.addCustomMessageHandler('list_hid', rTray.list_hid);
});