import { Client } from "minio"
import { GetFileHash } from "../Common/HelperFunctions";
import { Log } from "../index"
import { unlink } from "fs";

export let S3Client: Client;

export function initS3Client(){
    Log.info("S3 Client started on " + process.env.S3_ENDPOINT + ':' + process.env.S3_PORT)
    S3Client = new Client({
        endPoint: process.env.S3_ENDPOINT,
        port: parseInt(process.env.S3_PORT, 10),
        useSSL: process.env.S3_SSL === "true",
        accessKey: process.env.S3_USER,
        secretKey: process.env.S3_PASSWORD
      });
}

export function UploadMeme(filepath: string, authID: string): string{
  const FileEnding = filepath.split('.').pop()
  const Hash = GetFileHash(filepath)
  Log.info("starting fileupload for " + filepath)
  Log.info(Hash)
  S3Client.fPutObject('memes', `${Hash}.${FileEnding}`, filepath, {authorID: authID}).then((res)=>{
    Log.info(res)
  }).catch((err)=>{
    Log.error(err)
  }).finally(()=>{
    unlink(filepath, (err)=>{
      Log.error(`couldnt delete file:`)
      Log.error(err)
    })
  })
  return `${Hash}.${FileEnding}`
}