import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { APIService } from '../api.service';
import { Meme, PlaceholderMeme } from '../meme';

@Component({
  selector: 'app-meme',
  templateUrl: './meme.component.html',
  styleUrls: ['./meme.component.css']
})
export class MemeComponent implements OnInit {

  @Input() memeID?: string;

  LMeme!: Meme;
  constructor(private route: ActivatedRoute, private api: APIService) {

  }

  ngOnInit(): void {
    this.LMeme = PlaceholderMeme

    if(!this.memeID){
      this.memeID = this.route.snapshot.paramMap.get('id') ?? "-1"
    }

    if(this.memeID){
      this.api.GetMeme(this.memeID).then((data)=>{
        this.LMeme = data
      }).catch((err)=>{
        console.log(err);
      })
    }
  }

}
