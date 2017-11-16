//
//  ViewController.m
//  Examen
//
//  Created by Virtual Box on 11/15/17.
//  Copyright © 2017 UAG. All rights reserved.
//

#import "Home.h"
#import "Constants.h"
#import "WebServices.h"
#import "MatchTableCell.h"

@interface Home ()
@property NSMutableArray *games;
@property NSDictionary *teamLogos;
@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _games = [[NSMutableArray alloc] init];
    
    _teamLogos = @{
                   @"Águilas": [UIImage imageNamed:@"aguilas.png"],
                   @"Tomateros": [UIImage imageNamed:@"tomateros.png"],
                   @"Naranjeros" : [UIImage imageNamed:@"naranjeros.jpg"],
                   @"Venados" : [UIImage imageNamed:@"venados.png"],
                   @"Yaquis": [UIImage imageNamed:@"yaquis.png"],
                   @"Mayos" : [UIImage imageNamed:@"mayos.gif"],
                   @"Cañeros" : [UIImage imageNamed:@"caneros.jpg"],
                   @"Charros" : [UIImage imageNamed:@"charros.png"]
                  };
    
    
    [self refreshGames];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRefreshPressed:(id)sender {
    [self refreshGames];
}

-(void) refreshGames {
    if([UIApplication sharedApplication].networkActivityIndicatorVisible)
        return;
    
    [_games removeAllObjects];
    [self.tableGames reloadData];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [WebServices getGames:^(NSMutableArray<GameModel> *games) { [self handler:games]; }];
}

-(void) handler:(NSMutableArray<GameModel>*) games {
    if(games){
        [_games addObjectsFromArray:games];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.tableGames reloadData];
}

#pragma mark - Table

- (NSInteger)numberOfSectionTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.games count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MatchTableCell *cell = (MatchTableCell *)[tableView dequeueReusableCellWithIdentifier:@"MatchTableCell"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"MatchTableCell" bundle:nil] forCellReuseIdentifier:@"MatchTableCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"MatchTableCell"];
    }
    
    //Fill cell with info from arrays
    GameModel *game = [self.games objectAtIndex:[indexPath row]];
    cell.labelHome.text = game.homeName;
    cell.labelAway.text = game.awayName;
    cell.labelDate.text = game.startTime;
    cell.imageHome.image = _teamLogos[game.homeName];
    cell.imageAway.image = _teamLogos[game.awayName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"PeopleTableToDetail" sender:self];
}

@end
