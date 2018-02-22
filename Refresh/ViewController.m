//
//  ViewController.m
//  Refresh
//
//  Created by PROIMA on 22/2/18.
//  Copyright © 2018 Copanonga. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
	NSMutableArray *datosTabla;
}
@property (strong, nonatomic) IBOutlet UITableView *tablaResultados;

@end

@implementation ViewController
@synthesize tablaResultados;

- (void)viewDidLoad {
	[super viewDidLoad];
	[self inicializarDatos];
	[tablaResultados reloadData];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - Datos

-(void)inicializarDatos {
	
	datosTabla = [[NSMutableArray alloc] init];
	
	for (int i = 0 ; i < 10 ; i++){
		NSString *dato = [NSString stringWithFormat:@"Dato: %i",i];
		[datosTabla addObject:dato];
	}
	
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
