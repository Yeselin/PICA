import { Component, OnInit, Inject } from '@angular/core';
import { LocalStorageService } from '../../service/local-storage.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  logined = false;

  constructor(@Inject(LocalStorageService) private storage: LocalStorageService) { 

  }

  ngOnInit() {
      const token = this.storage.getToken();
      this.logined = token ? true : false;
  }

}
