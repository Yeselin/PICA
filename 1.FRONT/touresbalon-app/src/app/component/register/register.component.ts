import { Component, OnInit, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';

import { CrypterService } from '../../service/crypter.service';
import { CustomerService } from '../../service/customer.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'user-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  loginForm: FormGroup;
  submitted = false;
  notMatchPassword = false;

  constructor(
    @Inject(CustomerService) private customerService: CustomerService,
    @Inject(CrypterService) private crypterService: CrypterService,
    private formBuilder: FormBuilder,
    private toastrService: ToastrService,    
    private router: Router) { }

  ngOnInit() {

    this.loginForm = this.formBuilder.group({
      documentType: ['CC', Validators.required],
      document: ['', Validators.required],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      phoneNumber: ['', null],
      email: ['', Validators.required],
      password1: ['', Validators.required],
      password2: ['', Validators.required],
      country: ['', Validators.required],
      state: ['', Validators.required],
      city: ['', Validators.required],
      street: ['', Validators.required],
      zip: ['', null],
      addressType: ['', null],

    });
  }

  get f() { return this.loginForm.controls; }

  onSubmit() {
    this.submitted = true;
    if (this.loginForm.invalid) {
      return;
    }

    if (this.f.password1.value !== this.f.password2.value) {
      this.notMatchPassword = true;
      return;
    }

    let customer = {
      documentType: this.f.documentType.value,
      document: this.f.document.value,
      firstName: this.f.firstName.value,
      lastName: this.f.lastName.value,
      phoneNumber: this.f.phoneNumber.value,
      email: this.f.email.value,
      password: this.f.password1.value,
      address: {
        country: this.f.country.value,
        city: this.f.city.value,
        state: this.f.state.value,
        street: this.f.street.value,
        zip: this.f.zip.value,
        addressType: this.f.addressType.value
      }
    };    
    //Aquí se debe cifrar la data antes de mandarla
    this.customerService.createCustomer$(JSON.stringify(customer)).subscribe((response) => {
      this.router.navigate(['/success']);
    }, (error) => {
      this.toastrService.error('Ocurrió un error al crear el registro', 'Ups!');
      console.log(JSON.stringify(error));
    });
    
  }
}