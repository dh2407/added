-- Rename the 'text' column to 'html' in the 'MultipleChoiceQuestion' table
ALTER TABLE "public"."MultipleChoiceQuestion"
RENAME COLUMN "text" TO "html";
