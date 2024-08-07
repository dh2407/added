
ALTER TABLE "public"."MultipleChoiceQuestionResponse"
DROP COLUMN IF EXISTS "is_single_response";

ALTER TABLE "public"."MultipleChoiceQuestion"
ADD COLUMN IF NOT EXISTS "is_single_response" boolean NOT NULL DEFAULT false;