import { Component, OnInit } from '@angular/core';
import { DataService } from '../data.service';
import { Post } from '../Post';

@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.css']
})
export class AboutComponent implements OnInit {

  posts : Post[];
  constructor(private dataService: DataService) { 
    this.dataService.getData().subscribe(post => {
      this.posts = post;
    });
  }

  ngOnInit() {
  }

}
