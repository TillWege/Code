import dotenv from "dotenv";

import { Logger } from "tslog";
import { StartDBConnection } from "./Database/Database";
import { initS3Client } from "./FileServer/Fileservice";
import { StartWebServer } from "./WebServer/Webserver";

export const Log: Logger = new Logger();
export const LogError = (err: any) => {
  Log.fatal(err)
}

dotenv.config({ path: __dirname+'/.env' });

StartDBConnection().then(()=>{
  initS3Client()
  StartWebServer().catch(LogError)
}).catch(LogError)