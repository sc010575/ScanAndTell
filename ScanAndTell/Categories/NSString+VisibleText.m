
@implementation NSString (VisibleText)

- (NSString*)stringVisibleInRect:(CGRect)rect withFont:(UIFont*)font
{
    NSString *visibleString = @"";
    for (int i = 1; i <= self.length; i++)
    {
        NSString *testString = [self substringToIndex:i];
        CGSize stringSize = [testString sizeWithAttributes:@{NSFontAttributeName: font}];
        if (stringSize.height > rect.size.height || stringSize.width > rect.size.width)
            break;
        
        visibleString = testString;
    }
    return visibleString;
}

@end