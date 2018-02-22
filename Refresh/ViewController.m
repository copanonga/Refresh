//
//  ViewController.m
//  Refresh
//
//  Created by PROIMA on 22/2/18.
//  Copyright © 2018 Copanonga. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"

@interface ViewController () {
	NSMutableArray *datosTabla;
	__unsafe_unretained UITableView *tableView;
}

@property (strong, nonatomic) IBOutlet UITableView *tablaResultados;

@end

@implementation ViewController
@synthesize tablaResultados;

- (void)viewDidLoad {
	
	NSLog(@"\nViewController");
	[super viewDidLoad];
	
	[self inicializarDatos];
	
	[tablaResultados reloadData];
	
	[self refrescoPaginacion];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - Datos

-(void)inicializarDatos {
	
	datosTabla = [[NSMutableArray alloc] init];
	
	for (int i = 0 ; i < 10 ; i++){
		NSString *dato = [NSString stringWithFormat:@"Data: %i",i];
		[datosTabla addObject:dato];
	}
	
}

-(void)datosPullToRefresh {
	
	datosTabla = [[NSMutableArray alloc] init];
	
	for (int i = 0 ; i < 10 ; i++){
		NSString *dato = [NSString stringWithFormat:@"Pull to refresh: %i",i];
		[datosTabla addObject:dato];
	}
	
}

-(void)datosLoadMore {
	
	for (int i = 0 ; i < 10 ; i++){
		NSString *dato = [NSString stringWithFormat:@"Load more: %i",i];
		[datosTabla addObject:dato];
	}
	
}

#pragma mark - Refresh

-(void)refrescoPaginacion {
	
	tableView = tablaResultados;
	
	tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self pullToRefresh];
		});
	}];

	tableView.mj_header.automaticallyChangeAlpha = YES;
	
	tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self loadMore];
		});
	}];
	
}

-(void)pullToRefresh {
	
	NSLog(@"Pull to refresh");
	[self datosPullToRefresh];
	
	[tablaResultados reloadData];
	[tableView.mj_header endRefreshing];
	
}

-(void)loadMore {
	
	NSLog(@"Load more");
	[self datosLoadMore];
	
	[tablaResultados reloadData];
	[tableView.mj_footer endRefreshing];
	
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return [datosTabla count];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"celda"];
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celda"];
	}
	
	cell.textLabel.text = [datosTabla objectAtIndex:indexPath.row];
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
