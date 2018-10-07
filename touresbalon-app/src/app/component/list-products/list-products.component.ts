import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'list-products',
  templateUrl: './list-products.component.html',
  styleUrls: ['./list-products.component.css']
})
export class ListProductsComponent implements OnInit {

  @Input() findBy: string;
  @Input() findValue: string;

  constructor() { }

  ngOnInit() {
  }

}
