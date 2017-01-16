//
//  UIControl+ControlExtral.m
//  BPC_ECRCOC
//
//  Created by YiJianjun on 14/12/1.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import "UIControl+ControlExtral.h"
#import <objc/runtime.h>

@implementation UIControl (ControlExtral)

static const char *__controlAssocationKey__ = "__controlAssocationKey__";

/**
 * 添加消息,快速添加一个消息,可以和现在其他的事件兼容
 * @see addTarget:action:forControlEvents: ; addControlEvents:performAction:overrideAllEvents:
 **/
- (void)addSingleControlEvents:(UIControlEvents)controlEvents performAction:(void (^)(id sender,UIControlEvents controlEvents))action{
    if(!action){
        return;
    }
    
    objc_setAssociatedObject(self, __controlAssocationKey__, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if(controlEvents & UIControlEventTouchUpInside){
        [self addTarget:self action:@selector(__performSelectorTouchDownAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if(controlEvents & UIControlEventTouchUpOutside){
        [self addTarget:self action:@selector(__performSelectorTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpOutside];
    }else if(controlEvents & UIControlEventTouchDown){
        [self addTarget:self action:@selector(__performSelectorTouchDownAction:) forControlEvents:UIControlEventTouchDown];
    }else if(controlEvents & UIControlEventTouchDownRepeat){
        [self addTarget:self action:@selector(__performSelectorTouchDownRepeatAction:) forControlEvents:UIControlEventTouchDownRepeat];
    }else if(controlEvents & UIControlEventTouchDragInside){
        [self addTarget:self action:@selector(__performSelectorTouchDownAction:) forControlEvents:UIControlEventTouchDragInside];
    }else if(controlEvents & UIControlEventTouchDragOutside){
        [self addTarget:self action:@selector(__performSelectorTouchDragOutsideAction:) forControlEvents:UIControlEventTouchDragOutside];
    }else if(controlEvents & UIControlEventTouchDragEnter){
        [self addTarget:self action:@selector(__performSelectorTouchDragEnterAction:) forControlEvents:UIControlEventTouchDragEnter];
    }else if(controlEvents & UIControlEventTouchDragExit){
        [self addTarget:self action:@selector(__performSelectorTouchDragExitAction:) forControlEvents:UIControlEventTouchDragExit];
    }else if(controlEvents & UIControlEventTouchCancel){
        [self addTarget:self action:@selector(__performSelectorTouchCancelAction:) forControlEvents:UIControlEventTouchCancel];
    }else if(controlEvents & UIControlEventValueChanged){/// value changed
        [self addTarget:self action:@selector(__performSelectorValueChangedAction:) forControlEvents:UIControlEventValueChanged];
    }else if(controlEvents & UIControlEventEditingDidBegin){///Editing
        [self addTarget:self action:@selector(__performSelectorEditingDidBeginAction:) forControlEvents:UIControlEventEditingDidBegin];
    }else if(controlEvents & UIControlEventEditingChanged){
        [self addTarget:self action:@selector(__performSelectorEditingChangedAction:) forControlEvents:UIControlEventEditingChanged];
    }else if(controlEvents & UIControlEventEditingDidEnd){
        [self addTarget:self action:@selector(__performSelectorEditingDidEndAction:) forControlEvents:UIControlEventEditingDidEnd];
    }else if(controlEvents & UIControlEventEditingDidEndOnExit){
        [self addTarget:self action:@selector(__performSelectorEditingDidEndOnExitAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
}

/**
 * 添加消息,可以添加多次,可以和现在其他的事件兼容
 * @see addTarget:action:forControlEvents: ; addControlEvents:performAction:overrideAllEvents:
 **/
- (void)addControlEvents:(UIControlEvents)controlEvents performAction:(void (^)(id sender,UIControlEvents controlEvents))action{
    [self addControlEvents:controlEvents performAction:action overrideAllEvents:NO];
}


/**
 * 添加消息,可以添加多次,重写现在其他的事件
 * @see addTarget:action:forControlEvents:
 **/
- (void)addControlEvents:(UIControlEvents)controlEvents performAction:(void (^)(id sender,UIControlEvents controlEvents))action overrideAllEvents:(BOOL)override{
    if(!action){
        return;
    }
    
    objc_setAssociatedObject(self, __controlAssocationKey__, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    
    UIControlEvents allControlEvents = controlEvents;
    if(override){
        allControlEvents |= [self allControlEvents];
    }
    
    if(allControlEvents & UIControlEventAllEvents){
        [self addTarget:self action:@selector(__performSelectorAllEventsAction:) forControlEvents:UIControlEventAllEvents];
    }else{
        if(allControlEvents & UIControlEventAllEditingEvents){
            [self addTarget:self action:@selector(__performSelectorAllEditingEventsAction:) forControlEvents:UIControlEventAllEditingEvents];
        }
        
        if(allControlEvents & UIControlEventApplicationReserved){
            [self addTarget:self action:@selector(__performSelectorApplicationReservedAction:) forControlEvents:UIControlEventApplicationReserved];
        }
        
        if(allControlEvents & UIControlEventSystemReserved){
            [self addTarget:self action:@selector(__performSelectorSystemReservedAction:) forControlEvents:UIControlEventSystemReserved];
        }
        
        if(allControlEvents & UIControlEventAllTouchEvents){
            [self addTarget:self action:@selector(__performSelectorAllTouchEventsAction:) forControlEvents:UIControlEventAllTouchEvents];
        }else{
            /// touch action
            if(allControlEvents & UIControlEventTouchDown){
                [self addTarget:self action:@selector(__performSelectorTouchDownAction:) forControlEvents:UIControlEventTouchDown];
            }
            
            if(allControlEvents & UIControlEventTouchDownRepeat){
                [self addTarget:self action:@selector(__performSelectorTouchDownRepeatAction:) forControlEvents:UIControlEventTouchDownRepeat];
            }
            
            if(allControlEvents & UIControlEventTouchDragInside){
                [self addTarget:self action:@selector(__performSelectorTouchDownAction:) forControlEvents:UIControlEventTouchDragInside];
            }
            
            if(allControlEvents & UIControlEventTouchDragOutside){
                [self addTarget:self action:@selector(__performSelectorTouchDragOutsideAction:) forControlEvents:UIControlEventTouchDragOutside];
            }
            
            if(allControlEvents & UIControlEventTouchDragEnter){
                [self addTarget:self action:@selector(__performSelectorTouchDragEnterAction:) forControlEvents:UIControlEventTouchDragEnter];
            }
            
            if(allControlEvents & UIControlEventTouchDragExit){
                [self addTarget:self action:@selector(__performSelectorTouchDragExitAction:) forControlEvents:UIControlEventTouchDragExit];
            }
            
            if(allControlEvents & UIControlEventTouchUpInside){
                [self addTarget:self action:@selector(__performSelectorTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if(allControlEvents & UIControlEventTouchUpOutside){
                [self addTarget:self action:@selector(__performSelectorTouchUpOutsideAction:) forControlEvents:UIControlEventTouchUpOutside];
            }
            
            if(allControlEvents & UIControlEventTouchCancel){
                [self addTarget:self action:@selector(__performSelectorTouchCancelAction:) forControlEvents:UIControlEventTouchCancel];
            }
            
            /// value changed
            if(allControlEvents & UIControlEventValueChanged){
                [self addTarget:self action:@selector(__performSelectorValueChangedAction:) forControlEvents:UIControlEventValueChanged];
            }
            
            ///Editing
            if(allControlEvents & UIControlEventEditingDidBegin){
                [self addTarget:self action:@selector(__performSelectorEditingDidBeginAction:) forControlEvents:UIControlEventEditingDidBegin];
            }
            
            if(allControlEvents & UIControlEventEditingChanged){
                [self addTarget:self action:@selector(__performSelectorEditingChangedAction:) forControlEvents:UIControlEventEditingChanged];
            }
            
            if(allControlEvents & UIControlEventEditingDidEnd){
                [self addTarget:self action:@selector(__performSelectorEditingDidEndAction:) forControlEvents:UIControlEventEditingDidEnd];
            }
            
            if(allControlEvents & UIControlEventEditingDidEndOnExit){
                [self addTarget:self action:@selector(__performSelectorEditingDidEndOnExitAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
            }
        }
    }
}

/*
typedef NS_OPTIONS(NSUInteger, UIControlEvents) {
    UIControlEventTouchDown           = 1 <<  0,      // on all touch downs
    UIControlEventTouchDownRepeat     = 1 <<  1,      // on multiple touchdowns (tap count > 1)
    UIControlEventTouchDragInside     = 1 <<  2,
    UIControlEventTouchDragOutside    = 1 <<  3,
    UIControlEventTouchDragEnter      = 1 <<  4,
    UIControlEventTouchDragExit       = 1 <<  5,
    UIControlEventTouchUpInside       = 1 <<  6,
    UIControlEventTouchUpOutside      = 1 <<  7,
    UIControlEventTouchCancel         = 1 <<  8,
    
    UIControlEventValueChanged        = 1 << 12,     // sliders, etc.
    
    UIControlEventEditingDidBegin     = 1 << 16,     // UITextField
    UIControlEventEditingChanged      = 1 << 17,
    UIControlEventEditingDidEnd       = 1 << 18,
    UIControlEventEditingDidEndOnExit = 1 << 19,     // 'return key' ending editing
    
    UIControlEventAllTouchEvents      = 0x00000FFF,  // for touch events
    UIControlEventAllEditingEvents    = 0x000F0000,  // for UITextField
    UIControlEventApplicationReserved = 0x0F000000,  // range available for application use
    UIControlEventSystemReserved      = 0xF0000000,  // range reserved for internal framework use
    UIControlEventAllEvents           = 0xFFFFFFFF
};
*/

#pragma mark - @Perform Actions
- (void)__doPerformActionWithEvents:(UIControlEvents)controlEvents{
    void (^performAction)(id sender,UIControlEvents controlEvents)  = objc_getAssociatedObject(self, __controlAssocationKey__);
    if(performAction){
        performAction(self,controlEvents);
    }
}

#pragma mark - ---Touch Action
- (void)__performSelectorTouchDownAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventTouchDown];
}

- (void)__performSelectorTouchDownRepeatAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventTouchDownRepeat];
}

- (void)__performSelectorTouchDragInsideAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventTouchDragInside];
}

- (void)__performSelectorTouchDragOutsideAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventTouchDragOutside];
}

- (void)__performSelectorTouchDragEnterAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventTouchDragEnter];
}

- (void)__performSelectorTouchDragExitAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventTouchDragExit];
}

- (void)__performSelectorTouchUpInsideAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventTouchUpInside];
}

- (void)__performSelectorTouchUpOutsideAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventTouchUpOutside];
}

- (void)__performSelectorTouchCancelAction:(id)sender{
   [self __doPerformActionWithEvents:UIControlEventTouchCancel];
}

#pragma mark - ---Value Changed Action

- (void)__performSelectorValueChangedAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventValueChanged];
}

#pragma mark - ---Editing Action
- (void)__performSelectorEditingDidBeginAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventEditingDidBegin];
}
- (void)__performSelectorEditingChangedAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventEditingChanged];
}
- (void)__performSelectorEditingDidEndAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventEditingDidEnd];
}
- (void)__performSelectorEditingDidEndOnExitAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventEditingDidEndOnExit];
}


#pragma mark - ---Other Collection Events Action

- (void)__performSelectorAllTouchEventsAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventAllTouchEvents];
}

- (void)__performSelectorAllEditingEventsAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventAllEditingEvents];
}

- (void)__performSelectorApplicationReservedAction:(id)sender{
  [self __doPerformActionWithEvents:UIControlEventApplicationReserved];
}

- (void)__performSelectorSystemReservedAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventSystemReserved];
}

- (void)__performSelectorAllEventsAction:(id)sender{
    [self __doPerformActionWithEvents:UIControlEventAllEvents];
}

@end
