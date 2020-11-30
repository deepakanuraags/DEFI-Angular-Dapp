import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DappHomeComponent } from './dapp-home.component';

describe('DappHomeComponent', () => {
  let component: DappHomeComponent;
  let fixture: ComponentFixture<DappHomeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DappHomeComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DappHomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
