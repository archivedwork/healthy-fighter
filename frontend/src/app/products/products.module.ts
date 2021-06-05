import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import {ProductsRoutingModule} from './products-routing/products-routing.module';
import {ProductsComponent} from './products.component';
import { NewComponent } from './vitaminProductsForms/new/new.component';
import { EditComponent } from './vitaminProductsForms/edit/edit.component';
import { ViewComponent } from './vitaminProductsForms/view/view.component';



@NgModule({
  imports: [
    CommonModule,
    ProductsRoutingModule,
    FormsModule
  ],
  declarations: [ProductsComponent, NewComponent, EditComponent, ViewComponent]
})
export class ProductsModule { }
