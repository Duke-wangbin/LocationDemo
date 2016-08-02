//
//  ViewController.m
//  LocationDemo
//
//  Created by enway_liang on 16/7/28.
//  Copyright © 2016年 wangbin. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HIGHT [UIScreen mainScreen].bounds.size.hight
#import "ViewController.h"
#import "Mapcoding.h"

@interface ViewController ()
//编码
@property (nonatomic,strong) UITextField *addressTextField;
@property (nonatomic,strong) UILabel *WeiduLabel;
@property (nonatomic,strong) UILabel *JinduLabel;
@property (nonatomic,strong) UIButton *OKbutton;

//反编码
@property (nonatomic,strong) UITextField *WeiduTextField;
@property (nonatomic,strong) UITextField *JinduTextField;
@property (nonatomic,strong) UIButton *OKbutton1;
@property (nonatomic,strong) UITextField *addressTextField1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编码与反编码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadUI];
    [self loadUI1];
}
-(void)loadUI{
    
    _addressTextField  = [[UITextField alloc]initWithFrame:CGRectMake(50, 100, WIDTH - 100, 30)];
    _addressTextField.layer.borderWidth = 1.0;
    _addressTextField.layer.cornerRadius = 5.0;
    _addressTextField.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:_addressTextField];
    _WeiduLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, WIDTH - 100, 30)];
    _WeiduLabel.text = @"   纬度:";
    _WeiduLabel.font = [UIFont systemFontOfSize:14];
    _WeiduLabel.textColor = [UIColor blackColor];
    _WeiduLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _WeiduLabel.layer.borderWidth = 1.0;
    _WeiduLabel.layer.cornerRadius = 5.0;
    [self.view addSubview:_WeiduLabel];
    _JinduLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 200, WIDTH - 100, 30)];
    _JinduLabel.text = @"   经度:";
    _JinduLabel.font = [UIFont systemFontOfSize:14];
    _JinduLabel.textColor = [UIColor blackColor];
    _JinduLabel.layer.borderWidth =1.0;
    _JinduLabel.layer.cornerRadius = 5.0;
    _JinduLabel.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_JinduLabel];
    _OKbutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_OKbutton setTitle:@"编码" forState:(UIControlStateNormal)];
    [_OKbutton setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    _OKbutton.frame = CGRectMake(WIDTH/2-25, 250, 50, 30);
    [_OKbutton addTarget:self action:@selector(OKAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_OKbutton];
}
-(void)loadUI1{
    _addressTextField1  = [[UITextField alloc]initWithFrame:CGRectMake(50, 300, WIDTH - 100, 30)];
    _addressTextField1.layer.borderWidth = 1.0;
    _addressTextField1.layer.cornerRadius = 5.0;
    _addressTextField1.userInteractionEnabled = NO;
    _addressTextField1.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:_addressTextField1];
    _WeiduTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 350, WIDTH - 100, 30)];
    _WeiduTextField.placeholder = @"   纬度:";
    _WeiduTextField.font = [UIFont systemFontOfSize:14];
    _WeiduTextField.textColor = [UIColor blackColor];
    _WeiduTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _WeiduTextField.layer.borderWidth = 1.0;
    _WeiduTextField.layer.cornerRadius = 5.0;
    [self.view addSubview:_WeiduTextField];
    _JinduTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 400, WIDTH - 100, 30)];
    _JinduTextField.placeholder = @"   经度:";
    _JinduTextField.font = [UIFont systemFontOfSize:14];
    _JinduTextField.textColor = [UIColor blackColor];
    _JinduTextField.layer.borderWidth =1.0;
    _JinduTextField.layer.cornerRadius = 5.0;
    _JinduTextField.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_JinduTextField];
    _OKbutton1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_OKbutton1 setTitle:@"反编码" forState:(UIControlStateNormal)];
    [_OKbutton1 setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    _OKbutton1.frame = CGRectMake(WIDTH/2-30, 450, 60, 30);
    [_OKbutton1 addTarget:self action:@selector(OKAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_OKbutton1];
}
-(void)OKAction:(UIButton*)sender{
    NSString *address = _addressTextField.text;
    Mapcoding *map = [[Mapcoding alloc]init];
    //如果只需要经纬度,用这个方法就行
    //    [map getMapcoding:address getlatitude:^(NSString *lat) {
    //        _WeiduLabel.text = lat;
    //    } getlongitudeStr:^(NSString *lon) {
    //        _JinduLabel.text = lon;
    //    }];
    
    //这个方法可以获取到地址的所有信息
    [map getMapcoding:address getMapcoding:^(NSMutableDictionary *mapCodDic) {
        
        _WeiduLabel.text = mapCodDic[@"latitude"];
        _JinduLabel.text = mapCodDic[@"longitude"];
        _addressTextField.text = mapCodDic[@"name"];
    }];
}
-(void)OKAction1:(UIButton*)sender{
    NSString *weidu = _WeiduTextField.text;
    NSString *jindu = _JinduTextField.text;
    Mapcoding *map = [[Mapcoding alloc]init];
    //如果只需要地址只需要这个方法
    //    [map getAddressName:weidu getlongitudeStr:jindu backAddressName:^(NSString *addressName) {
    //        _addressTextField1.text = addressName;
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"当前地点是" message:addressName delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //
    //
    //
    //    }];
    //这个方法可以获取到地址的所有信息
    
    [map getAddressName:weidu longitudeStr:jindu getMapcoding:^(NSMutableDictionary *mapCodDic) {
        _addressTextField1.text = mapCodDic[@"name"] ;
        _WeiduTextField.text = mapCodDic[@"latitude"];
        _JinduTextField.text = mapCodDic[@"longitude"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
