import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import * as CryptoJS from 'crypto-js';

@Injectable({
  providedIn: 'root'
})
export class CrypterService {

  constructor() { }

  public encryptText(plainText: string): string {
    let ciphertext = CryptoJS.AES.encrypt(plainText, environment.PUBLIC_KEY);
    return ciphertext.toString(); //ciphertext.toString(CryptoJS.enc.Base64);
  }

  public encryptObject(object: any): string {
    let ciphertext = CryptoJS.AES.encrypt(JSON.stringify(object), environment.PUBLIC_KEY);
    return ciphertext.toString(); //ciphertext.toString(CryptoJS.enc.Base64);
  }

  public decrypt(encrypted: string): string {    
    let bytes = CryptoJS.AES.decrypt(encrypted, environment.PUBLIC_KEY);
    return bytes.toString(CryptoJS.enc.Utf8);
  }
}
