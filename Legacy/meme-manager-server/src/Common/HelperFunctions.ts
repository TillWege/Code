import { createHash } from "crypto";
import { readFileSync } from "fs";

export const IsProduction = process.env.ENVIROMENT === 'PRODUCTION';

export function hoursToMillis(hours: number){
    return (hours * 60 * 60 * 1000)
}

export function GetFileHash(filepath: string){
    const FileBuffer = readFileSync(filepath);
    const HashSum = createHash('sha256');
    HashSum.update(FileBuffer);

    return HashSum.digest('hex');
}