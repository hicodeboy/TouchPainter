//
//  ThumbnailViewController.m
//  TouchPainter
//
//  Created by hello on 2021/4/3.
//

#import "ThumbnailViewController.h"

@interface ThumbnailViewController ()
@property (nonatomic, strong) UINavigationItem *navItem;
@property (nonatomic, strong) ScribbleManager *scribbleManager;
@end

@implementation ThumbnailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // set the table view's background
    // with a dark cloth texture image
    UIColor *backgroundColor = [UIColor colorWithPatternImage:
                                [UIImage imageNamed:@"background_texture"]];
    [[self view] setBackgroundColor:backgroundColor];
    
    // initialize the scribble manager
    _scribbleManager = [[ScribbleManager alloc] init];
    
    // show number of scribbles available
    NSInteger numberOfScribbles = [_scribbleManager numberOfScribbles];
    [_navItem setTitle:[NSString stringWithFormat:
                        numberOfScribbles > 1 ? @"%ld items" : @"%ld item",
                        numberOfScribbles]];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  CGFloat numberOfPlaceholders = [ScribbleThumbnailCell numberOfPlaceHolders];
  NSInteger numberOfScribbles = [_scribbleManager numberOfScribbles];
  NSInteger numberOfRows = ceil(numberOfScribbles / numberOfPlaceholders);
  return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  static NSString *CellIdentifier = @"Cell";
  
  ScribbleThumbnailCell *cell = (ScribbleThumbnailCell *)[tableView
                                                          dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil)
  {
    cell = [[ScribbleThumbnailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier] ;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  
  // Configure the cell...
  
  // populate  thumbnails in each cell
  
  // get max number of thumbnail a thumbnail
  // cell can support
  NSInteger numberOfSupportedThumbnails = [ScribbleThumbnailCell numberOfPlaceHolders];
  
  // we can only add max numberOfSupportedThumbnails
  // at a time in each cell
  // e.g. numberOfSupportedThumbnails = 3
  // thumbnail index in the scribble manager is (row index *3) +0, +1, +2
  NSUInteger rowIndex = [indexPath row];
  NSInteger thumbnailIndex = rowIndex *numberOfSupportedThumbnails;
  NSInteger numberOfScribbles = [_scribbleManager numberOfScribbles];
  for (NSInteger i = 0; i < numberOfSupportedThumbnails &&
       (thumbnailIndex + i) < numberOfScribbles; ++i)
  {
    UIView *scribbleThumbnail = [_scribbleManager scribbleThumbnailViewAtIndex:
                                            thumbnailIndex + i];
    [cell addThumbnailView:scribbleThumbnail atIndex:i];
  }
  
  return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 150;
}


@end
