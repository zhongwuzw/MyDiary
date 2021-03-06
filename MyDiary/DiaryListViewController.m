//
//  DiaryListViewController.m
//  MyDiary
//
//  Created by 刘铭 on 12-11-14.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "DiaryListViewController.h"
#import "DetailDiaryViewController.h"
#import "Diary.h"
#import "DiaryStore.h"
#import "DiaryListTableViewCell.h"
#import "AppDelegate.h"
#import "UserListItem.h"
#import "MJRefresh.h"
#import "ScrollTestView.h"


@interface DiaryListViewController ()

@end

@implementation DiaryListViewController

static NSString *CellTableIdentifier = @"CellTableIdentifier";

- (void)footerRefreshing
{
    self.pullUpUserListOperation = [ApplicationDelegate.xzxmEngine homePageUserList:@"123" completionHandler:^(NSMutableArray *userListArray){
        self.computers = userListArray;
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        
    }errorHandler:^(NSError *error){
        DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
    }];
}

-(UIView *)headerView
{
    //如果还没有载入headerView的话...
    if (!_headerView) {
        //载入HeaderView.xib资源
        _headerView = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"headerTableViewCell"
                                      owner:self options:nil] objectAtIndex:0];
    }
    return _headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 获取数组中选中行的Diary对象
  //  Diary *diary = [self.diaries objectAtIndex:row];
    
    // 通过segue获取被故事板初始化的对象，然后将数据传递给它
//    DetailDiaryViewController *detailDiaryViewController = [[DetailDiaryViewController alloc] init];
//    detailDiaryViewController.diary = [[Diary alloc] initWithTitle:@"shit" content:@"sdha"];
   // detailDiaryViewController.diary = diary;
  //  [self performSegueWithIdentifier:@"DetailDiary" sender:self];
    DetailDiaryViewController *detailDiaryController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailDiary"];
    Diary *diary = [[Diary alloc] initWithTitle:@"haha" content:@"zw"];
    detailDiaryController.diary = diary;

    [self.navigationController pushViewController:detailDiaryController animated:YES];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailDiary"]) {
        // 获取表格中被选择的行
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // 获取数组中选中行的Diary对象
    //    Diary *diary = [self.diaries objectAtIndex:row];
        Diary *diary = [[Diary alloc] initWithTitle:@"haha" content:@"zw"];

        
        // 通过segue获取被故事板初始化的对象，然后将数据传递给它
        DetailDiaryViewController *detailDiaryViewController = (DetailDiaryViewController *)[segue destinationViewController];
        detailDiaryViewController.diary = diary;
    }
    
    if ([segue.identifier isEqualToString:@"AddDiary"]) {
        CreateDiaryViewController *createDiaryViewController = (CreateDiaryViewController *)[segue destinationViewController];
        // 设置createDiaryViewController对象的delegate属性
        createDiaryViewController.delegate = self;
    }

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        NSLog(@"这个会执行吗");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    // 设置导航栏的标题
    [[self navigationItem] setTitle:@"推荐"];
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    tableView.rowHeight = 125;
    
    UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    self.userListOperation = [ApplicationDelegate.xzxmEngine homePageUserList:@"123" completionHandler:^(NSMutableArray *userListArray){
        self.computers = userListArray;
        [self.tableView reloadData];
        
    }errorHandler:^(NSError *error){
        NSLog(@"zhongwu error");
        DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
    }];
    
 //   self.tableView.tableHeaderView = [self headerView];
    ScrollTestView *scrollTestView = [[ScrollTestView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
  //  self.tableView.tableHeaderView = scrollTestView;
    
    UISearchBar *b = [[UISearchBar alloc] init];
    [b sizeToFit];
    b.delegate = self;
    [self.tableView setTableHeaderView:b];
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    UISearchDisplayController *c = [[UISearchDisplayController alloc] initWithSearchBar:b contentsController:self];
    self.sbc = c;
    c.delegate = self;
    c.searchResultsDataSource = self;
    c.searchResultsDelegate = self;
    
    // 创建刷新控件
    self.refresh = [[UIRefreshControl alloc] init];
    self.refreshControl = self.refresh;
    [self.refresh addTarget:self
                            action:@selector(handleRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    
  //  [self.navigationController setToolbarHidden:NO animated:YES];
    
}

-(void)handleRefresh:(id)sender
{
    
    if (self.refresh.refreshing) {
        self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
        
        self.pullDownUserListOperation = [ApplicationDelegate.xzxmEngine homePageUserList:@"123" completionHandler:^(NSMutableArray *userListArray){
            
            self.computers = userListArray;
            
            [self.refresh endRefreshing];
            [self.tableView reloadData];
        //    NSLog(@"computer is %@",self.computers);
            
        }errorHandler:^(NSError *error){
            DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    // 从DiaryStore中获取存储的数据
    self.diaries = (NSMutableArray *)[[DiaryStore defaultStore] diaries];
    
    self.diaryTitleColor = [self diaryTitleColorFromPreferenceSpecifiers];
    
    [super viewWillAppear:animated];
}

-(UIColor *)diaryTitleColorFromPreferenceSpecifiers
{
    // 获取应用程序配置选项的实例
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 根据diaryTitleColor的值设置表格中日记标题的颜色
    if ([[defaults objectForKey:@"diaryTitleColor"]
         isEqualToString:@"black"]) {
        return [UIColor blackColor];
    }else if([[defaults objectForKey:@"diaryTitleColor"]
              isEqualToString:@"red"]){
        return [UIColor redColor];
    }else if([[defaults objectForKey:@"diaryTitleColor"]
              isEqualToString:@"green"]){
        return [UIColor greenColor];
    }else if([[defaults objectForKey:@"diaryTitleColor"]
              isEqualToString:@"blue"]){
        return [UIColor blueColor];
    }else{
        return [UIColor blackColor];
    }
}

-(void)addNewDiary:(id)sender
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) listenAudio:(UIButton *)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    
    if (cell != nil) {
        NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    
    }
    
    /* 获取了用户点击的哪行单元格的指示器以后，可以播放该日记的音频信息。 */
}

#pragma mark - Create Diary View Controller Delegate
-(void)createDiaryViewControllerDidCancel:(CreateDiaryViewController *)createDiaryController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createDiaryViewController:(CreateDiaryViewController *)createDiaryController
                didSaveWithDiary:(Diary *)theDiary
{
    Diary *diary = theDiary;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.diaries addObject:diary];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   // return self.diaries.count;
    int count = [self.computers count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
//    if([indexPath row] == [self.computers count])
//    {
//        return cell;
//    }
    UserListItem *rowData = self.computers[indexPath.row];

    self.userProfileOperation = [ApplicationDelegate.xzxmEngine getProfilePic:rowData.profileImage completionHandler:^(UIImage *proImage){
        
        cell.profileImage.image = proImage;
       // [self.profilePicDic setValue:proImage forKey:rowData.profileImage];
    }errorHanler:^(NSError *error){
        DLog(@"%@\t%@\t%@\t%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoveryOptions],[error localizedRecoverySuggestion]);
    }];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
    view.backgroundColor = [UIColor grayColor];
    [cell.contentView addSubview:view];
    
 //   cell.name = rowData[@"Name"];
    cell.nameValue.text = rowData.userName;
  //  cell.infoImage.image = [UIImage imageNamed:@"chat_time_backgroud"];
    cell.colorValue.backgroundColor = [UIColor grayColor];
    NSString *finalValue = [[NSString alloc] initWithFormat:@"%@岁/%@cm/%@",rowData.age,rowData.height,rowData.school];
    cell.colorValue.text = finalValue;
    cell.colorValue.layer.cornerRadius = 10;
    
    cell.introduce.numberOfLines = 2;
    cell.introduce.text = @"关于我，每天清晨起来，看到你和阳光同在，这就是我想要的生活";
//    cell.colorValue.text = rowData.school;

    cell.colorValue.textColor = [UIColor whiteColor];

    cell.vipImage.image = [UIImage imageNamed:@"desktop_notice_realname"];
    
 //   cell.color = rowData[@"Color"];
    
  //  NSLog(@"Cell recursive description:\n\n%@\n\n",[cell performSelector:@selector(recursiveDescription)]);
    
//    cell.backgroundColor = [UIColor purpleColor];
//    cell.contentView.backgroundColor = [UIColor blueColor];
//    
//    for (UIView *view in cell.subviews) {
//        if ([view isKindOfClass:[UIScrollView class]]) {
//            view.backgroundColor = [UIColor greenColor];
//        }
//    }
    
    cell.delegate = self;
    
    return cell;
    // CellIdentifier所指向的字符串必须与故事板中Table View Cell对象的Indentifier属性一致
//    static NSString *CellIdentifier = @"DiaryCell";
//    UITableViewCell *cell = [tableView
//                             dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(0.0f, 0.0f, 150.0f, 25.0f);
//    
//    [button setTitle:@"听录音" forState:UIControlStateNormal];
//    
//    [button addTarget:self
//               action:@selector(listenAudio:)
//     forControlEvents:UIControlEventTouchUpInside];
//    
//    cell.accessoryView = button;
//    
//    cell.indentationWidth = 10;
//    cell.indentationLevel = indexPath.row;
//    
//    Diary *diary = [self.diaries objectAtIndex:indexPath.row];
//    
//    cell.textLabel.text = [diary title];
//    cell.textLabel.textColor = self.diaryTitleColor;
//    
//    cell.detailTextLabel.text = [[diary dateCreate] description];
//    
//    return cell;
}

- (void)buttonOneActionForItemText:(NSString *)itemText
{
    NSLog(@"in the delegate ,clicked button one for %@",itemText);
}

- (void)buttonTwoActionForItemText:(NSString *)itemText
{
    NSLog(@"in the delegate ,clicked button two for %@",itemText);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
}

//- (UIView *)tableView:(UITableView *)tableView
//viewForHeaderInSection:(NSInteger)section
//{
//    return [self headerView];
//}

//-(CGFloat)tableView:(UITableView *)tableView
//heightForHeaderInSection:(NSInteger)section
//{
//    return [[self headerView] bounds].size.height;
//}

/*
- (UIView *) tableView:(UITableView *)tableView
viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = nil;
    if (section == 0)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = @"日记列表的结尾";
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
 
        label.frame = CGRectMake(label.frame.origin.x + 10.0f,
                                 5.0f,
                                 label.frame.size.width, label.frame.size.height);

        CGRect frame = CGRectMake(0.0f, 0.0f,label.frame.size.width + 10.0f,
                                  label.frame.size.height);
        footerView = [[UIView alloc] initWithFrame:frame];
        [footerView addSubview:label];
    }
    return footerView;
}
 */

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *diarys = [[DiaryStore defaultStore] diaries];
        Diary *d = [diarys objectAtIndex:[indexPath row]];
        [[DiaryStore defaultStore] removeDiary:d];
        
        // 从表格视图中移除被删除的单元格，并且使用动画效果
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[DiaryStore defaultStore] moveDiaryAtIndex:[fromIndexPath row]
                                        toIndex:[toIndexPath row]];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
