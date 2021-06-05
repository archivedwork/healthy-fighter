import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import {Routes, RouterModule } from '@angular/router';
import {ProductsComponent} from '../products.component';
import {NewComponent} from '../../products/vitaminProductsForms/new/new.component';
import {ViewComponent} from '../../products/vitaminProductsForms/view/view.component';
import {EditComponent} from '../../products/vitaminProductsForms/edit/edit.component';

const routes: Routes = [{
  path: '',
  pathMatch: 'full',
  component: ProductsComponent,
  data: {title: 'Vitamin Products'}
},
  {
    path: 'new',
    pathMatch: 'full',
    component: NewComponent,
    data: {
      title: 'new  Tables Works'
    }
  }, {
    path: 'view/:id',
    pathMatch: 'full',
    component: ViewComponent,
    data: {
      title: 'view natural food'
    }
  }, {
    path: 'edit/:id',
    pathMatch: 'full',
    component: EditComponent,
    data: {
      title: 'edit natural food'
    }
  }

];

@NgModule({
  imports: [RouterModule.forChild(routes), FormsModule],
  exports: [RouterModule]
})
export class ProductsRoutingModule { }
