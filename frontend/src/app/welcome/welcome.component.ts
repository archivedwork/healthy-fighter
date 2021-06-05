import { Component, OnInit } from '@angular/core';
import {NgbCarouselConfig} from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-welcome',
  templateUrl: './welcome.component.html',
  styleUrls: ['./welcome.component.scss'],
  providers: [NgbCarouselConfig]  // add NgbCarouselConfig to the component providers

})

export class WelcomeComponent implements OnInit {

  isNavbarCollapsed = true;
  images = [1, 2, 3].map(() => `https://picsum.photos/900/500?random&t=${Math.random()}`);
  constructor() {}
  ngOnInit() {
  }

}
