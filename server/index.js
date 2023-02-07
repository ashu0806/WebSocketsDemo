const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

const server = app.listen(PORT, (req, res) => {
  console.log(`Server is started on ${PORT}`);
});

const io = require("socket.io")(server);

io.on("connection", (socket) => {
  console.log(`Connection successfully ${socket.id}`);

  socket.on("disconnect", () => {
    console.log(`Disconnected successfully ${socket.id}`);
  });

  socket.on("message", (data) => {
    console.log(data);
    socket.broadcast.emit("message-receive", data);
  });
});
