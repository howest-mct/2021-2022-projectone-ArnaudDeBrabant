'use strict';

const lanIP = `${window.location.hostname}:5000`;
const socket = io(`http://${lanIP}`);

const showHistory = function(jsonObject) {
  console.log(jsonObject);
  let stringHTML = '';
  for (const sensorInfo of jsonObject.sensors){
    stringHTML += `<tr>
                            <td>${sensorInfo.Actiedatum}</td>
                            <td>${sensorInfo.waarde}</td>
                        </tr>`
  }
  document.querySelector('.js-table').innerHTML = stringHTML;
};

const loadHistory = function () {
  const url = `http://192.168.168.169:5000/api/v1/device/`;
  handleData(url, showHistory);
};

const listenToUI = function () {
};

const listenToSocket = function () {
  socket.on("connected", function () {
    console.log("verbonden met socket webserver");
  });
};

document.addEventListener("DOMContentLoaded", function () {
  console.info("DOM geladen");
  listenToUI();
  // listenToSocket();
  loadHistory();
});



const handleData = function (url, callbackFunctionName, callbackErrorFunctionName = null, method = 'GET', body = null) {
  fetch(url, {
  method: method,
  body: body,
  headers: {
    'content-type': 'application/json'
  },
  })
  .then(function(response) {
    if (!response.ok) {
      console.warn(`>> Probleem bij de fetch(). Statuscode: ${response.status}`);
      if (callbackErrorFunctionName) {
        console.warn(`>> Callback errorfunctie ${callbackErrorFunctionName.name}(response) wordt opgeroepen`);
        callbackErrorFunctionName(response); 
      } else {
        console.warn('>> Er is geen callback errorfunctie meegegeven als parameter');
      }
    } else {
      console.info('>> Er is een response teruggekomen van de server');
      return response.json();
    }
  })
  .then(function(jsonObject) {
    if (jsonObject) {
      console.info('>> JSONobject is aangemaakt');
      console.info(`>> Callbackfunctie ${callbackFunctionName.name}(response) wordt opgeroepen`);
      callbackFunctionName(jsonObject);
    }
  })
  .catch(function(error) {
    console.warn(`>>fout bij verwerken json: ${error}`);
      if (callbackErrorFunctionName) {
      callbackErrorFunctionName(undefined);
    }
  })
};