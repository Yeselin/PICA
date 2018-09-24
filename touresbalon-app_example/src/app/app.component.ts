import { Component } from '@angular/core';

import {DataService} from './data.service'

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  users = ['Juancho','Pablo','Juana','Pepa'];
  posts = [];
  constructor(private dataService: DataService){
    this.dataService.getData().subscribe(post => {
      this.posts = post;
    });
  }
}
