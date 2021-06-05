import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { DataService } from '../../../service/data.service';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-new',
  templateUrl: './new.component.html',
  styleUrls: ['./new.component.scss']
})
export class NewComponent implements OnInit {
  product: any = {};
  sub: Subscription;
  constructor(private route: ActivatedRoute,
                private router: Router,
                private dataService: DataService) {
    }
    ngOnInit() {

    }

    gotoList() {
      this.router.navigate(['/naturalfoods']);
    }
    save(form: NgForm) {
      form['productType'] = 'NATURAL_FOOD';
      this.dataService.save(form).subscribe(result => {
        this.gotoList();
      }, error => console.error(error));
    }
}
