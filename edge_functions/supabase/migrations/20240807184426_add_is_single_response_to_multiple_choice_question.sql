ALTER TABLE "public"."MultipleChoiceQuestionResponse"
ADD COLUMN IF NOT EXISTS "is_single_response" boolean NOT NULL DEFAULT false;