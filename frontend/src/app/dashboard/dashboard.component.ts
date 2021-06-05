import { Component, OnInit } from '@angular/core';
import { TokenStorageService } from '../auth/token-storage.service';
import {Router} from '@angular/router'
import {DataService} from '../service/data.service';


@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  username = '';
  isLoggedIn = false;
  products = [];
  vitamins = [];
  users = [];
  constructor(private tokenStorage: TokenStorageService, private router: Router, private dataService: DataService) { }

  ngOnInit() {
    if (this.tokenStorage.getUsername && this.tokenStorage.getToken) {
      this.username = sessionStorage.getItem('AuthUsername');
      this.isLoggedIn = true;
    } else {
      this.tokenStorage.signOut();
      this.router.navigate(['/']);
    }

    this.dataService.getAllNatural().subscribe((data: any[]) => {
      console.log(data);
      this.products = data;
    })

    this.dataService.getAllVitamins().subscribe((data: any[]) => {
      console.log(data);
      this.vitamins = data;
    })


    this.dataService.getAllUsers().subscribe((data3: any[]) => {
      console.log(data3);
      this.users = data3;
    })
  }

}
