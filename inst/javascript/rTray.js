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

// Dean Attali, July 2015

api = function() {

    // create a unique id
    function guid() {
        function s4() {
            return Math.floor((1 + Math.random()) * 0x10000)
                .toString(16)
                .substring(1);
        }
        return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
            s4() + '-' + s4() + s4() + s4();
    }

    // keep track of all the calls currently in progress
    calls = {};

    return {

        // this is the main function to use: call "api.call(params)" to make
        // an AJAX call
        call: function(params) {
            var reqid = guid();
            calls[reqid] = params;
            params['_reqid'] = reqid;
            Shiny.onInputChange('api', params);
        },

        // callback from R when a call is done
        callback: function(response) {
            // grab the request id and get the original parameters of this call
            var reqid = response._reqid;
            delete response['_reqid'];
            var call = calls[reqid];

            // remove this call from the list of calls in progress
            delete calls[reqid];

            // if the user specified a callback, call it
            var callback = call._callback;
            if (callback) {
                callback(response);
            }
        },

        // callback from R when an error occurs during an api call
        failureCallback: function(response) {
            console.log("API error!");
            console.log(response);

            var reqid = response._reqid;
            delete response['_reqid'];
            var call = calls[reqid];
            delete calls[reqid];
            var callback = call._failureCallback;
            if (callback) {
                callback(response);
            }
        }
    };
}();


rTray = function() {
  return {
    qz_connect : function(parameters) {
        /// Authentication setup ///
        qz.security.setCertificatePromise(function(resolve, reject) {
            // set intermediate certificate from server with sendCustomMessage
            resolve(parameters.certificate);
        });

        qz.security.setSignaturePromise(function(toSign) {
            return function(resolve, reject) {
                // use Dean Attali API
                var params = {};
                params["_method"] = "signature";
                params["toSign"] = toSign;
                params["_callback"] = function(response) {
                    resolve(response.signature);
                };
                api.call(params);
            };
        });
        qz.websocket.connect().then(function() {
            if (parameters.bool) {
                console.log("Connected!");
            }
        });
    },

    qz_init : function(params) {
        window.location.assign("qz:launch");
    },

    list_printers : function(params) {
        qz.printers.find().then(function(data) {
            Shiny.onInputChange("list_printers", data);
        }).catch(function(e) {
            console.error(e);
        });
    }
  };
}();


$(function() {
    Shiny.addCustomMessageHandler('api.callback', api.callback);
    Shiny.addCustomMessageHandler('api.failureCallback', api.failureCallback);
    Shiny.addCustomMessageHandler('qz_connect', rTray.qz_connect);
    Shiny.addCustomMessageHandler('qz_init', rTray.qz_init);
    Shiny.addCustomMessageHandler('list_printers', rTray.list_printers);
});