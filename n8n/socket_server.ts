const express = require("express");
const { createServer } = require("http");
const { Server } = require("socket.io");

const app = express();
const httpServer = createServer(app);

const io = new Server(httpServer, {
  cors: {
    origin: "*"
  }
});

io.on("connection", (socket) => {
  console.log("new Client");
  socket.onAny((eventName, ...args) => {
	console.log(eventName); // true
        console.log(args);
        io.emit(eventName, ...args);
  });
});

httpServer.listen(3000);
