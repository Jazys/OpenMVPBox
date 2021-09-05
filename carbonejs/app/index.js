const fs = require('fs');
const carbone = require('carbone');
const express = require('express');
var path = require('path');
const cookieParser = require('cookie-parser');
const cors = require('cors');
const xss = require('xss-clean');
const rateLimit = require('express-rate-limit');
const { response } = require('express');
const limit = rateLimit({
    max: 1,// limit each IP to 100 max requests per windowsMS
    windowMs: 60 * 60 * 1000, // 1 Hour
    message: 'Too many requests' // message to send
});


const app = express();
app.use(express.urlencoded({extended: true}))
app.use(express.json());
app.use(cookieParser());

app.use(express.json({ limit: '10kb' }))

// allow cors requests from any origin and with credentials
app.use(cors({ origin: (origin, callback) => callback(null, true), credentials: true }));

//
app.use('/routeName', limit);

//
app.use(xss());

// data object to inject
let data = {
  firstname : 'John',
  lastname : 'Wick'
};

// options object is used to pass more parameters to carbone render function 
let options = {
  convertTo: 'pdf' //can be docx, txt, ...
}

app.post('/render', async (req, res) => {  
    let return_req=res;
    let template="";
    let data="";
    let fileDeleted=false;
  

    if("template" in req.body){
        template=req.body.template;
        console.log("template received is :"+ template);
    }
    else{
        res.send("Not template provided")
    }

    if("data" in req.body){
        data=req.body.data;
        console.log("data received is :"+ JSON.stringify(data));
    }
    else{
        res.send("Not data provided")
    }

    //Verifiy is data belongs to template
    //for each template json, provide json with all data needed   

    console.log(req.body);

    await carbone.render('templates/'+template, data, options, (err, res) => {
        if (err) {
          return console.log(err);
        }
       
        var characters = "ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz123456789";       
        var lenString = 12;
        var randomstring = '';

        for (var i=0; i<lenString; i++) {
            var rnum = Math.floor(Math.random() * characters.length);
            randomstring += characters.substring(rnum, rnum+1);
        }

        // fs is used to create the PDF file from the render result
        fs.writeFileSync('render/'+randomstring+'.pdf', res);     

        //For getting 
        var options = {
            root: path.join(__dirname)
        };

        //For sending file
        return_req.sendFile('render/'+randomstring+'.pdf', options, function (err) {
            if (err) {
                next(err);
            } else {
                console.log("File is render and emitted");

                if(fileDeleted){
                    try {
                        fs.unlinkSync('render/'+randomstring+'.pdf');
                    
                        console.log("File "+randomstring+".pdf is deleted.");
                    } catch (error) {
                        console.log(error);
                    }
                }
            }
        });        
    });

 });


// start server
const port = process.env.NODE_ENV === 'production' ? (process.env.PORT || 4000) : 4000;
app.listen(port, () => {
    console.log('Server listening on port ' + port);
});
