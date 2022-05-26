"use strict";
const { io } = require("/usr/local/lib/node_modules/socket.io-client");

const args = process.argv;
let url ="http://185.189.156.201:42542"
let topic="/cmd-1";
let dataJson=null;

if(args.length>2)
	url=args[2];

if(args.length>3)
	topic=args[3];

if(args.length>4)
	dataJson=args[4];

const socket = io(url);
(async function() {

  const getResponse = () => new Promise(resolve => {
    socket.on('connect', data => {
       socket.emit(topic, dataJson);
       socket.onAny((eventName, ...args) => {
       if(eventName.includes(topic+"/ack"))
	{
                console.log(JSON.stringify(args)); // true
		process.exit(0);
	}
      });
    });
  });
  const sender = await getResponse(); // Waits here until it is done.
  // Continue all your code after this.

}());
