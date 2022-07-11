import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AuthModule } from '@auth0/auth0-angular';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { AuthHttpInterceptor } from '@auth0/auth0-angular';
import { AuthTestComponent } from './auth-test/auth-test.component';
import { LandingPageComponent } from './landing-page/landing-page.component';
import { HomeComponent } from './home/home.component';
import { LoginButtonComponent } from './login-button/login-button.component';
import { NgcCookieConsentModule, NgcCookieConsentConfig } from 'ngx-cookieconsent';
import { FooterComponent } from './footer/footer.component';
import { HeaderComponent } from './header/header.component';
import { ProfileComponent } from './profile/profile.component';
import { MemeComponent } from './meme/meme.component';
import { UploadComponent } from './upload/upload.component';
import { FormsModule, ReactiveFormsModule} from '@angular/forms'

const cookieConfig:NgcCookieConsentConfig = {
  cookie: {
    domain: "localhost"
  },
  position: "bottom",
  theme: "classic",
  palette: {
    popup: {
      background: "#000000",
      text: "#ffffff",
      link: "#ffffff"
    },
    button: {
      background: "#f1d600",
      text: "#000000",
      border: "transparent"
    }
  },
  type: "info",
  content: {
    message: "This only Cookies this Website uses are from Auth0 for Authentication.",
    dismiss: "Got it!",
    deny: "Refuse cookies",
    link: "Learn more about Auth0's use of Cookies",
    href: "https://auth0.com/docs/manage-users/cookies",
    policy: "Cookie Policy"
  }
}

@NgModule({
  declarations: [
    AppComponent,
    AuthTestComponent,
    LandingPageComponent,
    HomeComponent,
    LoginButtonComponent,
    FooterComponent,
    HeaderComponent,
    ProfileComponent,
    MemeComponent,
    UploadComponent
  ],
  imports: [
    NgcCookieConsentModule.forRoot(cookieConfig),
    FormsModule,
    BrowserModule,
    AppRoutingModule,
    NgbModule,
    HttpClientModule,
    AuthModule.forRoot({
      // The domain and clientId were configured in the previous chapter
      domain: 'meme-manager.eu.auth0.com',
      clientId: 'NPsMQEdM7qnLfwG120lIBqzJOLlDO7xa',
      audience: 'https://www.memes.wegetill.de/api',
      // Specify configuration for the interceptor
      httpInterceptor: {
        allowedList: [
          'http://localhost:3000/api/*',
          'https://memes.wegetill.de/api/*'
        ]
      }
    }),

  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthHttpInterceptor,
      multi: true
    },
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
