import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { DataService } from '../../../service/data.service';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss']
})
export class EditComponent implements OnInit, OnDestroy {
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

    ngOnDestroy() {
      this.sub.unsubscribe();
    }
    gotoList() {
      this.router.navigate(['/products']);
    }
    save(form: NgForm) {
      form['productType'] = 'VITAMIN';
      this.dataService.save(form).subscribe(result => {
        this.gotoList();
      }, error => console.error(error));
    }
    remove(href) {
      this.dataService.remove(href).subscribe(result => {
        this.gotoList();
      }, error => console.error(error));
    }
}
