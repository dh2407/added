-- Create enum type for QuestionKind
CREATE TYPE "public"."QuestionKind" AS ENUM (
  'MULTIPLE_CHOICE_QUESTION', 
  'FILL_IN_THE_BLANKS_QUESTION'
);

-- Create enum type for SectionKind
CREATE TYPE "public"."SectionKind" AS ENUM (
  'QUESTIONS_GAME', 
  'STORY'
);

-- Alter the Question table to change the column type for kind
ALTER TABLE "public"."Question"
ALTER COLUMN "kind" TYPE "public"."QuestionKind" USING "kind"::"public"."QuestionKind";

-- Alter the Section table to add the kind column with the SectionKind enum type
ALTER TABLE "public"."Section"
ALTER COLUMN "kind" TYPE "public"."SectionKind" USING "kind"::"public"."SectionKind";
