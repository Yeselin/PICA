import { Component, OnInit, Inject } from '@angular/core';
import { ProductService } from './../../service/product.service';
import { Product } from '../../model/Product';

@Component({
  selector: 'search-products',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {

  listTypes : any;  
  selectedObj: any;
  selectedTypeId: string;

  constructor(@Inject(ProductService) private productService: ProductService) { }

  ngOnInit() {
    this.listTypes = [];
    this.listTypes.push({id: 0, label: "Todos"});
    this.listTypes.push({id: 1, label: "Id"});
    this.listTypes.push({id: 2, label: "Nombre"});
    this.listTypes.push({id: 3, label: "Descripción"});
    this.selectedObj = this.listTypes[0]; 
  }

  changeSelectType(changeId: number){
    this.selectedObj = this.listTypes[changeId];  
  }
  onEnter(param: string): Product[] {
  
    let product: Product[];

    
  /*
    this.productService.getFindProduct$(this.findBy, param).subscribe((response) => {
      product = response;
    }, (error) => {
      console.error(error);
    });
    */
    console.info(param);
    param = '';
    return product;
  }

}
