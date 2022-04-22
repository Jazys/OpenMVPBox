import fastify from 'fastify';
import rawBody from 'fastify-raw-body';
import {
  InteractionResponseType,
  InteractionType,
  verifyKey,
} from 'discord-interactions';
import axios from 'axios';

const server = fastify({
  logger: true,
});

server.register(rawBody, {
  runFirst: true,
});

server.get('/', (request, response) => {
  server.log.info('Handling GET request');
  response.status(200).send({})
});

server.addHook('preHandler', async (request, response) => {
  // We don't want to check GET requests to our root url
  if (request.method === 'POST') {
    const signature = request.headers['x-signature-ed25519'];
    const timestamp = request.headers['x-signature-timestamp'];
    const isValidRequest = verifyKey(
      request.rawBody,
      signature,
      timestamp,
      process.env.PUBLIC_KEY
    );
    if (!isValidRequest) {
      server.log.info('Invalid Request');
      return response.status(401).send({ error: 'Bad request signature ' });
    }
  }
});

server.post('/', async (request, response) => {
  const message = request.body;

  if (message.type === InteractionType.PING) {
    server.log.info('Handling Ping request');
    response.send({
      type: InteractionResponseType.PONG,
    });
  }else if (message.type === InteractionType.APPLICATION_COMMAND) {

    console.log("message : "+JSON.stringify(message))

    if(process.env.URL_WEBHOOK!="" )
    {
      let reponse=  await axios.post(process.env.URL_WEBHOOK, message);
 
      if(typeof reponse.data.data === "string")
      {
        console.log(JSON.parse(reponse.data.data));
        response.status(200).send(JSON.parse(reponse.data.data));
      }
      else if(typeof reponse.data.data === "object")
      {
        console.log(reponse.data.data);
        response.status(200).send((reponse.data.data));
      }      
     
    }else{    
      switch (message.data.name.toLowerCase()) {
        case "foo":
          response.status(200).send({
            type: 4,
            data: {
              content: `*<@${message.member.user.id}> slaps  around a bit with a large trout*`,
              flags: 64,
            },
          });
          server.log.info('Slap Request');
          break;
        case "fooarg":
          response.status(200).send({
            type: 4,
            data: {
              content: `*<@${message.member.user.id}> slaps  around a bit with a large trout* ${message.data.options[0].value}>`,
              flags: 64,
            },
          });
          server.log.info('Slap Request');
          break;
        case INVITE_COMMAND.name.toLowerCase():
          response.status(200).send({
            type: 4,
            data: {
              content: INVITE_URL,
              flags: 64,
            },
          });
          server.log.info('Invite request');
          break;
        default:
          server.log.error('Unknown Command');
          response.status(400).send({ error: 'Unknown Type' });
          break;
      }
    }
  } else {
    server.log.error('Unknown Type');
    response.status(400).send({ error: 'Unknown Type' });
  }
});

server.listen(3000,"0.0.0.0", async (error, address) => {
  if (error) {
    server.log.error(error);
    process.exit(1);
  }
  server.log.info(`server listening on ${address}`);
});
