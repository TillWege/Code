export class Meme{
  id: string
  _id?: string
  authorID: string
  name: string
  timestamp: Date
  tags: string[]
  imageHash: string
  hidden: boolean

  constructor(id: string, authorID: string, name: string, timestamp: Date, tags: string[], imageHash: string, hidden: boolean){
    this.id = id
    this.authorID = authorID
    this.timestamp = timestamp
    this.name = name
    this.tags = tags
    this.imageHash = imageHash
    this.hidden = hidden
  }

}

export const PlaceholderMeme = new Meme("0", "0", "Placeholder Meme", new Date(), ["Tag1", "Tag2"], "palceholdermeme.png", false)
