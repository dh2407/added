SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

COMMENT ON SCHEMA "public" IS 'standard public schema';

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

CREATE TABLE IF NOT EXISTS "public"."MultipleChoiceQuestionResponse" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "text" TEXT NOT NULL,
  "multiple_choice_question_id" BIGINT NOT NULL,
  "is_correct" BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."Segment" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "text" VARCHAR(255),
  "sound_id" BIGINT,
  "scene_id" BIGINT,
  "order" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."FillIneTheBlankQuestion" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "question_id" BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."ParentChildSubjectsLink" (
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "parent_id" BIGINT NOT NULL,
  "child_id" BIGINT NOT NULL,
  "label" VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS "public"."Section" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "subject_id" BIGINT,
  "kind" VARCHAR(50),
  "order" BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."FillInTheBlankTextFragment" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "text" TEXT NOT NULL,
  "order" BIGINT NOT NULL,
  "fill_in_the_blank_question_id" BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."Question" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "kind" VARCHAR(255) NOT NULL,
  "question_game_id" BIGINT NOT NULL,
  "order" BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."FillInTheBlankWrongResponse" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "fill_in_the_blank_question_id" BIGINT NOT NULL,
  "text" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."FillInTheBlankCorrectResponse" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "order" BIGINT NOT NULL,
  "fill_in_the_blank_question_id" BIGINT NOT NULL,
  "text" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."MultipleChoiceQuestion" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "text" TEXT NOT NULL,
  "question_id" BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."QuestionsGame" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "section_id" BIGINT UNIQUE
);

CREATE TABLE IF NOT EXISTS "public"."Sound" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "sound_url" VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."Image" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "image_url" VARCHAR(255) NOT NULL,
  "scene_id" BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."Scene" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "story_id" BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."Story" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "section_id" BIGINT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "public"."Subject" (
  "id" BIGINT PRIMARY KEY NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP DEFAULT null,
  "title" VARCHAR(255),
  "description" VARCHAR(255)
);

ALTER TABLE "public"."Segment" ADD CONSTRAINT "segment_scene_id_foreign" FOREIGN KEY ("scene_id") REFERENCES "public"."Scene" ("id");

ALTER TABLE "public"."Scene" ADD CONSTRAINT "scene_story_id_foreign" FOREIGN KEY ("story_id") REFERENCES "public"."Story" ("id");

ALTER TABLE "public"."MultipleChoiceQuestion" ADD CONSTRAINT "multiplechoicequestion_question_id_foreign" FOREIGN KEY ("question_id") REFERENCES "public"."Question" ("id");

ALTER TABLE "public"."Question" ADD CONSTRAINT "question_question_game_id_foreign" FOREIGN KEY ("question_game_id") REFERENCES "public"."QuestionsGame" ("id");

ALTER TABLE "public"."ParentChildSubjectsLink" ADD CONSTRAINT "ParentChildSubjectsLink_pkey" PRIMARY KEY ("parent_id", "child_id");

ALTER TABLE "public"."ParentChildSubjectsLink" ADD CONSTRAINT "ParentChildSubjectsLink_child_id_fkey" FOREIGN KEY ("child_id") REFERENCES "public"."Subject"("id");

ALTER TABLE "public"."ParentChildSubjectsLink" ADD CONSTRAINT "ParentChildSubjectsLink_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."Subject"("id");

ALTER TABLE "public"."FillInTheBlankTextFragment" ADD CONSTRAINT "fillintheblanktextfragment_fill_in_the_blank_question_id_foreign" FOREIGN KEY ("fill_in_the_blank_question_id") REFERENCES "public"."FillIneTheBlankQuestion" ("id");

ALTER TABLE "public"."Image" ADD CONSTRAINT "image_scene_id_foreign" FOREIGN KEY ("scene_id") REFERENCES "public"."Scene" ("id");

ALTER TABLE "public"."FillIneTheBlankQuestion" ADD CONSTRAINT "fillinetheblankquestion_question_id_foreign" FOREIGN KEY ("question_id") REFERENCES "public"."Question" ("id");

ALTER TABLE "public"."QuestionsGame" ADD CONSTRAINT "questionsgame_section_id_foreign" FOREIGN KEY ("section_id") REFERENCES "public"."Section" ("id");

ALTER TABLE "public"."MultipleChoiceQuestionResponse" ADD CONSTRAINT "multiplechoicequestionresponse_multiple_choice_question_id_foreign" FOREIGN KEY ("multiple_choice_question_id") REFERENCES "public"."MultipleChoiceQuestion" ("id");

ALTER TABLE "public"."Section" ADD CONSTRAINT "section_subject_id_foreign" FOREIGN KEY ("subject_id") REFERENCES "public"."Subject" ("id");

ALTER TABLE "public"."FillInTheBlankCorrectResponse" ADD CONSTRAINT "fillintheblankcorrectresponse_fill_in_the_blank_question_id_foreign" FOREIGN KEY ("fill_in_the_blank_question_id") REFERENCES "public"."FillIneTheBlankQuestion" ("id");

ALTER TABLE "public"."FillInTheBlankWrongResponse" ADD CONSTRAINT "fillintheblankwrongresponse_fill_in_the_blank_question_id_foreign" FOREIGN KEY ("fill_in_the_blank_question_id") REFERENCES "public"."FillIneTheBlankQuestion" ("id");

ALTER TABLE "public"."Segment" ADD CONSTRAINT "segment_sound_id_foreign" FOREIGN KEY ("sound_id") REFERENCES "public"."Sound" ("id");

ALTER TABLE "public"."Story" ADD CONSTRAINT "story_section_id_foreign" FOREIGN KEY ("section_id") REFERENCES "public"."Section" ("id");

ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON TABLE "public"."MultipleChoiceQuestionResponse" TO "anon";
GRANT ALL ON TABLE "public"."MultipleChoiceQuestionResponse" TO "authenticated";
GRANT ALL ON TABLE "public"."MultipleChoiceQuestionResponse" TO "service_role";

GRANT ALL ON TABLE "public"."Segment" TO "anon";
GRANT ALL ON TABLE "public"."Segment" TO "authenticated";
GRANT ALL ON TABLE "public"."Segment" TO "service_role";

GRANT ALL ON TABLE "public"."FillIneTheBlankQuestion" TO "anon";
GRANT ALL ON TABLE "public"."FillIneTheBlankQuestion" TO "authenticated";
GRANT ALL ON TABLE "public"."FillIneTheBlankQuestion" TO "service_role";

GRANT ALL ON TABLE "public"."ParentChildSubjectsLink" TO "anon";
GRANT ALL ON TABLE "public"."ParentChildSubjectsLink" TO "authenticated";
GRANT ALL ON TABLE "public"."ParentChildSubjectsLink" TO "service_role";

GRANT ALL ON TABLE "public"."Section" TO "anon";
GRANT ALL ON TABLE "public"."Section" TO "authenticated";
GRANT ALL ON TABLE "public"."Section" TO "service_role";

GRANT ALL ON TABLE "public"."FillInTheBlankTextFragment" TO "anon";
GRANT ALL ON TABLE "public"."FillInTheBlankTextFragment" TO "authenticated";
GRANT ALL ON TABLE "public"."FillInTheBlankTextFragment" TO "service_role";

GRANT ALL ON TABLE "public"."Question" TO "anon";
GRANT ALL ON TABLE "public"."Question" TO "authenticated";
GRANT ALL ON TABLE "public"."Question" TO "service_role";

GRANT ALL ON TABLE "public"."FillInTheBlankWrongResponse" TO "anon";
GRANT ALL ON TABLE "public"."FillInTheBlankWrongResponse" TO "authenticated";
GRANT ALL ON TABLE "public"."FillInTheBlankWrongResponse" TO "service_role";

GRANT ALL ON TABLE "public"."FillInTheBlankCorrectResponse" TO "anon";
GRANT ALL ON TABLE "public"."FillInTheBlankCorrectResponse" TO "authenticated";
GRANT ALL ON TABLE "public"."FillInTheBlankCorrectResponse" TO "service_role";

GRANT ALL ON TABLE "public"."MultipleChoiceQuestion" TO "anon";
GRANT ALL ON TABLE "public"."MultipleChoiceQuestion" TO "authenticated";
GRANT ALL ON TABLE "public"."MultipleChoiceQuestion" TO "service_role";

GRANT ALL ON TABLE "public"."QuestionsGame" TO "anon";
GRANT ALL ON TABLE "public"."QuestionsGame" TO "authenticated";
GRANT ALL ON TABLE "public"."QuestionsGame" TO "service_role";

GRANT ALL ON TABLE "public"."Sound" TO "anon";
GRANT ALL ON TABLE "public"."Sound" TO "authenticated";
GRANT ALL ON TABLE "public"."Sound" TO "service_role";

GRANT ALL ON TABLE "public"."Image" TO "anon";
GRANT ALL ON TABLE "public"."Image" TO "authenticated";
GRANT ALL ON TABLE "public"."Image" TO "service_role";

GRANT ALL ON TABLE "public"."Scene" TO "anon";
GRANT ALL ON TABLE "public"."Scene" TO "authenticated";
GRANT ALL ON TABLE "public"."Scene" TO "service_role";

GRANT ALL ON TABLE "public"."Story" TO "anon";
GRANT ALL ON TABLE "public"."Story" TO "authenticated";
GRANT ALL ON TABLE "public"."Story" TO "service_role";

GRANT ALL ON TABLE "public"."Subject" TO "anon";
GRANT ALL ON TABLE "public"."Subject" TO "authenticated";
GRANT ALL ON TABLE "public"."Subject" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";

RESET ALL;
