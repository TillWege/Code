import { Response, Request } from "express"

export function SecureTestRoute(req: Request, res: Response){
    res.status(200).json({msg: 'secure data'})
}