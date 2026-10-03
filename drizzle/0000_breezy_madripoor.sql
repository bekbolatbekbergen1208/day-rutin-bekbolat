CREATE TABLE `achievements` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`date` text NOT NULL,
	`organization` text,
	`description` text,
	`category` text,
	`project_id` text,
	`url` text,
	`public` integer DEFAULT 0,
	FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `events` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`date` text NOT NULL,
	`start` text NOT NULL,
	`end` text NOT NULL,
	`category` text DEFAULT 'Personal'
);
--> statement-breakpoint
CREATE TABLE `exercises` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`workout_id` text NOT NULL,
	`sets` integer,
	`reps` text,
	FOREIGN KEY (`workout_id`) REFERENCES `workouts`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `fll_attempts` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`mission_id` text NOT NULL,
	`success` integer NOT NULL,
	`reason` text,
	FOREIGN KEY (`mission_id`) REFERENCES `fll_missions`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `fll_missions` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`points` integer DEFAULT 0,
	`status` text DEFAULT 'Not Started',
	`strategy` text,
	`attachment` text,
	`program` text,
	`position` text,
	`notes` text,
	`goal_id` text,
	FOREIGN KEY (`goal_id`) REFERENCES `goals`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `fll_sessions` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`date` text NOT NULL,
	`mission_id` text,
	`best` text,
	`problems` text,
	`next_action` text,
	`duration` integer DEFAULT 105,
	FOREIGN KEY (`mission_id`) REFERENCES `fll_missions`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `focus_sessions` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`date` text NOT NULL,
	`minutes` real NOT NULL
);
--> statement-breakpoint
CREATE TABLE `goal_milestones` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`goal_id` text NOT NULL,
	`done` integer DEFAULT 0,
	FOREIGN KEY (`goal_id`) REFERENCES `goals`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `goals` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`deadline` text,
	`horizon` text NOT NULL,
	`why` text,
	`parent_id` text,
	`next_action` text
);
--> statement-breakpoint
CREATE TABLE `homework` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`subject` text NOT NULL,
	`assigned` text,
	`due` text NOT NULL,
	`duration` integer DEFAULT 30,
	`status` text DEFAULT 'Not Started',
	`priority` text DEFAULT 'Normal'
);
--> statement-breakpoint
CREATE TABLE `lessons` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`weekday` integer NOT NULL,
	`start` text NOT NULL,
	`end` text NOT NULL,
	`room` text,
	`teacher` text
);
--> statement-breakpoint
CREATE TABLE `portfolio_projects` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`project_id` text,
	`year` integer,
	`role` text,
	`category` text,
	`about` text,
	`problem` text,
	`solution` text,
	`technology` text,
	`results` text,
	`url` text,
	`public` integer DEFAULT 0,
	FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `projects` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`description` text,
	`status` text DEFAULT 'Active',
	`deadline` text,
	`goal_id` text,
	`next_action` text NOT NULL,
	FOREIGN KEY (`goal_id`) REFERENCES `goals`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `reviews` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`period` text,
	`progress` text,
	`attention` text,
	`focus` text
);
--> statement-breakpoint
CREATE TABLE `skills` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`started` text,
	`stage` text,
	`evidence` text
);
--> statement-breakpoint
CREATE TABLE `tasks` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`due` text,
	`duration` integer DEFAULT 30,
	`status` text DEFAULT 'Not Started',
	`priority` text DEFAULT 'Normal',
	`project_id` text,
	`top` integer DEFAULT 0,
	FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `users` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`bio` text,
	`sleep` text DEFAULT '22:30' NOT NULL,
	`travel` integer DEFAULT 40 NOT NULL,
	`fll_travel` integer DEFAULT 15 NOT NULL,
	`competition` text,
	`onboarded` integer DEFAULT 0
);
--> statement-breakpoint
CREATE TABLE `workouts` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`title` text NOT NULL,
	`created` text NOT NULL,
	`date` text NOT NULL,
	`activity` text NOT NULL,
	`rating` text,
	`status` text DEFAULT 'Planned'
);
