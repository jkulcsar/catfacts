import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../environments/environment';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent {
  fact$: Observable<string>;

  // Note that this line will create the fact$ observable,
  // but no actual HTTP call will be made until we subscribe
  // to that observable!
  // For that we will use the AsyncPipe in our template
  // which will automatically subscribe/unsubscribe from
  // this observable.

  constructor(http: HttpClient) {
    this.fact$ = http.get(`${environment.apiUrl}/facts/random`, {
      responseType: 'text',
    });
  }
}
