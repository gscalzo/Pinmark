#import "Kiwi.h"

SPEC_BEGIN(KiwiSpec)
describe(@"Kiwi Test", ^{
    context(@"in a context", ^{
        it(@"should pass", ^{
            [[theValue(1) should] equal:theValue(1)];
        });
    });
});
SPEC_END