import { Component, OnInit } from '@angular/core';
import {DataService} from 'app/service/data.service';


@Component({
  selector: 'app-pie-chart',
  templateUrl: './pie-chart.component.html',
  styleUrls: ['./pie-chart.component.scss']
})
export class PieChartComponent implements OnInit {

  products ;

  // Pie
  public pieChartLabels: string[] = ['No. of Natural Foods', 'No. of Vitamin Products'];
  // public pieChartData: number[] = [this.len, 15];
  public pieChartData: number[] = [0, 0];

  public pieChartType = 'pie';
  public getVitaminsTotalNumbers = 0;
  public getNaturalProductsTotalNumbers = 0;
   // events
  public chartClicked(e: any): void {
     // console.log(e);
  }



  public chartHovered(e: any): void {
    // console.log(e);
  }

  constructor(private dataService: DataService) {}


  ngOnInit() {
    this.dataService.getAllNatural().subscribe((data: string[]) => {
      // console.log(data);
      this.products = data;
      const obj = JSON.stringify(data, ['productType', 'id']);
      console.log(obj);

      const parobj = JSON.parse(obj);
      console.log(parobj[0].productType);

      const getNaturalProductsTotalNumbers = parobj.length;
      // console.log(getNaturalProductsTotalNumbers);

      this.dataService.getAllVitamins().subscribe((data2: string[]) => {
        // console.log(data);
        this.products = data2;
        const obj2 = JSON.stringify(data2, ['productType', 'id']);
        const parobj2 = JSON.parse(obj2);
        const getVitaminsTotalNumbers = parobj2.length;
        // console.log(getNaturalProductsTotalNumbers);
        this.pieChartData = [getNaturalProductsTotalNumbers, getVitaminsTotalNumbers]
      });
    });

  }

}
