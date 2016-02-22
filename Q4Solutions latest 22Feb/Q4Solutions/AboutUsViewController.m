//
//  AboutUsViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/4/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "AboutUsViewController.h"
#import "WebServiceConnection.h"
#import "Indicator.h"

@interface AboutUsViewController ()
{
    WebServiceConnection *aboutUsCon;
    Indicator *indicator;
    NSString *check_status;
    
    NSString *clikable;
    
    CGRect s;
}

@end

@implementation AboutUsViewController
@synthesize scrollView,aboutUs_lable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textTapped:)];
    
   // [self.aboutUs_lable addGestureRecognizer:tap];

    
    
    aboutUsCon = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    [self getData];
    

    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    
    NSDictionary *urlparam;
    
    [self.view addSubview:indicator];

    [aboutUsCon startConnectionWithString:[NSString stringWithFormat:@"about_us"] HttpMethodType:Post_Type HttpBodyType:urlparam Output:^(NSDictionary *receivedData)
     {
          [indicator removeFromSuperview];
         
         //   NSString *msg;
         
         NSLog(@"%@",receivedData);
         
         if([aboutUsCon responseCode]==1) {
             
             NSString *msg = [receivedData valueForKey:@"msg"];
             
             NSDictionary *data=[receivedData valueForKey:@"data"];
             
             if([receivedData count]>1) {
                 
                 if ([msg isEqualToString:@"success"]) {
                     
                   // NSString *title=[[data valueForKey:@"Cmspage"] valueForKey:@"title"];
                     
                    NSString *description=[[data valueForKey:@"Cmspage"] valueForKey:@"description"];
                     
                     NSInteger starRange,tolatChar,totalLength;
                     
                     NSString *str;
                     
                    NSArray *localizedStringPieces = [description componentsSeparatedByString:@" "];
                     
                     clikable =  @"www.q4solutions.com.";
                     
                     totalLength =  [description length];
                     
                     starRange = totalLength-[clikable length]-1;
                     
                     tolatChar = [clikable length];
                     
                     NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:description];
                     
                     [string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(teal_text_color_hexcode) range:NSMakeRange(starRange,tolatChar)];
                     
                     aboutUs_lable.attributedText = string;
                     
                     
                     
                     
                     for (str in localizedStringPieces) {
                         
                         if ([str isEqualToString:@"www.q4solutions.com."]){
                    
                             
                             NSLog(@"%ld",(long)starRange);
                              NSLog(@"%ld",(long)tolatChar);
                             
     
                         }
                         
                     }
                     
                     SEL selectorAction = clikable ? @selector(tapOnTermsOfServiceLink:): nil;
                     
                     UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selectorAction];
                     
                     [aboutUs_lable addGestureRecognizer:tapGesture];
                
                     //self.title=title;
                     
                     //  aboutUs_lable.text=description;
                     
                     aboutUs_lable.userInteractionEnabled = YES;
                     
                     aboutUs_lable.numberOfLines = 0;
                     
                     [aboutUs_lable sizeToFit];
                     
                     //NSInteger lines  = aboutUs_lable.numberOfLines;
                     
                     //NSLog(@"%ld",(long)lines);
                     
                //  s =   [ self getXOriginOfString:clikable fromString:string inLabel:aboutUs_lable];
                     
                      scrollView.contentSize = CGSizeMake(self.view.frame.size.width,aboutUs_lable.frame.origin.y + aboutUs_lable.frame.size.height+50);
                     
                     }else{
                         
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"AboutUs" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     
                     [alert show];
                    }
              }
          }
     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)tapOnTermsOfServiceLink:(UITapGestureRecognizer *)recognizer
{
    

    
    CGPoint touchPoint = [recognizer locationInView: aboutUs_lable];
    
    //modify the validFrame that you would like to enable the touch
    //or get the frame from _yourLabel using the NSMutableAttributedString, if possible
    CGRect validFrame;
    
  //  NSLog(@"",s);
    
    if (self.view.frame.size.width==320) {
    
          validFrame = CGRectMake(0,aboutUs_lable.frame.size.height-15,150, 21);
    
    }else if(self.view.frame.size.width==375){
        
         validFrame = CGRectMake(80,aboutUs_lable.frame.size.height-15,150, 21);
        
    }else{
        
        validFrame = CGRectMake(210,aboutUs_lable.frame.size.height-15,170, 21);
        
    }


    if ( YES == CGRectContainsPoint(validFrame, touchPoint )){
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://q4solutions.com"]];
        
       }
}

- (CGRect)getXOriginOfString:(NSString *)string fromString:(NSString *)sentenceString inLabel:(UILabel *)label {
    
    CGFloat  labelWidth = aboutUs_lable.frame.size.width;
    NSRange range = [sentenceString rangeOfString:string];
    NSString *prefix = [sentenceString substringToIndex:range.location];
    CGRect labelFrame = label.frame;
    
     UIFont *font = [UIFont boldSystemFontOfSize:19];
    
    NSStringDrawingContext *stringDrawingContext = [[NSStringDrawingContext alloc] init];
    
    stringDrawingContext.minimumScaleFactor = label.minimumScaleFactor;
    
    CGRect prefixFrame = [prefix boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, labelFrame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:stringDrawingContext];
    
    CGRect substringFrame = [string boundingRectWithSize:labelFrame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:stringDrawingContext];
    
    prefixFrame = CGRectIntegral(prefixFrame);
    substringFrame = CGRectIntegral(substringFrame);
    
    
    
    
    BOOL isOnNextLine = prefixFrame.size.width >= labelWidth;
    
    CGFloat left = prefixFrame.size.width - (isOnNextLine ? labelWidth : 0); // the substrings on the other lines are offset by the label frame's width
    CGFloat top = isOnNextLine ? substringFrame.size.height : 0; // the substrings on the other lines have the top position equal to it's height
    CGFloat width = substringFrame.size.width;
    CGFloat height = substringFrame.size.height;
    
    return CGRectMake(left, top, width, height);

}

@end
