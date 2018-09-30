import { Component, OnInit, Inject } from '@angular/core';
import { ProductService } from './../../service/product.service';
import { Product } from '../../model/Product';
import { LocalStorageService } from '../../service/local-storage.service';

@Component({
  selector: 'slider-products',
  templateUrl: './slider.component.html',
  styleUrls: ['./slider.component.css']
})
export class SliderComponent implements OnInit {

  public listTypes: any;
  public selectedObj: any;
  public selectedTypeId: string;

  public products: Product[];

  public sliderEnable = true;

  constructor(@Inject(LocalStorageService) private storage: LocalStorageService, @Inject(ProductService) private productService: ProductService) { }

  ngOnInit() {
    this.products = this.storage.getLocalSlide();
    this.listTypes = [];
    this.listTypes.push({ id: 0, label: "Todos" });
    this.listTypes.push({ id: 1, label: "Id" });
    this.listTypes.push({ id: 2, label: "Nombre" });
    this.listTypes.push({ id: 3, label: "Descripción" });
    this.selectedObj = this.listTypes[0];
  }


  changeSelectType(changeId: number) {
    this.selectedObj = this.listTypes[changeId];
  }

  onEnter(param: string): void {

    if (param !== '') {
      this.productService.getFindProduct$(this.selectedObj.id, param).subscribe((response) => {
        if (response.length > 0) {
          this.sliderEnable = false;
          this.products = response;
        }
      }, (error) => {
        console.error(error);
      });
    }

  }
}
