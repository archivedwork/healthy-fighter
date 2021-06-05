import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import { TokenStorageService } from 'app/auth/token-storage.service';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DataService {
  public API = 'https:/api-healthy-fighter.herokuapp.com/api';
  private api_url_natural =  this.API + '/products/simpleuser/producttype/natural_food';
  private api_url_users =  this.API + '/users/users';
  private api_url_vitamins =  this.API + '/products/simpleuser/producttype/vitamin';
  private api_url_product = this.API + '/products/simpleuser';
  private api_url_product_new = this.API + '/products';

  constructor(private httpClient: HttpClient, private token: TokenStorageService) { }

  public getAllNatural(): Observable<any> {
    return this.httpClient.get(this.api_url_natural);
  }


  public getAllVitamins(): Observable<any> {
    return this.httpClient.get(this.api_url_vitamins);
  }


  public getAllUsers(): Observable<any> {
    const gtoken = this.token.getToken();
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
        'Authorization': 'Bearer ' + gtoken
      })
    };
    return this.httpClient.get(this.api_url_users, httpOptions)
  }

  get(id: string) {
    return this.httpClient.get(this.api_url_product + '/' + id);
  }

  save(food: any): Observable<any> {
    let result: Observable<Object>;
    const gtoken = this.token.getToken();
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
        'Authorization': 'Bearer ' + gtoken
      })
    };
    console.log(food);
    if (food['id']) {
      result = this.httpClient.put(this.api_url_product_new + '/' + food['id'], food, httpOptions);
    } else {
      result = this.httpClient.post(this.api_url_product_new, food, httpOptions);
    }
    return result;
  }

  remove(href: string) {
    const gtoken = this.token.getToken();
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
        'Authorization': 'Bearer ' + gtoken
      })
    };
    return this.httpClient.delete(this.api_url_product_new + '/' + href, httpOptions);
  }
}
