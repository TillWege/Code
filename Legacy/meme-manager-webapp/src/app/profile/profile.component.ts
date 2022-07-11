import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent {
  active = 1;
  id: number;

  constructor(private route: ActivatedRoute){
    this.id =  Number(this.route.snapshot.paramMap.get('id')) ?? -1
    console.log(this.id);
  }
}
