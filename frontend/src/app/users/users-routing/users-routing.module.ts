import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule } from '@angular/router';
import {UsersComponent} from '../users.component';

const routes = [{
  path: '',
  pathMatch: 'full',
  component: UsersComponent,
  data: {title: 'Users'}
}]

@NgModule({
  declarations: [],
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UsersRoutingModule { }
