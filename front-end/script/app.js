'use strict';

const lanIP = `${window.location.hostname}:5000`;
const socket = io(`http://${lanIP}`);


// #region ***  DOM references                           ***********


// #endregion

// #region ***  Callback-Visualisation - show___         ***********

const showHistory = function (jsonObject) {
  console.log(jsonObject);
  let stringHTML = '';
  for (const sensorInfo of jsonObject.sensors) {
    stringHTML += `<tr>
                            <td>${sensorInfo.Actiedatum}</td>
                            <td>${sensorInfo.waarde}</td>
                        </tr>`
  }
  document.querySelector('.js-table').innerHTML = stringHTML;
};

const showgetal = function (jsonObject) {
  const waarde = jsonObject.aantal
  console.log(jsonObject)
  let html = ""
  html += `${waarde}`
  document.querySelector('.js-counter').innerHTML = html
}

const showrfid = function (jsonObject) {
  console.log(jsonObject)
  let html = ""
  html += `${jsonObject.id}`
  document.querySelector('.js-RFID').value = html
}



// #endregion

// #region ***  Callback-No Visualisation - callback___  ***********
// #endregion

// #region ***  Data Access - get___                     ***********
const loadHistory = function () {
  const url = `http://192.168.168.169:5000/api/v1/historiek/`;
  handleData(url, showHistory);
};



// #endregion

// #region ***  Event Listeners - listenTo___            ***********
const listenToSocket = function () {
  socket.on("connect", function () {
    console.log("verbonden met socket webserver");
  });
  socket.on("B2F_connect", function (jsonObject) {
    showgetal(jsonObject);
  });
  socket.on("B2F_refresh_history", function (jsonObject) {
    console.log(jsonObject.id)
    showrfid(jsonObject);
  });

};
const listenToUI = function () {
  // socket.on("B2F_connect", function(jsonObject){
  //   console.log("counter verbonden")
  //   console.log(jsonObject)

  //   showgetal()
  // });
}

// #endregion

// #region ***  Init / DOMContentLoaded                  ***********


document.addEventListener("DOMContentLoaded", function () {
  console.info("DOM geladen");
  loadHistory();
  listenToSocket();
  listenToUI();
});

// #endregion




const handleData = function (url, callbackFunctionName, callbackErrorFunctionName = null, method = 'GET', body = null) {
  fetch(url, {
      method: method,
      body: body,
      headers: {
        'content-type': 'application/json'
      },
    })
    .then(function (response) {
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
    .then(function (jsonObject) {
      if (jsonObject) {
        console.info('>> JSONobject is aangemaakt');
        console.info(`>> Callbackfunctie ${callbackFunctionName.name}(response) wordt opgeroepen`);
        callbackFunctionName(jsonObject);
      }
    })
    .catch(function (error) {
      console.warn(`>>fout bij verwerken json: ${error}`);
      if (callbackErrorFunctionName) {
        callbackErrorFunctionName(undefined);
      }
    })
};