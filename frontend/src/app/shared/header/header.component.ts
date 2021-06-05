import { Component, OnInit } from '@angular/core';
import { TokenStorageService } from '../../auth/token-storage.service';
import {Router} from '@angular/router'

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  username = '';
  isLoggedIn = false;
  constructor(private tokenStorage: TokenStorageService, private router: Router) { }

  ngOnInit() {
    if (this.tokenStorage.getUsername && this.tokenStorage.getToken) {
      this.username = sessionStorage.getItem('AuthUsername');
      this.isLoggedIn = true;
    } else {
      this.tokenStorage.signOut();
      this.router.navigate(['/']);
    }
  }

  logout() {
    this.tokenStorage.signOut();
    this.router.navigate(['/']);
  }

}
