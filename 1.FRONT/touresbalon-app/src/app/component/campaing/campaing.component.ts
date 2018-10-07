import { Component, OnInit, Inject } from '@angular/core';
import { ProductService } from './../../service/product.service';
import { Product } from '../../model/Product';
import { LocalStorageService } from '../../service/local-storage.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'comapings',
  templateUrl: './campaing.component.html',
  styleUrls: ['./campaing.component.css']
})
export class CampaingComponent implements OnInit {
 
  public products: Product[];

  constructor(@Inject(LocalStorageService) private storage: LocalStorageService, 
      @Inject(ProductService) private productService: ProductService,
      private toastrService: ToastrService) { }

  ngOnInit() {
    this.products = this.storage.getLocalSlide();
  }

  onEnter(by: string, param: string): void {
    if (param !== '') {
      this.productService.getFindProduct$(by, param).subscribe((response) => {
        if (response.length > 0) {
          this.products = response;
        }else{
          this.toastrService.info('Sin resultados','Mensaje!');
        }
      }, (error) => {
        console.error(error);
      });
    }else{
      this.toastrService.warning('Indique un valor', 'Mesaje!');
    }
  }

}
