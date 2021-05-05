#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#include <sys/stat.h>
#include <spawn.h>
#include <version.h>

#define DPKG_PATH "/var/lib/dpkg/info/com.mikiyan1978.alertapp.list"

typedef struct __CFUserNotification *CFUserNotificationRef;
FOUNDATION_EXTERN CFUserNotificationRef CFUserNotificationCreate(CFAllocatorRef allocator, CFTimeInterval timeout, CFOptionFlags flags, SInt32 *error, CFDictionaryRef dictionary);
FOUNDATION_EXTERN SInt32 CFUserNotificationReceiveResponse(CFUserNotificationRef userNotification, CFTimeInterval timeout, CFOptionFlags *responseFlags);

/*
static int run_posix_spawn(const char *args[]) {
	pid_t pid;
	int status;
	posix_spawn(&pid, args[0], NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, 0);
	return status;
}

static int run_launchctl(const char *path, const char *cmd, bool is_installd) {
	LOG("run_launchctl() %s %s\n", cmd, path);
	const char *args[] = {(access("/sbin/launchctl", X_OK) != -1) ? "/sbin/launchctl" : "/bin/launchctl", cmd, path, NULL};
	return run_posix_spawn(args);
}*/

int main(int argc, const char **argv) {
	printf("\x1b[35mPower Controller App\033[m\n");
	printf("Power Controller App \n");
	printf("Copyright (C) 2019-2021 mikiyan1978\n");
	if (access(DPKG_PATH, F_OK) == -1) {
		printf("You seem to have installed Power Controller App from an APT repository that is not https://kisaragiray.github.io/repo/ .\n");
		printf("Please only download Power Controller App from the official repository to ensure file integrity and reliability.\n");
	}
	if (geteuid() != 0) {
		printf("FATAL: This binary must be run as root. …Actually, how are you even using dpkg without being root?\n");
		return 1;
	}

	printf("****** Power Controller App installation complete! ******\n");

	#ifdef POSTINST
		if (access("/mikiyan1978.no-postinst-notification", F_OK) == -1) {
			CFUserNotificationRef postinstNotification = CFUserNotificationCreate(kCFAllocatorDefault, 0, 0, NULL, (__bridge CFDictionaryRef)[[NSDictionary alloc] initWithObjectsAndKeys:
				[NSString stringWithFormat:@"%@ %@", (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_6_0) ? @"🔥" : @"🔥", @"Power Controller App 🔥"], @"AlertHeader",
				@"Power Controller Appをインストールして頂きありがとうございます。", @"AlertMessage",
				@"OK", @"DefaultButtonTitle", nil]);
			CFUserNotificationReceiveResponse(postinstNotification, 0, NULL);
		}
	#endif
	return 0;
}
