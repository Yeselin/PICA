import { Component, OnInit, Inject } from '@angular/core';
import { ProductService } from './../../service/product.service';
import { Product } from '../../model/Product';
import { LocalStorageService } from '../../service/local-storage.service';
import { ToastrService } from 'ngx-toastr';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'comapings',
  templateUrl: './campaing.component.html',
  styleUrls: ['./campaing.component.css']
})
export class CampaingComponent implements OnInit {
 
  public products: Product[];

  /**
   * 
   * @param storage 
   * @param productService 
   * @param toastrService 
   */
  constructor(@Inject(LocalStorageService) private storage: LocalStorageService, 
      @Inject(ProductService) private productService: ProductService,
      private toastrService: ToastrService) { }

  ngOnInit() {
    this.products = this.storage.getCampaigns();
  }


  getImageRef(image_ref: string): string {
    return environment.BASE_IMAGE  + image_ref;
  }
}
