//
//  TTRegViewController.m
//  TestTask
//
//  Created by Дмитрий Фролов on 18.03.17.
//  Copyright © 2017 Дмитрий Фролов. All rights reserved.
//

#import "TTRegViewController.h"


static NSArray *SCOPE = nil;

@interface TTRegViewController () 

@property (nonatomic, strong)VKAccessToken *res;


@end

@implementation TTRegViewController





- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"Регистрация"];
    
    SCOPE = @[VK_PER_FRIENDS, VK_PER_VIDEO, VK_PER_PHOTOS, VK_PER_EMAIL, VK_PER_MESSAGES];
    [super viewDidLoad];
    [[VKSdk initializeWithAppId:@"5932562"] registerDelegate:self];
    [[VKSdk instance] setUiDelegate:self];
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            _res = [VKSdk accessToken];
            
            [self startWorking];
        } else if (error) {
            [[[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }];
    
    UIButton *authBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 396, 343, 33)];
    [authBtn setTitle:@"Войти через ВКонтакте" forState:UIControlStateNormal];
    [authBtn setBackgroundColor:[UIColor blueColor]];
    [authBtn addTarget:self action:@selector(authorize) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:authBtn];
    [authBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[authBtn]-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(authBtn)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(==300)-[authBtn(==33)]-(==150)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(authBtn)]];
}

- (void)startWorking {
    TTMainViewController *mainView = [[TTMainViewController alloc]init];
    mainView.currentUserToken = self.res;
    [self.navigationController pushViewController: mainView animated:YES];
  
}



- (IBAction)authorize {
    [VKSdk authorize:SCOPE];
}




- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    [self authorize];
}

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token ) {
        self.res = result;
        [self startWorking];
    } else if (result.error) {
        [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Access denied\n%@", result.error] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}


- (void)vkSdkUserAuthorizationFailed {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Access denied" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self.navigationController.topViewController presentViewController:controller animated:YES completion:nil];
}






@end
