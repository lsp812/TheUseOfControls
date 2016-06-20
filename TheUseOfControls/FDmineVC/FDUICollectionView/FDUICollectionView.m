//
//  FDUICollectionView.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDUICollectionView.h"
#import "CollectionCell.h"
@interface FDUICollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation FDUICollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self newControls];
}
-(void)newControls
{
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 64, self.view.frame.size.width, self.view.frame.size.height-64-49) collectionViewLayout:flowLayout];
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor whiteColor];
    [collection registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    self.collectionView = collection;
    [self.view addSubview:self.collectionView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(95, 116);
}

//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    //图片名称
    //    NSString *imageToLoad = [NSString stringWithFormat:@"%d.png", indexPath.row];
    NSString *imageToLoad = [NSString stringWithFormat:@"shuffingImage%ld.png",(indexPath.row%5+1)];
    //加载图片
    cell.imageView.image = [UIImage imageNamed:imageToLoad];
    //设置label文字
    cell.label.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.row,(long)indexPath.section];
    
    return cell;
}


@end
