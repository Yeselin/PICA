import { Component, OnInit, Input } from '@angular/core';
import { Product } from '../../model/Product';

@Component({
  selector: 'card-product',
  templateUrl: './card-product.component.html',
  styleUrls: ['./card-product.component.css']
})
export class CardProductComponent implements OnInit {

  @Input('product')
  public product : Product;

  constructor() { }

  ngOnInit() {
  }

}
