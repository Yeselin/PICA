import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import * as CryptoJS from 'crypto-js';

@Injectable({
  providedIn: 'root'
})
export class CrypterService {

  constructor() { }

  public encryptText(plainText: string): string {
    /*
    let ivec = CryptoJS.lib.WordArray.create(128);
    let ciphertext = CryptoJS.AES.encrypt(plainText, atob(environment.PUBLIC_KEY), {
      iv: ivec.toString(),
		  mode: CryptoJS.mode.CBC,
		  padding: CryptoJS.pad.Pkcs7   
    });      
    */
    let ciphertext = CryptoJS.AES.encrypt(plainText, atob(environment.PUBLIC_KEY));
    return ciphertext.ciphertext;
  }

  public encryptObject(object: any): string {
    let ciphertext = CryptoJS.AES.encrypt(JSON.stringify(object), atob(environment.PUBLIC_KEY));
    return ciphertext.toString(); //ciphertext.toString(CryptoJS.enc.Base64);
  }

  public decrypt(encrypted: string): string {
    let bytes = CryptoJS.AES.decrypt(encrypted, atob(environment.PUBLIC_KEY));
    return bytes.toString(CryptoJS.enc.Utf8);
  }
}
