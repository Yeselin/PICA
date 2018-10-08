import { Component, OnInit, Input, Inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Product } from '../../model/Product';
import { ProductService } from './../../service/product.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'list-products',
  templateUrl: './list-products.component.html',
  styleUrls: ['./list-products.component.css']
})
export class ListProductsComponent implements OnInit {

  products: Product[];

  constructor(private activatedRoute: ActivatedRoute,
    @Inject(ProductService) private productService: ProductService,
    private toastrService: ToastrService) {
  }

  ngOnInit() {
    const parameterType = this.activatedRoute.snapshot.queryParams.parameterType;
    const parameterValue = this.activatedRoute.snapshot.queryParams.parameterValue;

    if(parameterType !== '' && parameterValue !== ''){
      this.productService.getFindProduct$(parameterType, parameterValue).subscribe((response) => {
        if (response.length > 0) {
          this.products = response;
        } else {
          this.toastrService.info('Sin resultados', 'Mensaje!');
        }
      }, (error) => {
        console.error(error);
      });
    }else{
      this.toastrService.warning('Ingresa un valor para filtar', 'Ups!');
    }
    

  }

}
