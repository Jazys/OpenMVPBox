import fetch from "node-fetch";

const SLAP_COMMAND = {
  name: "Slap",
  description: "Sometimes you gotta slap a person with a large trout",
  options: [
    {
      name: "user",
      description: "The user to slap",
      type: 6,
      required: true,
    },
  ],
};

const INVITE_COMMAND = {
  name: "Invite",
  description: "Get an invite link to add the bot to your server",
};

const response = async ()  => { await fetch(
  `https://discord.com/api/v8/applications/${process.env.APPLICATION_ID}/commands`,
  {
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bot ${process.env.TOKEN}`,
    },
    method: "PUT",
    body: JSON.stringify([SLAP_COMMAND, INVITE_COMMAND]),
  }
)};

if (response.ok) {
  console.log("Registered all commands");
} else {
  console.error("Error registering commands");
  const text = async() =>{ await  response.text()};
  console.error(text);
}
