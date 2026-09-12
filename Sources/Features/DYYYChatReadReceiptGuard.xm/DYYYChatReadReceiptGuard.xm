#import "DYYYUtils.h"

static NSString *const kDYYYDisableChatReadReceiptKey = @"DYYYDisableChatReadReceipt";

// Keep local read state, but suppress the server-side read receipt flag.
%hook TIMXMessageMarkAsReadOperator

- (void)markConversationAsRead:(id)conversation
                 tillPullIndex:(long long)pullIndex
                 tillBadgeCount:(long long)badgeCount
     tillMuteReadBadgeCountInfos:(id)muteReadBadgeCountInfos
                    sendToServer:(BOOL)sendToServer
                       completion:(id)completion {
    if (DYYYGetBool(kDYYYDisableChatReadReceiptKey)) {
        %orig(conversation,
              pullIndex,
              badgeCount,
              muteReadBadgeCountInfos,
              NO,
              completion);
        return;
    }

    %orig;
}

%end
