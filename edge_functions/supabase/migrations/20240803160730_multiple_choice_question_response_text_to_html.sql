-- Rename the 'text' column to 'html' in the 'MultipleChoiceQuestionResponse' table
ALTER TABLE "public"."MultipleChoiceQuestionResponse"
RENAME COLUMN "text" TO "html";
