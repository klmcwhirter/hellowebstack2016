import { Component, OnInit } from '@angular/core';
import { ValuesService } from './values.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  providers: [ValuesService]
})
export class AppComponent implements OnInit {
  title = 'Values';
  values: string[];

  ngOnInit() {
    this.getValues();
  }
  constructor(
    private valuesService: ValuesService
  ) {}

  getValues() {
    this.valuesService.getValues()
      .subscribe(
        values => this.values = values
      );
  }

}
