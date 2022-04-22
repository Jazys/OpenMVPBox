import axios from 'axios';

let url = `https://discord.com/api/v8/applications/${process.env.APPLICATION_ID}/guilds/${process.env.GUILD_ID}/commands`

/*console.log(process.env.APPLICATION_ID)
console.log(process.env.GUILD_ID)
console.log(process.env.TOKEN)
console.log(url)*/


const headers = {
  "Authorization": `Bot ${process.env.TOKEN}`,
  "Content-Type": "application/json"
}

const command_data = {
  "name": "foo",
  "type": 1,
  "description": "replies with bar ;/"
}

const command_data_args = {
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
}


let response= async() =>{await axios.post(url, JSON.stringify(command_data), {
    headers: headers,
  })
}

response= async() =>{await axios.post(url, JSON.stringify(command_data_args), {
  headers: headers,
})
}

console.log(response)
