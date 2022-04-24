import fastify from 'fastify';
import rawBody from 'fastify-raw-body';
import {
  InteractionResponseType,
  InteractionType,
  verifyKey,
} from 'discord-interactions';
import axios from 'axios';

let webhookUrl="";

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
  // console.log(request.context.config.url)
  if (request.method === 'POST' && request.context.config.url!="/setUrl") {
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

server.post('/setUrl', (request, response) => {
  const apiKey = request.headers['api-key'];

  /**TODO */
  //for later
  //for each guild id provided a unique url, so create map

  if(apiKey === process.env.API_KEY)
  {
    webhookUrl=request.body.url;
    server.log.info('New URL webhook '+ webhookUrl);
    response.status(200).send({"status":"url change to "+webhookUrl})
  }
  else
    response.status(400).send({})  
});

server.post('/', async (request, response) => {
  const message = request.body;

  if (message.type === InteractionType.PING) {
    server.log.info('Handling Ping request');
    response.send({
      type: InteractionResponseType.PONG,
    });
  }else if (message.type === InteractionType.APPLICATION_COMMAND) {

    /**TODO */
    //for each post message get custom api-key for the current service
    //get one or more parameter

    //console.log("message : "+JSON.stringify(message))

    if(process.env.URL_WEBHOOK!="" || webhookUrl!="" )
    {
      let reponse;
     
      if(webhookUrl!="")
        reponse=  await axios.post(webhookUrl, message);
      else
        reponse=  await axios.post(process.env.URL_WEBHOOK, message);
 
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
