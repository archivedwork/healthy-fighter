import { NgModule } from '@angular/core';
import { DashboardComponent } from './dashboard.component';
import { DashboardRoutingModule } from './dashboard-routing/dashboard-routing.module';
import { BarChartComponent } from '../shared/bar-chart/bar-chart.component';
import { LineChartComponent } from '../shared/line-chart/line-chart.component';
import {ChartsModule} from 'ng2-charts';
import {PieChartComponent} from '../shared/pie-chart/pie-chart.component';
import {CommonModule} from '@angular/common';
import { httpInterceptorProviders } from 'app/auth/auth-interceptor';


@NgModule({
  imports: [
    DashboardRoutingModule, ChartsModule, CommonModule
  ],
  declarations: [DashboardComponent, BarChartComponent, LineChartComponent, PieChartComponent],
  providers: [
      BarChartComponent, LineChartComponent, httpInterceptorProviders
  ]
})
export class DashboardModule { }
