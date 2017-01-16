#import "UILabel+ContentSize.h"
 
@implementation UILabel (ContentSize)

- (CGSize)contentSizeWithLabWith:(CGFloat)with {
    self.numberOfLines = 0;
   NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font};
    
    CGSize contentSize = [self.text boundingRectWithSize:CGSizeMake(with, MAXFLOAT)
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes:attributes
                                              context:nil].size;
    return contentSize;
}

@end
