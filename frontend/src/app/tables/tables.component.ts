import { Component, OnInit } from '@angular/core';
import { DataService } from '../service/data.service';


@Component({
  selector: 'app-tables',
  templateUrl: './tables.component.html',
  styleUrls: ['./tables.component.scss']
})
export class TablesComponent implements OnInit {
  products = []

  constructor(private dataService: DataService) {
    this.dataService.getAllNatural().subscribe((data: any[]) => {
      // console.log(data);

      const planeJsonArray =  JSON.stringify(data, ['id', 'productType', 'name', 'vitamine', 'protein', 'card',
        'fight', 'isAllergic', 'description', ]);
      console.log(planeJsonArray);

      const parsing = JSON.parse(planeJsonArray);
      const par = parsing[0].productType;
      console.log(par);
      this.products = data
    })
  }

  ngOnInit() {
  }

}
