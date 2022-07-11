import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '@auth0/auth0-angular';
import { AuthTestComponent } from './auth-test/auth-test.component';
import { HomeComponent } from './home/home.component';
import { LandingPageComponent } from './landing-page/landing-page.component';
import { MemeComponent } from './meme/meme.component';
import { ProfileComponent } from './profile/profile.component';
import { UploadComponent } from './upload/upload.component';

const routes: Routes = [
  { path: '', component: LandingPageComponent },
  { path: 'authttest', component: AuthTestComponent},
  { path: 'home', canActivate: [AuthGuard], component: HomeComponent},
  { path: 'profile/:id', canActivate: [AuthGuard], component: ProfileComponent },
  { path: 'meme/:id', canActivate: [AuthGuard], component: MemeComponent},
  { path: 'upload', canActivate: [AuthGuard], component: UploadComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
