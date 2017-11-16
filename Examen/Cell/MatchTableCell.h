//
//  SWPeopleCell.h
//  Startwars_API
//
//  Created by Virtual Box on 11/14/17.
//  Copyright © 2017 UAG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchTableCell : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelHome;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelAway;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIImageView *imageHome;
@property (weak, nonatomic) IBOutlet UIImageView *imageAway;

@end
