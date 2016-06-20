//
//  BBTableView.m
//  CircleView
//
//  Created by Bharath Booshan  on 9/11/12.
//  Copyright (c) 2012 Bharath Booshan. All rights reserved.
//

#import "BBTableView.h"
#import "BBTableViewInterceptor.h"


#define MORPHED_INDEX_PATH( __INDEXPATH__ ) [self morphedIndexPathForIndexPath:__INDEXPATH__  totalRows:_totalRows]

@interface BBTableView()
{
    int mTotalCellsVisible;
    BBTableViewInterceptor *_dataSourceInterceptor;
    NSInteger _totalRows;
}
- (void)customIntitialization;
- (void)resetContentOffsetIfNeeded;
@end

@implementation BBTableView
@synthesize enableInfiniteScrolling;

#pragma mark Private methods
- (NSIndexPath*)morphedIndexPathForIndexPath:(NSIndexPath*)oldIndexPath totalRows:(NSInteger)totalRows
{
    return self.enableInfiniteScrolling ? [NSIndexPath indexPathForRow:oldIndexPath.row % totalRows inSection:oldIndexPath.section] : oldIndexPath;
}

- (void)customIntitialization
{
    self.backgroundColor = [UIColor blackColor];
    self.enableInfiniteScrolling = NO;
}

- (void)resetContentOffsetIfNeeded
{
    if( !self.enableInfiniteScrolling )
        return;
    
    NSArray *indexpaths = [self indexPathsForVisibleRows];
    NSUInteger totalVisibleCells =[indexpaths count];
    if( mTotalCellsVisible > totalVisibleCells )
    {
        //we dont have enough content to generate scroll
        return;
    }
    CGPoint contentOffset  = self.contentOffset;
    
    //check the top condition
    //check if the scroll view reached its top.. if so.. move it to center.. remember center is the start of the data repeating for 2nd time.
    if( contentOffset.y<=0.0)
    {
        contentOffset.y = self.contentSize.height/3.0f;
    }
    else if( contentOffset.y >= ( self.contentSize.height - self.bounds.size.height) )//scrollview content offset reached bottom minus the height of the tableview
    {
        //this scenario is same as the data repeating for 2nd time minus the height of the table view
        contentOffset.y = self.contentSize.height/3.0f- self.bounds.size.height;
    }
    [self setContentOffset: contentOffset];
}

#pragma mark Initialization
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if( self )
    {
        [self customIntitialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if( self )
    {
        [self customIntitialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self customIntitialization];
    }
    return self;
}

#pragma mark Layout

- (void)layoutSubviews
{
    mTotalCellsVisible = self.frame.size.height / self.rowHeight;
    [self resetContentOffsetIfNeeded];
    [super layoutSubviews];
}

#pragma mark Setter/Getter
- (void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    if( !_dataSourceInterceptor)
    {
        _dataSourceInterceptor = [[BBTableViewInterceptor alloc] init];
    }
    
    _dataSourceInterceptor.receiver = dataSource;
    _dataSourceInterceptor.middleMan = self;
    
    [super setDataSource:(id<UITableViewDataSource>)_dataSourceInterceptor];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    _totalRows = [_dataSourceInterceptor.receiver tableView:tableView numberOfRowsInSection:section  ];
    return _totalRows *( self.enableInfiniteScrolling ? 3 : 1 );
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dataSourceInterceptor.receiver tableView:tableView cellForRowAtIndexPath:MORPHED_INDEX_PATH(indexPath)];
}


@end
