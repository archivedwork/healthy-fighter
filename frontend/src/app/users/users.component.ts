import { Component, OnInit } from '@angular/core';
import { DataService } from 'app/service/data.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {

  users = [];

  constructor(private dataService: DataService) {
    this.dataService.getAllUsers().subscribe((data3: any[]) => {
      const planeJson = JSON.stringify(data3);
      console.log(planeJson);
      this.users = data3;
    })
  }

  ngOnInit() {
  }

}
