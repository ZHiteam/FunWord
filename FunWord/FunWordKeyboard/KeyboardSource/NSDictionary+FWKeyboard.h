

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary(FWKeyboard)
- (BOOL)boolForKey:(NSString *)keyName;
- (float)floatForKey:(NSString *)keyName;      //跟分辨率无关
- (CGSize)sizeForKey:(NSString *)keyName;        //跟分辨率有关
- (CGRect)rectForKey:(NSString *)keyName;        //跟分辨率有关
- (CGPoint)pointForKey:(NSString *)keyName;      //跟分辨率有关
- (NSInteger)integerForKey:(NSString *)keyName;
- (NSString *)stringForKey:(NSString *)keyName;
- (NSDictionary *)dictionaryForKey:(NSString *)keyName;
-(void)setBool:(BOOL)value forKey:(NSString*)keyName;
-(void)setInteger:(NSInteger)value forKey:(NSString*)keyName;

- (NSArray*)arrayForKey:(NSString*)keyName ;
@end