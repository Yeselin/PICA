import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'search-bar',
  templateUrl: './search-bar.component.html',
  styleUrls: ['./search-bar.component.css']
})
export class SearchBarComponent implements OnInit {

  public listTypes: any;
  public selectedObj: any;

  constructor(private router: Router, private toastrService: ToastrService) {

  }

  ngOnInit() {
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

  findProducts(value: string) {
    if(value !== ''){
      const parameters = { parameterType: this.selectedObj.id, parameterValue: value };
      this.router.navigate(['/list-products'], { queryParams: parameters });
    }else{
      this.toastrService.warning('Ingresa un valor para filtar', 'Ups!');
    }
    
  }
}
