import { Component, OnInit } from '@angular/core';
import { APIService } from '../api.service';

@Component({
  selector: 'app-upload',
  templateUrl: './upload.component.html',
  styleUrls: ['./upload.component.css']
})
export class UploadComponent implements OnInit {

  Title: string
  Tags: string
  hidden: boolean
  file?: File

  constructor(private API: APIService) {
    this.Title = "";
    this.Tags = "";
    this.hidden = false;
  }

  ngOnInit(): void {
  }

  buttonClick(){
    if(!(this.Title==''||this.Tags==''||!this.file)){
      this.API.UploadMeme(this.Title, this.Tags, this.hidden, this.file).toPromise().then((rs)=>{
        console.log(rs);

      })
    }else{
      alert("SIKE DATS DA WRONG NUMBA")
    }
  }

  onFileChange(event: any){
    this.file = event.target.files[0];
  }

}
