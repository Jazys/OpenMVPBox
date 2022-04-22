import fetch from "node-fetch";

//for guild
//let url = `https://discord.com/api/v8/applications/${process.env.APPLICATION_ID}/guilds/${process.env.GUILD_ID}/commands`

//for whole bot
let url =`https://discord.com/api/v8/applications/${process.env.APPLICATION_ID}/commands`

const headers = {
  "Authorization": `Bot ${process.env.TOKEN}`,
  "Content-Type": "application/json"
}

var raw = JSON.stringify({
  "name": "fooarg",
  "type": 1,
  "description": "replies with bar ;/",
  "options": [
    {
      "name": "parameterone",
      "description": "First parameter of the Command",
      "type": 3,
      "required": true
    }
  ]
});

var requestOptions = {
  method: 'POST',
  headers: headers,
  body: raw,
  redirect: 'follow'
};

fetch(url, requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));