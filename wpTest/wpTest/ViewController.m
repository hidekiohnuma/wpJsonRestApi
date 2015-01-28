//
//  ViewController.m
//  wpTest
//
//  Created by 大沼英喜 on 2015/01/26.
//  Copyright (c) 2015年 大沼英喜. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSString* selectedItem;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 空の配列を用意
    self.items = [NSArray array];
    
    [self getJSON];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getJSON
{
    // url取得
    NSURL *url = [NSURL URLWithString:@"http://blog.aruto.me/wp-json/posts/?filter[posts_per_page]=20&filter[orderby]=date&filter[order]=DESC"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        // アプリデータの配列をプロパティに保持
        self.items = jsonDictionary;
        
        // TableView をリロード
        [self.tableView reloadData];
    }];
}

// セルの数を設定
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}
// テーブルセルの内容を設定
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *item = [self.items objectAtIndex:indexPath.row];
//    NSLog(@"%@",item);
    // blog記事取得 title
    cell.textLabel.text = [item objectForKey:@"title"];
    
    return cell;
}
// tap action
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.items objectAtIndex:indexPath.row];
    selectedItem = [item objectForKey:@"link"];
    // toBlogViewController
    [self performSegueWithIdentifier:@"toBlogViewController" sender:self];

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"toBlogViewController"]){
        ViewController *vc = (ViewController*)[segue destinationViewController];
        vc.blogName = selectedItem;
    }
}


@end
