import { Component, OnInit } from '@angular/core';
import { map } from 'rxjs/operators';
import { ProductService } from '../../service/product.service';
import { Observable } from 'rxjs';
import { Product } from '../../model/Product';

@Component({
  selector: 'slider-products',
  templateUrl: './slider.component.html',
  styleUrls: ['./slider.component.css']
})
export class SliderComponent implements OnInit {

  public products: Product[];
  //public products$: Observable<Product[]>;

  constructor(private productService: ProductService) { }

  ngOnInit() {  
    this.productService.getSlider$()
        .subscribe(products  => this.products = products,
          error => console.error('Error getSlider: ' + error.message));
  }

}
