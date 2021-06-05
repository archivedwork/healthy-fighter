import { TablesComponent } from './../tables.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {NewComponent} from '../naturalFoodsForms/new/new.component';
import {ViewComponent} from '../naturalFoodsForms/view/view.component';
import {EditComponent} from '../naturalFoodsForms/edit/edit.component';

const routes: Routes = [{
    path: '',
    pathMatch: 'full',
    component: TablesComponent,
    data: {
      title: 'Natural Foods Works'
    }
  }, {
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
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TablesRoutingModule { }
