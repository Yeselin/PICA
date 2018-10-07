import { Component, OnInit, Input, Inject } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Product } from '../../model/Product';
import { LocalStorageService } from '../../service/local-storage.service';


@Component({
  selector: 'card-product',
  templateUrl: './card-product.component.html',
  styleUrls: ['./card-product.component.css']
})
export class CardProductComponent implements OnInit {

  @Input('product')
  public product : Product;

  public quantity: number;

  constructor(@Inject(LocalStorageService) private storage: LocalStorageService, private toastrService: ToastrService) { }

  ngOnInit() {
    this.quantity = 1;
  }

  onChangeQuantity(quantity: string){
    this.quantity = parseInt(quantity);
  }

  addProductToCart(){
    let item = {
      product: this.product,
      quantity: this.quantity
    };
    if(this.quantity > 0 ){ 
      this.storage.putShoppingCart(item);
      this.toastrService.info('Agregado!', 'Mensaje');
    }
  }
}
