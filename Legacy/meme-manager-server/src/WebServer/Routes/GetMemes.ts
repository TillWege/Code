import { Response, Request } from "express"
import { Log } from "../../index"
import { GetMemes } from "../../Database/Database"

export function GetMemesRoute(req: Request, res: Response){
    const Amount = parseInt(req.params.amount, 10)
    GetMemes(Amount).then((Memes)=>{
        if(Memes.length > 0){
            res.status(200).json(Memes)
        }else{
            res.status(404).send("no memes found")
        }
    }).catch((err)=>{
        Log.error(err)
        res.status(500).send("error while searching for memes")
    })
}