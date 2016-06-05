//
//  PanoramaViewController.m
//  MyImageApp
//
//  Created by Mark on 16/5/24.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "PanoramaViewController.h"

@interface PanoramaViewController ()
@property (nonatomic) MHImagePickerMutilSelector *imagePickerMutilSelector;
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic) PanoramaPicViewController * picViewController;
@property (nonatomic) bool mergeSucess;
@end

@implementation PanoramaViewController

//delegate to MHImagePickerMutilSelector
-(void)imagePickerMutilSelectorDidGetImages:(NSArray *)imageArray
{
    self.capturedImage =[[NSMutableArray alloc] initWithArray:imageArray copyItems:YES];
    
    _picViewController.selImages = [[NSMutableArray alloc]initWithArray:self.capturedImage];
    _mergeSucess = true;
}

//


- (IBAction)photoLibrary:(id)sender {
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}


- (IBAction)camera:(id)sender {
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType{
    if (self.capturedImage.count > 0)
    {
        [self.capturedImage removeAllObjects];
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    //imagePickerController.allowsEditing = true;
    imagePickerController.sourceType = sourceType;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        //imagePickerController.showsCameraControls = NO;
        imagePickerController.delegate = self;
    }
    else
    {
        MHImagePickerMutilSelector* imagePickerMutilSelector=[MHImagePickerMutilSelector standardSelector];//自动释放
        imagePickerMutilSelector.delegate=self;//设置代理
        
        imagePickerController.delegate=imagePickerMutilSelector;//将UIImagePicker的代理指向到imagePickerMutilSelector
        [imagePickerController setAllowsEditing:NO];
        imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
        imagePickerController.navigationController.delegate=imagePickerMutilSelector;//将UIImagePicker的导航代理指向到imagePickerMutilSelector
        
        imagePickerMutilSelector.imagePicker=imagePickerController;//使imagePickerMutilSelector得知其控制的UIImagePicker实例，为释放时需要。
        self.imagePickerMutilSelector = imagePickerMutilSelector;
        //[imagePickerController release];
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.capturedImage = [[NSMutableArray alloc]init];
    _mergeSucess = false;
    _picViewController = [[PanoramaPicViewController alloc]init];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    if(_mergeSucess == true)
    {
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:_picViewController];
        nav.navigationItem.title = @"编辑图片"
        [self.navigationController pushViewController:_picViewController animated:true];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.capturedImage addObject:image];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
