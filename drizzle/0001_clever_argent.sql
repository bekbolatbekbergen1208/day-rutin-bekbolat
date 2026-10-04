CREATE TABLE `lesson_prep` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`date` text NOT NULL,
	`lesson_id` text NOT NULL,
	`done` integer DEFAULT 0 NOT NULL,
	`note` text DEFAULT '' NOT NULL,
	FOREIGN KEY (`lesson_id`) REFERENCES `lessons`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE UNIQUE INDEX `lesson_prep_owner_date_lesson` ON `lesson_prep` (`owner`,`date`,`lesson_id`);