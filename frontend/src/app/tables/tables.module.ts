import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TablesComponent } from './tables.component';
import { FormsModule } from '@angular/forms';
import { TablesRoutingModule } from './tables-routing/tables-routing.module';
import { NewComponent } from './naturalFoodsForms/new/new.component';
import { EditComponent } from './naturalFoodsForms/edit/edit.component';
import { ViewComponent } from './naturalFoodsForms/view/view.component';

@NgModule({
  imports: [
    CommonModule,
    TablesRoutingModule,
    FormsModule
  ],
  declarations: [ TablesComponent, NewComponent, EditComponent, ViewComponent ]
})
export class TablesModule { }
