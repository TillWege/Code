import { Component, Inject } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { DOCUMENT } from '@angular/common';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-auth-test',
  templateUrl: './auth-test.component.html',
})
export class AuthTestComponent {

  constructor(@Inject(DOCUMENT) public document: Document, public auth: AuthService, private http: HttpClient) {}

  ngOnInit(): void {
  }

  apitest(): void{
    console.log("testing started");
    this.http.get('http://localhost:3000/api/authorized').subscribe(result => {
      console.log(result)
    });
  }
}
