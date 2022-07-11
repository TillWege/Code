import { Response, Request } from "express"
import fileUpload from "express-fileupload"
import { Log } from "../../index"
import { InsertMemeDoc } from "../../Database/Database"
import { MemeDocument } from "../../Database/Documents/MemeDocument"
import { UploadMeme } from "../../FileServer/Fileservice"
import { Auth0User } from "../WebServerTypes"

interface MemeUploadBody{
    Title: string
    Tags: string
    Hidden: boolean
}

export function UploadMemeRoute(req: Request, res: Response){

    const Body = req.body as MemeUploadBody
    const UploadFile = req.files.file as fileUpload.UploadedFile;

    if(Body.Title.length===0||Body.Tags.length===0){
        res.status(401).json({msg: "incomplete Request"})
    }

    if(!(req.files.file)||Object.keys(req.files).length !== 1){
        res.status(401).json({msg: "no image included"})
    }
    Log.info(UploadFile.name)
    Log.info(__dirname)
    UploadFile.mv('/' + UploadFile.name, (err: string)=>{
        if(err){
          res.status(401).json({msg: err})
        }else{
            const User = req.user as Auth0User
            const Hash = UploadMeme('/' + UploadFile.name, User.sub)
            // meme in s3 uploaden
            const MemeDoc: MemeDocument = new MemeDocument(User.sub, Body.Title, new Date(), Body.Tags.split(','), Hash, Body.Hidden)
            InsertMemeDoc(MemeDoc)
            res.status(200).json({doc: MemeDoc})
        }
    })
}