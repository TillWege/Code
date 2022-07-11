import { Component, OnInit } from '@angular/core';
import { APIService } from '../api.service';
import { Meme } from '../meme';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  MemeList?: Meme[]

  constructor(private api: APIService) {
    api.GetMemes(10).then((result)=>{
      console.log(result);
      this.MemeList = result
    }).catch((err)=>{
      console.log(err);
    })

  }

  ngOnInit(): void {
  }

}
