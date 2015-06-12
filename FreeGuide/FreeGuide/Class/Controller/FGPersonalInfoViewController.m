//
//  FGPersonalInfoViewController.m
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import "FGPersonalInfoViewController.h"
#import "FGLoginViewController.h"
#define CellTextFont [UIFont systemFontOfSize:16]
#define CellRedColor LJHColor(220, 87, 80)
@interface FGPersonalInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *iconView;
@end

@implementation FGPersonalInfoViewController

#pragma mark - Life Circle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = LJHColor(235, 235, 235);
    [self setupNav];
    [self setupSubViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"头像";
            
            [cell.contentView addSubview:self.iconView];
            [self.iconView makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.right).offset(-10);
                make.centerY.equalTo(cell.contentView.centerY);
                make.height.equalTo(@(80));
                make.width.equalTo(@(80));
            }];
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"名字";
            cell.detailTextLabel.text = @"FreeGuide";
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"账号";
            cell.detailTextLabel.text = @"freeguide-001";
        }
        else if (indexPath.row == 3)
        {
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = @"男";
        }
        else
        {
            cell.textLabel.text = @"年龄";
            cell.detailTextLabel.text = @"21";
        }
    }
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = @"支付信息";
        cell.detailTextLabel.text = @"已绑定支付宝";
    }
    else if (indexPath.section == 2)
    {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"退出登录";
        label.font = CellTextFont;
        label.textColor = CellRedColor;
        
        [cell.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView.centerX);
            make.centerY.equalTo(cell.contentView.centerY);
        }];
        return cell;
        
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return 100;
        }
        else
        {
            return 44;
        }
    }
    else
    {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            [self.view.window  showPopWithButtonTitles:@[@"拍照",@"从手机相册选择"] styles:@[YUDefaultStyle,YUDefaultStyle] whenButtonTouchUpInSideCallBack:^(int index  ) {
                if (index == 0)
                {
                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                    picker.delegate = self;
                    picker.allowsEditing = NO;//设置可编辑
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
                }
                else if (index == 1)
                {
                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                    imagePicker.delegate = self;
                    imagePicker.allowsEditing = YES;
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
            }];
        }
        else if (indexPath.row == 1)
        {
            [ProgressHUD showSuccess:@"您的名字是FreeGuide!"];
        }
        else if (indexPath.row == 2)
        {
            [ProgressHUD showSuccess:@"您的账号是freeguide-001"];
        }
        else if (indexPath.row == 3)
        {
//            [ProgressHUD showSuccess:@"您的性别为男"];
        }
        else
        {
//            [ProgressHUD showSuccess:@"您的账号是freeguide-001"];
        }
    }
    else if (indexPath.section == 1)
    {
        [ProgressHUD showSuccess:@"您已绑定了支付宝!"];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定退出登录?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:kLoginKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            self.view.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[FGLoginViewController alloc]initWithNibName:@"FGLoginViewController" bundle:nil]];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:commitAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:^{
        // 2.获得图片
        UIImage *editedImage, *originalImage;
        editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        self.iconView.image = editedImage;
        

        // 保存原图片到相册中
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageWriteToSavedPhotosAlbum(originalImage, self, nil, NULL);
        }
        //设置状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - event response
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private methods
- (void)setupNav
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"个人信息";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"default_common_navibar_prev_normal" highIcon:@"default_common_navibar_prev_normal" target:self action:@selector(back)];
}


- (void)setupSubViews
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = LJHColor(235, 235, 235);
    [self.view addSubview:self.tableView];
}

#pragma mark - getters and setters
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.jpg"]];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 10.0;
        _iconView.layer.borderWidth = 0.5;
        _iconView.layer.borderColor = [UIColor colorWithHexString:@"0xdddddd"].CGColor;
    }
    return _iconView;
}


@end
