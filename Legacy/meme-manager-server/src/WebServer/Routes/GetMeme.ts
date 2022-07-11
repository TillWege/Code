import { Response, Request } from "express"
import { Log } from "../../index"
import { GetMeme } from "../../Database/Database"


export function GetMemeRoute(req: Request, res: Response){
    const ID = req.params.id
    GetMeme(ID).then((Meme)=>{
        if(Meme){
            res.status(200).json(Meme)
        }else{
            res.status(404).send("meme not found")
        }
    }).catch((err)=>{
        Log.error(err)
        res.status(500).send("error while looking up a meme")
    })
}