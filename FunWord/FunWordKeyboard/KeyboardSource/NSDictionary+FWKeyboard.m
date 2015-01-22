

#import "NSDictionary+FWKeyboard.h"


@implementation NSDictionary(FWKeyboard)

- (BOOL)boolForKey:(NSString *)keyName
{
    return [[self objectForKey:keyName] boolValue];
}

- (NSInteger)integerForKey:(NSString *)keyName
{
    return [[self objectForKey:keyName] intValue];
}

- (float)floatForKey:(NSString *)keyName
{
	return  [[self objectForKey:keyName] floatValue];
}


- (CGSize)sizeForKey:(NSString *)keyName
{
    CGSize    ret       = CGSizeZero;
    NSString *stringVal = [self objectForKey:keyName];
    NSArray  *componets = [stringVal componentsSeparatedByString:@","];
    if ([componets count] == 2)
    {
        ret = CGSizeMake([[componets objectAtIndex:0] intValue], [[componets objectAtIndex:1] intValue]);
    }

    return ret;
}

- (CGRect)rectForKey:(NSString *)keyName
{
    CGRect    ret       = CGRectZero;
    NSString *stringVal = [self  objectForKey:keyName];
    NSArray  *componets = [stringVal componentsSeparatedByString:@","];
    if ([componets count] == 4)
    {
        ret = CGRectMake([[componets objectAtIndex:0] intValue], [[componets objectAtIndex:1] intValue], 
						 [[componets objectAtIndex:2] intValue], [[componets objectAtIndex:3] intValue]);
    }
    
    return ret;
}

- (CGPoint)pointForKey:(NSString *)keyName
{
    CGPoint   ret       = CGPointZero;
    NSString *stringVal = [self  objectForKey:keyName];
    NSArray  *componets = [stringVal componentsSeparatedByString:@","];
    if ([componets count] == 2)
    {
        ret = CGPointMake([[componets objectAtIndex:0] intValue], [[componets objectAtIndex:1] intValue]);
    }
    
    return ret;
}

- (NSString *)stringForKey:(NSString *)keyName
{
    NSString *ret = [self objectForKey:keyName];
    return ret ? ret : [NSString string];
}

- (NSDictionary *)dictionaryForKey:(NSString *)keyName
{
    return [self objectForKey:keyName];
}

-(void)setBool:(BOOL)value forKey:(NSString*)keyName
{
    [self setValue:[NSNumber numberWithBool:value] forKey:keyName];
}

-(void)setInteger:(NSInteger)value forKey:(NSString*)keyName
{
    [self setValue:[NSNumber numberWithInt:value] forKey:keyName];
}

- (NSArray*) arrayForKey:(NSString*)keyName 
{
	id value = [self objectForKey:keyName];
	
	if (value && [value isKindOfClass:[NSArray class]])
	{
		return value;
	}
	else
	{
		return nil;
	}
	
}
@end
