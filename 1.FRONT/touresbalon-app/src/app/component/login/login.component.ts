import { Component, OnInit, Inject } from '@angular/core';
import { CrypterService } from '../../service/crypter.service';
import { CustomerService } from '../../service/customer.service';
import { ToastrService } from 'ngx-toastr';

import { LoginRQ, LoginRS } from './../../model/Login';

@Component({
  selector: 'login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  loginRS: LoginRS;

  constructor(@Inject(CustomerService) private customerService: CustomerService,
    @Inject(CrypterService) private crypterService: CrypterService,
    private toastrService: ToastrService,
    private loginRQ: LoginRQ) {

  }

  ngOnInit() {
  }

  
  onSubmit() {
    this.loginRQ.password = this.crypterService.encryptText(this.loginRQ.password);
    this.customerService.login$(this.loginRQ).subscribe((response) => {
      this.loginRS = response;
    }, (error) => {
      this.toastrService.error('Parece que hay problemas', 'Ups!');
    });
  }
}
