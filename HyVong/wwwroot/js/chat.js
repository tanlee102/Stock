"use strict";

var listlabel = [
    "MACP",

    "GiaMua3",
    "KLMua3",
    "GiaMua2",
    "KLMua2",
    "GiaMua1",
    "KLMua1",

    "GiaKhopLenh",
    "KLKhopLenh",

    "GiaBan1",
    "KLBan1",
    "GiaBan2",
    "KLBan2",
    "GiaBan3",
    "KLBan3",

    "TongKL"
];

function inzEdATA() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            // Typical action to be performed when the document is ready:

            let data = JSON.parse(xhttp.responseText);
            console.log(data);
            for (let i = 0; i < data.length; i++) {

                let elementx = "";

                for (let k = 0; k < 16; k++) {
                    if (data[i][listlabel[k]] == 0) data[i][listlabel[k]] = "";
                    elementx = elementx + "<td>" + data[i][listlabel[k]] + "</td>"
                }
                $("#customers").append("<tr>" + elementx + "</tr>");
            }
        }
    };
    xhttp.open("GET", window.location.href+ "datas", true);
    xhttp.send();
}

function SetData() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            // Typical action to be performed when the document is ready:

            let data = JSON.parse(xhttp.responseText);
            console.log(data);
            for (let i = 3; i < data.length + 3; i++) {


                var selection = document.querySelector("#customers tr:nth-child(" + i + ")") !== null;
                if (selection) {
                    for (let k = 1; k < 17; k++) {
                        if (data[i - 3][listlabel[k - 1]] == 0) data[i - 3][listlabel[k - 1]] = "";
                        //console.log("#customers tr:nth-child(" + i + ") td:nth-child(" + k + ")");
                        document.querySelector("#customers tr:nth-child(" + i + ") td:nth-child(" + k + ")").innerHTML = data[i - 3][listlabel[k - 1]];
                    }
                } else {

                    let elementx = "";

                    for (let k = 0; k < 16; k++) {
                        if (data[i-3][listlabel[k]] == 0) data[i-3][listlabel[k]] = "";
                        elementx = elementx + "<td>" + data[i-3][listlabel[k]] + "</td>"
                    }

                    $("#customers").append("<tr>" + elementx + "</tr>");
   
                }
            }
        }
    };
    xhttp.open("GET", window.location.href + "datas", true);
    xhttp.send();
}



inzEdATA();


var connection = new signalR.HubConnectionBuilder().withUrl("/chatHub").build();

connection.on("ReceiveMessage", function (user, message) {
    console.log("datachange");
    SetData();
});

connection.start().then(function () {
}).catch(function (err) {
    return console.error(err.toString());
});
