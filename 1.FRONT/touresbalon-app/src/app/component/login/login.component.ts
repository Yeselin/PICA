import { Component, OnInit, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';

import { LocalStorageService } from '../../service/local-storage.service';
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

  loginForm: FormGroup;
  submitted = false;
  loading = false;
  returnUrl: string;

  loginRQ: LoginRQ

  constructor(
    @Inject(LocalStorageService) private storage: LocalStorageService,
    @Inject(CustomerService) private customerService: CustomerService,
    @Inject(CrypterService) private crypterService: CrypterService,
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private toastrService: ToastrService) {

  }

  ngOnInit() {
    this.loginForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });

    // get return url from route parameters or default to '/'
    this.returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/';
  }

  get f() { return this.loginForm.controls; }

  onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.loginForm.invalid) {
      return;
    }
    this.loginRQ = {username: '', password:'', grant_type:'password'};

    this.loading = true;
    this.loginRQ.username = "yeselin.eublime@gmail.com"; //this.f.username.value;
    this.loginRQ.password = "0GMXNHHklytKFyEXctBe4A=="; //this.f.password.value; //this.crypterService.encryptText(this.f.password.value);

    this.customerService.login$(this.loginRQ).subscribe((response) => {
      this.storage.putToken(response);
      this.router.navigate(['/home']);
    }, (error) => {
      this.loading = false;
      this.toastrService.error('Credenciales inválidas', 'Ups!');
    });
  }

}
