//
//  AppDelegate.m
//  ForecastViewer
//
//  Created by Mateusz Florczak on 31/01/17.
//
//

#import "AppDelegate.h"
#import "City.h"
#import "CitiesForecastCollectionViewController.h"
#import "StaticHeadersCollectionViewLayout.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [self clearRealmData:realm];
    [self setupCityData:realm];

    StaticHeadersCollectionViewLayout *collectionViewLayout = [[StaticHeadersCollectionViewLayout alloc] init];
    UICollectionViewController *citiesForecastCollectionViewController = [[CitiesForecastCollectionViewController alloc] initWithCollectionViewLayout:collectionViewLayout];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = citiesForecastCollectionViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private methods

- (void)clearRealmData:(RLMRealm *)realm {
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

- (void)setupCityData:(RLMRealm *)realm {
    [realm beginWriteTransaction];
    [realm addObjects:@[[[City alloc] initWithValue:@[@7531002, @"Gdańsk", @[]]],
                        [[City alloc] initWithValue:@[@524901, @"Moscow", @[]]],
                        [[City alloc] initWithValue:@[@1835848, @"Seoul", @[]]],
                        [[City alloc] initWithValue:@[@1850147, @"Tokyo", @[]]],
                        [[City alloc] initWithValue:@[@756135, @"Warsaw", @[]]],
                        [[City alloc] initWithValue:@[@4880731, @"Washington", @[]]]
                        ]];
    [realm commitWriteTransaction];
}

@end
