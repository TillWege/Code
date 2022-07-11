import  express  from "express";
import cors from 'cors';
import { Log } from "../index"
import  jwt from "express-jwt"
import jwks from "jwks-rsa"
import { UploadMemeRoute } from "./Routes/UploadMeme";
import fileUpload from "express-fileupload";
import { GetMemesRoute } from "./Routes/GetMemes";
import { GetMemeRoute } from "./Routes/GetMeme";

export async function StartWebServer(){
    const Port = process.env.PORT || 3000
    const App = express()

    const JwtCheck = jwt({
      secret: jwks.expressJwtSecret({
          cache: true,
          rateLimit: true,
          jwksRequestsPerMinute: 5,
          jwksUri: 'https://meme-manager.eu.auth0.com/.well-known/jwks.json'
      }),
      audience: 'https://www.memes.wegetill.de/api',
      issuer: 'https://meme-manager.eu.auth0.com/',
      algorithms: ['RS256']
    });

    const CorsOptions = {
      origin: 'https://memes.wegetill.de'
    }

    // App.use(JwtCheck);
    App.use(express.json())
    App.use(cors(CorsOptions))
    App.use(fileUpload())
    App.use('/', express.static(__dirname + '/WebApp'))

    App.get('/api/authorized', JwtCheck, (req, res) => {
      res.json({ user: req.user })
    })

    App.get('/api/memes/:amount', JwtCheck, GetMemesRoute)
    App.get('/api/meme/:id', JwtCheck, GetMemeRoute)

    App.post('/api/addmeme', JwtCheck, UploadMemeRoute)

    App.listen( Port, () => {
      Log.info( `server started at http://localhost:${ Port }` );
    });

    return Promise.resolve()
  }


