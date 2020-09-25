//
//  ViewController.m
//  OCdatePickerView
//
//  Created by 明 on 2020/9/24.
//

#import "ViewController.h"
#import "ZMDatePickerView.h"

@interface ViewController ()
@property (nonatomic)ZMDatePickerView *datePickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.datePickerView];
   
    
    [self.datePickerView setMinYear:2000 minMonth:12 minDay:11];
    [self.datePickerView setMaxYear:2030 maxMonth:2 maxDay:15];
    
    [self.datePickerView show];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view addSubview:self.datePickerView];
}

- (ZMDatePickerView *)datePickerView {
    
    if (!_datePickerView) {
        _datePickerView = [[ZMDatePickerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    }
    
    return _datePickerView;
}

@end
