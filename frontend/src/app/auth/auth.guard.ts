import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable()
export class AuthGuard implements CanActivate {

  constructor(private authService: AuthService, private router: Router) { }
  canActivate(next: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {
    if ( sessionStorage.getItem('AuthToken') ) {
 // Token from the LogIn is avaiable, so the user can pass to the route
         return true
       } else  {
 // Token from the LogIn is not avaible because something went wrong or the user wants to go over the url to the site
 // Hands the user to the LogIn page and alert("You are currently not logged in, please provide Login!")
         this.router.navigate(['/login']);
         return false
        }
      }
}
