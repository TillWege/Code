import { Collection, CursorStreamOptions, Db, MongoClient, ObjectId } from 'mongodb'
import { Log } from '../index'
import { MemeDocument } from './Documents/MemeDocument';
import { UserDocument } from "./Documents/UserDocument"

let DBClient: MongoClient
let DB: Db;
let UserCollection: Collection<UserDocument>
let MemeCollection: Collection<MemeDocument>

export async function StartDBConnection(){
    const Url = `mongodb://${process.env.MONGODB_USER}:${process.env.MONGODB_PASSWORD}@${process.env.MONGODB_DOMAIN}`
    try {
        DBClient = new MongoClient(Url);
        await DBClient.connect();
        DB = DBClient.db(process.env.MONGODB_DB);
        InitCollections()
    } catch (error) {
        Log.error('Error while connecting to DB')
        Log.error(`url: ${Url}`)
        Log.error(`dbName: ${process.env.MONGODB_DB}`)
    }
}

function InitCollections(){
    UserCollection = DB.collection('Users');
    MemeCollection = DB.collection('Memes');
}

export function GetUserDocument(UserID: string): Promise<UserDocument>{
    return UserCollection.findOne({_id: UserID})
}

export function GetMemeDocument(id: ObjectId){
    return MemeCollection.findOne({_id: id})
}

function RegisterUser(UserID: string){
    const UserDoc = new UserDocument(UserID);
    UserCollection.insertOne(UserDoc).catch((err)=>{
        Log.error(err)
    })
    return UserDoc
}

export function GetMemes(amount: number){
    const Cursor = MemeCollection.find().limit(amount)
    return Cursor.toArray();
}

export function GetMeme(MemeID: string){
    const ID = new ObjectId(MemeID)
    return MemeCollection.findOne({_id: ID})
}

export function InsertMemeDoc(doc: MemeDocument){
    MemeCollection.insertOne(doc).then((res)=>{
        Log.info(res)
    }).catch((err)=>{
        Log.error(err)
    })
}