import { ObjectId } from "mongodb"

export class MemeDocument{
    _id: ObjectId
    authorID: string
    name: string
    timestamp: Date
    tags: string[]
    imageHash: string
    hidden: boolean


    constructor(authorID: string, name: string, timestamp: Date, tags: string[], imageHash: string, hidden: boolean){
        this.authorID = authorID
        this.timestamp = timestamp
        this.name = name
        this.tags = tags
        this.imageHash = imageHash
        this.hidden = hidden
    }
}