#import "XXRootViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"
#import <CFUserNotificationHandler/CFUserNotificationHandler.h>
@import SceneKit;

SCNScene *scene;
SCNView *sceneView;
SCNCamera *camera;
SCNNode *cameraNode;

@implementation SettingViewController {
	NSArray *cellImages;
	NSArray *titles;
	NSArray *contents;
	UILabel *Label;
}
 
- (void)loadView {
	[super loadView];

	cellImages = @[
		@"twitter.png", 
		@"line.png", 
		@"cydia.png"];

	titles = @[
		@"mikiyan1978", 
		@"LINE", 
		@"リポジトリ"];

	contents = @[
		@"Twitter", 
		@"LINE追加", 
		@"リポジトリ追加"];

	/*self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];*/
	//self.view.backgroundColor = [UIColor cyanColor];

	//[self createSceneView];
	//[self createScene];
	//[self createCamera];
	//[self createPlate]; //地面
	//[self setupFloor]; //地面
	//[self createText];
	//[self initSCNBox];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { //セクション数
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { //セル数
	//return 3;
	return [cellImages count];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"tableCell";
	UITableViewCell *cell = [tableView 
		dequeueReusableCellWithIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		if (!cell) {
			cell = [[UITableViewCell alloc] 
				initWithStyle:UITableViewCellStyleSubtitle 
				reuseIdentifier:CellIdentifier];
		}

		cell.textLabel.text = titles[indexPath.row];
		cell.detailTextLabel.text = contents[indexPath.row];
		cell.imageView.image = [UIImage 
			imageNamed:cellImages[indexPath.row]];
		cell.imageView.layer.cornerRadius = 13.0;
		cell.imageView.clipsToBounds = YES;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

	CFUserNotificationRef cAlert = nil;

	[[CFUserNotificationHandler sharedInstance] 
		addCFNotiAlert:cAlert 
		title:@"タップされたのは→" 
		alertMessage:[NSString 
			stringWithFormat:@"%@",cell.textLabel.text] 
		yesStr:@"yes" 
		cancelStr:@"cancel" 
		yesActionHandler:^(){
		//
		}];

}








- (void)createPlate {
	SCNBox *plate = [SCNBox 
		boxWithWidth:30.0 
		height:1.5 
		length:6.0 
		chamferRadius:0];

	plate.firstMaterial.diffuse.contents = [UIColor brownColor];
	SCNNode *plateNode = [SCNNode nodeWithGeometry:plate];
	plateNode.position = SCNVector3Make(0, - 1.0, 0);
	plateNode.physicsBody = [SCNPhysicsBody staticBody];
	[scene.rootNode addChildNode:plateNode];
}

- (void)setupFloor {
    
    SCNFloor *floor = [SCNFloor floor];
    floor.reflectionFalloffEnd = 0;
    floor.reflectivity = 0;
    
    SCNNode *floorNode = [SCNNode node];
    floorNode.geometry = floor;
    floorNode.geometry.firstMaterial.diffuse.contents = @"wood.png";
    floorNode.geometry.firstMaterial.locksAmbientWithDiffuse = YES;
    floorNode.geometry.firstMaterial.diffuse.wrapS = SCNWrapModeRepeat;
    floorNode.geometry.firstMaterial.diffuse.wrapT = SCNWrapModeRepeat;
    floorNode.geometry.firstMaterial.diffuse.mipFilter = SCNFilterModeLinear;
    
    floorNode.physicsBody = [SCNPhysicsBody staticBody];
    floorNode.physicsBody.restitution = 1.0;
    
    [scene.rootNode addChildNode:floorNode];
}

- (void)initSCNBox {

	NSArray *images = [NSArray arrayWithObjects:
		[UIImage imageNamed:@"right.png"], 
		[UIImage imageNamed:@"left.png"], 
		[UIImage imageNamed:@"top.png"], 
		[UIImage imageNamed:@"bottom.png"], 
		[UIImage imageNamed:@"front.png"], 
		[UIImage imageNamed:@"back.png"], 
		nil];


	/*NSArray *images = [NSArray arrayWithObjects:
		[UIImage imageNamed:@"box1.png"], 
		[UIImage imageNamed:@"box1.png"], 
		[UIImage imageNamed:@"box1.png"], 
		[UIImage imageNamed:@"box1.png"], 
		[UIImage imageNamed:@"box1.png"], 
		[UIImage imageNamed:@"box1.png"], 
		nil];*/

	SCNBox *box = [SCNBox 
		boxWithWidth:0.5 
		height:0.5 
		length:0.5 
		chamferRadius:0.01];

	SCNMaterial *material = [SCNMaterial material];
	material.diffuse.contents = [UIColor blackColor];
	material.reflective.contents = images;
	material.shininess = 0.5;

	/*material.normal.contents = [UIImage 
		imageNamed:@"box1.png"];*/

	material.specular.contents = [UIColor whiteColor];
	box.materials = [NSArray arrayWithObject:material];

	SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
	boxNode.position = SCNVector3Make(0, 0, 0);

	[scene.rootNode addChildNode:boxNode];


}

- (void)createText {
	SCNText *t = [SCNText 
		textWithString:@"unc0ver" 
		extrusionDepth:0.0];

	t.materials = ^{
		NSMutableArray *arr = [NSMutableArray array];

	for (int i=0; i<4; i++) {
		SCNMaterial *m = [SCNMaterial material];
		m.diffuse.contents = (i==0) ? 
			[UIColor redColor] : [UIColor grayColor];
		m.diffuse.mipFilter = SCNFilterModeLinear;
		m.doubleSided = YES;
		[arr addObject:m];
	}
	return arr;
}();

	//t.font = font;
	t.chamferRadius = 1.0;
	t.chamferProfile = ^{
		UIBezierPath *path = [UIBezierPath bezierPath];
		[path moveToPoint:CGPointMake(1, 0)];
		[path addLineToPoint:CGPointMake(1, 5)];
		[path addLineToPoint:CGPointMake(- 5, 5)];
		[path addLineToPoint:CGPointMake(0, 1)];
		return path;
}();

	SCNNode *tNode = [SCNNode nodeWithGeometry:t];
	tNode.position = SCNVector3Make(- 22, 0, 0);
	[scene.rootNode addChildNode:tNode];
	tNode.physicsBody = [SCNPhysicsBody dynamicBody];
}

- (void)createSceneView {
	sceneView = [[SCNView alloc] 
		initWithFrame:self.view.frame];
	sceneView.backgroundColor = [UIColor cyanColor];

	sceneView.allowsCameraControl = YES;
	sceneView.autoenablesDefaultLighting = YES;
}

- (void)createScene {
	scene = [SCNScene scene];
	sceneView.scene = scene;
	[self.view addSubview:sceneView];
}

- (void)createCamera {
	camera = [SCNCamera camera];
	cameraNode = [SCNNode node];
	cameraNode.camera = camera;
	cameraNode.position = SCNVector3Make(0, 0, 70);
	[scene.rootNode addChildNode:cameraNode];
}
@end

/*
SCNLight type
SCNLightTypeIES
照明の形状、方向、強度が測光プロファイルによって決定される光源。

SCNLightTypeAmbient
シーン内のすべてのオブジェクトをすべての方向から照らすライト。

SCNLightTypeDirectional
均一な方向と一定の強度を持つ光源。

SCNLightTypeOmni
ポイントライトとも呼ばれる全方向性ライト。

SCNLightTypeProbe
環境ベースの照明で使用されるシーン内のポイント周辺の環境のサンプル。

SCNLightTypeSpot
円錐形の領域を照らす光源。

SCNLightTypeArea

SCNGeometry

SCNFloor
オプションで、その上のシーンの反射を表示できる平面。

SCNText
テキストの文字列に基づくジオメトリ。オプションで、3次元オブジェクトを作成するために押し出されます。

SCNCapsule
両端が半球で覆われている直円柱形状。

SCNCone
右円錐または錐台の形状。

SCNCylinder
右円柱の形状。

SCNPlane
指定された幅と高さの長方形の片側平面ジオメトリ。

SCNPyramid
右の長方形のピラミッドジオメトリ。

SCNSphere
球（またはボールまたはグローブ）ジオメトリ。

SCNTorus
トーラス、またはリング状のジオメトリ。

SCNTube
チューブまたはパイプの形状—中心軸に沿って円形の穴がある直円柱。

NSArray *images = [NSArray arrayWithObjects:
		[UIImage imageNamed:@"box.png"], 
		[UIImage imageNamed:@"box.png"], 
		[UIImage imageNamed:@"box.png"], 
		[UIImage imageNamed:@"box.png"], 
		[UIImage imageNamed:@"box.png"], 
		[UIImage imageNamed:@"box.png"], 
		nil];
*/