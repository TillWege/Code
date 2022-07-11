import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Meme } from './meme';

@Injectable({
  providedIn: 'root'
})
export class APIService {

  private APIBase: String

  constructor(private client: HttpClient) {
    this.APIBase = environment.apiurl
  }

  UploadMeme(Title: string, Tags: string, Hidden: boolean, image: File){
    let FD = new FormData();
    FD.append("Title", Title)
    FD.append("Tags", Tags)
    FD.append("Hidden", Hidden.toString())
    FD.append("file", image, image.name)
    return this.client.post(`${this.APIBase}/api/addmeme`, FD)
  }

  GetMeme(ID: string): Promise<Meme>{
    return this.client.get<Meme>(`${this.APIBase}/api/meme/${ID}`).toPromise()
  }

  GetMemes(Amount: number): Promise<Meme[]>{
    return this.client.get<Meme[]>(`${this.APIBase}/api/memes/${Amount}`).toPromise()
  }
}
