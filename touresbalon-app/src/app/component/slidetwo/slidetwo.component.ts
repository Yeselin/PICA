import { Component, OnInit, Inject } from '@angular/core';
import { LocalStorageService } from '../../service/local-storage.service';
import { Product } from '../../model/Product';

@Component({
  selector: 'slide-two',
  templateUrl: './slidetwo.component.html',
  styleUrls: ['./slidetwo.component.css']
})
export class SlidetwoComponent implements OnInit {

  public products: Product[];

  constructor(@Inject(LocalStorageService) private storage: LocalStorageService) { }

  ngOnInit() {
    this.products = this.storage.getLocalSlide();
  }

}
