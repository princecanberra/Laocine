//
//  Firstcine.m
//  Laocinema
//
//  Created by ouphachay thongsamouth on 2/09/13.
//  Copyright (c) 2013 Amona. All rights reserved.
//

#import "Firstcine.h"

@interface Firstcine (){
    
    NSString *imagename;
    
    
    
}

@end

@implementation Firstcine

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    spiner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spiner setCenter:CGPointMake(140,20)]; // I do this because I'm in landscape mode
    [self.view addSubview:spiner]; // spinner is not visible until started
    
    
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    
    
    // dis play all the movie's data after first cinema loaded
   
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/LaoCinema/first.php"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
   /* NSArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
   
   
        
    NSDictionary *dict = [json objectAtIndex:0];
    name.text = [dict valueForKey:@"name"];
    time.text = [dict valueForKey:@"time"];
    date.text = [dict valueForKey:@"date"];
    price.text = [dict valueForKey:@"price"];
    
    // then display photo 
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(75, 87, 170, 170)];
    image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dict valueForKey:@"photo" ]]]];
    
    [self.view addSubview:image];
                                          
    */
    
    //add a UIActivityIndicatorView to your nib file and add an outlet to it
    [spiner startAnimating];
    spiner.hidesWhenStopped = YES;
    
    dispatch_queue_t queue = dispatch_get_global_queue(
                                                       DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        //Load the json on another thread
        
        NSArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        
        
        
        NSDictionary *dict = [json objectAtIndex:0];
        name.text = [dict valueForKey:@"name"];
        time.text = [dict valueForKey:@"time"];
        date.text = [dict valueForKey:@"date"];
        price.text = [dict valueForKey:@"price"];
        
        // then display photo
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(75, 87, 170, 170)];
        image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dict valueForKey:@"photo" ]]]];
        
        [self.view addSubview:image];
        
        
        //When json is loaded stop the indicator
        [spiner performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
    });
 
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
