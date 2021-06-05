import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { DataService } from '../../../service/data.service';

@Component({
  selector: 'app-view',
  templateUrl: './view.component.html',
  styleUrls: ['./view.component.scss']
})
export class ViewComponent implements OnInit {
  product: any = {};
  sub: Subscription;
  constructor(private route: ActivatedRoute,
                private router: Router,
                private dataService: DataService) {
    }
    ngOnInit() {
      this.sub = this.route.params.subscribe(params => {
        const id = params['id'];
        if (id) {
          this.dataService.get(id).subscribe((product: any) => {
            if (product) {
              this.product = product;
            } else {
              console.log(`Product with id '${id}' not found, returning to list`);
              this.gotoList();
            }
          });
        }
      });
    }
    gotoList() {
      this.router.navigate(['/#/products']);
    }
}
