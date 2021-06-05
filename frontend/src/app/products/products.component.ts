import { Component, OnInit } from '@angular/core';
import { DataService } from '../service/data.service';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent implements OnInit {

  products = [];
  constructor(private dataService: DataService ) {
    this.dataService.getAllVitamins().subscribe((data: any[]) => {
      const planeJson = JSON.stringify(data);
      console.log(planeJson);
      this.products = data
    })

  }

  ngOnInit() {
  }

}
