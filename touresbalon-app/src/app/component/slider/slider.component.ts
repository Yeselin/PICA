import { Component, OnInit, Inject } from '@angular/core';
import { Product } from '../../model/Product';
import { LocalStorageService } from '../../service/local-storage.service';

@Component({
  selector: 'slider-products',
  templateUrl: './slider.component.html',
  styleUrls: ['./slider.component.css']
})
export class SliderComponent implements OnInit {

  public products: Product[];

  constructor(@Inject(LocalStorageService) private storage: LocalStorageService) { }

  ngOnInit() {
      this.products = this.storage.getLocalSlide();
  }

}
