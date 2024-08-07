
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

CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

COMMENT ON SCHEMA "public" IS 'standard public schema';

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

CREATE TYPE "public"."QuestionKind" AS ENUM (
    'MULTIPLE_CHOICE_QUESTION',
    'FILL_IN_THE_BLANKS_QUESTION'
);

ALTER TYPE "public"."QuestionKind" OWNER TO "postgres";

CREATE TYPE "public"."SectionKind" AS ENUM (
    'QUESTIONS_GAME',
    'STORY',
    'PAGE'
);

ALTER TYPE "public"."SectionKind" OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."Action" (
    "id" "uuid" NOT NULL,
    "label" character varying(255) NOT NULL,
    "next_section_id" "uuid" NOT NULL,
    "page_id" "uuid" NOT NULL
);

ALTER TABLE "public"."Action" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."FillInTheBlankCorrectResponse" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "order" bigint NOT NULL,
    "fill_in_the_blank_question_id" "uuid" NOT NULL,
    "text" "text" NOT NULL
);

ALTER TABLE "public"."FillInTheBlankCorrectResponse" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."FillInTheBlankTextFragment" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "text" "text" NOT NULL,
    "order" bigint NOT NULL,
    "fill_in_the_blank_question_id" "uuid" NOT NULL
);

ALTER TABLE "public"."FillInTheBlankTextFragment" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."FillInTheBlankWrongResponse" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "fill_in_the_blank_question_id" "uuid" NOT NULL,
    "text" "text" NOT NULL
);

ALTER TABLE "public"."FillInTheBlankWrongResponse" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."FillIneTheBlankQuestion" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "question_id" "uuid" NOT NULL
);

ALTER TABLE "public"."FillIneTheBlankQuestion" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Image" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "image_url" character varying(255) NOT NULL,
    "scene_id" "uuid" NOT NULL
);

ALTER TABLE "public"."Image" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."MultipleChoiceQuestion" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "text" "text" NOT NULL,
    "question_id" "uuid" NOT NULL
);

ALTER TABLE "public"."MultipleChoiceQuestion" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."MultipleChoiceQuestionResponse" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "text" "text" NOT NULL,
    "multiple_choice_question_id" "uuid" NOT NULL,
    "is_correct" boolean NOT NULL,
    "explanation" "text",
    "selected_score" numeric,
    "unselected_score" numeric
);

ALTER TABLE "public"."MultipleChoiceQuestionResponse" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Page" (
    "id" "uuid" NOT NULL,
    "section_id" "uuid" NOT NULL,
    "html" "text" NOT NULL
);

ALTER TABLE "public"."Page" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."ParentChildSubjectsLink" (
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "parent_id" "uuid" NOT NULL,
    "child_id" "uuid" NOT NULL,
    "label" character varying(255)
);

ALTER TABLE "public"."ParentChildSubjectsLink" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Question" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "kind" "public"."QuestionKind" NOT NULL,
    "question_game_id" "uuid" NOT NULL,
    "order" bigint NOT NULL
);

ALTER TABLE "public"."Question" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."QuestionsGame" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "section_id" "uuid"
);

ALTER TABLE "public"."QuestionsGame" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Scene" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "story_id" "uuid" NOT NULL
);

ALTER TABLE "public"."Scene" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Section" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "subject_id" "uuid",
    "kind" "public"."SectionKind",
    "order" bigint NOT NULL
);

ALTER TABLE "public"."Section" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Segment" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "text" character varying(255),
    "sound_id" "uuid",
    "scene_id" "uuid",
    "order" integer NOT NULL
);

ALTER TABLE "public"."Segment" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Sound" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "sound_url" character varying(255) NOT NULL
);

ALTER TABLE "public"."Sound" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Story" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "section_id" "uuid" NOT NULL
);

ALTER TABLE "public"."Story" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."Subject" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp without time zone,
    "title" character varying(255),
    "description" character varying(255)
);

ALTER TABLE "public"."Subject" OWNER TO "postgres";

ALTER TABLE ONLY "public"."Action"
    ADD CONSTRAINT "Action_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."FillInTheBlankCorrectResponse"
    ADD CONSTRAINT "FillInTheBlankCorrectResponse_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."FillInTheBlankTextFragment"
    ADD CONSTRAINT "FillInTheBlankTextFragment_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."FillInTheBlankWrongResponse"
    ADD CONSTRAINT "FillInTheBlankWrongResponse_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."FillIneTheBlankQuestion"
    ADD CONSTRAINT "FillIneTheBlankQuestion_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."Image"
    ADD CONSTRAINT "Image_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."MultipleChoiceQuestionResponse"
    ADD CONSTRAINT "MultipleChoiceQuestionResponse_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."MultipleChoiceQuestion"
    ADD CONSTRAINT "MultipleChoiceQuestion_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."Page"
    ADD CONSTRAINT "Page_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."ParentChildSubjectsLink"
    ADD CONSTRAINT "ParentChildSubjectsLink_pkey" PRIMARY KEY ("parent_id", "child_id");

ALTER TABLE ONLY "public"."Question"
    ADD CONSTRAINT "Question_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."QuestionsGame"
    ADD CONSTRAINT "QuestionsGame_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."QuestionsGame"
    ADD CONSTRAINT "QuestionsGame_section_id_key" UNIQUE ("section_id");

ALTER TABLE ONLY "public"."Scene"
    ADD CONSTRAINT "Scene_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."Section"
    ADD CONSTRAINT "Section_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."Segment"
    ADD CONSTRAINT "Segment_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."Sound"
    ADD CONSTRAINT "Sound_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."Story"
    ADD CONSTRAINT "Story_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."Story"
    ADD CONSTRAINT "Story_section_id_key" UNIQUE ("section_id");

ALTER TABLE ONLY "public"."Subject"
    ADD CONSTRAINT "Subject_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."Action"
    ADD CONSTRAINT "Action_next_section_id_foreign" FOREIGN KEY ("next_section_id") REFERENCES "public"."Section"("id");

ALTER TABLE ONLY "public"."Action"
    ADD CONSTRAINT "Action_page_id_foreign" FOREIGN KEY ("page_id") REFERENCES "public"."Page"("id");

ALTER TABLE ONLY "public"."ParentChildSubjectsLink"
    ADD CONSTRAINT "ParentChildSubjectsLink_child_id_fkey" FOREIGN KEY ("child_id") REFERENCES "public"."Subject"("id");

ALTER TABLE ONLY "public"."ParentChildSubjectsLink"
    ADD CONSTRAINT "ParentChildSubjectsLink_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."Subject"("id");

ALTER TABLE ONLY "public"."FillIneTheBlankQuestion"
    ADD CONSTRAINT "fillinetheblankquestion_question_id_foreign" FOREIGN KEY ("question_id") REFERENCES "public"."Question"("id");

ALTER TABLE ONLY "public"."FillInTheBlankCorrectResponse"
    ADD CONSTRAINT "fillintheblankcorrectresponse_fill_in_the_blank_question_id_for" FOREIGN KEY ("fill_in_the_blank_question_id") REFERENCES "public"."FillIneTheBlankQuestion"("id");

ALTER TABLE ONLY "public"."FillInTheBlankTextFragment"
    ADD CONSTRAINT "fillintheblanktextfragment_fill_in_the_blank_question_id_foreig" FOREIGN KEY ("fill_in_the_blank_question_id") REFERENCES "public"."FillIneTheBlankQuestion"("id");

ALTER TABLE ONLY "public"."FillInTheBlankWrongResponse"
    ADD CONSTRAINT "fillintheblankwrongresponse_fill_in_the_blank_question_id_forei" FOREIGN KEY ("fill_in_the_blank_question_id") REFERENCES "public"."FillIneTheBlankQuestion"("id");

ALTER TABLE ONLY "public"."Image"
    ADD CONSTRAINT "image_scene_id_foreign" FOREIGN KEY ("scene_id") REFERENCES "public"."Scene"("id");

ALTER TABLE ONLY "public"."MultipleChoiceQuestion"
    ADD CONSTRAINT "multiplechoicequestion_question_id_foreign" FOREIGN KEY ("question_id") REFERENCES "public"."Question"("id");

ALTER TABLE ONLY "public"."MultipleChoiceQuestionResponse"
    ADD CONSTRAINT "multiplechoicequestionresponse_multiple_choice_question_id_fore" FOREIGN KEY ("multiple_choice_question_id") REFERENCES "public"."MultipleChoiceQuestion"("id");

ALTER TABLE ONLY "public"."Page"
    ADD CONSTRAINT "page_section_id_foreign" FOREIGN KEY ("section_id") REFERENCES "public"."Section"("id");

ALTER TABLE ONLY "public"."Question"
    ADD CONSTRAINT "question_question_game_id_foreign" FOREIGN KEY ("question_game_id") REFERENCES "public"."QuestionsGame"("id");

ALTER TABLE ONLY "public"."QuestionsGame"
    ADD CONSTRAINT "questionsgame_section_id_foreign" FOREIGN KEY ("section_id") REFERENCES "public"."Section"("id");

ALTER TABLE ONLY "public"."Scene"
    ADD CONSTRAINT "scene_story_id_foreign" FOREIGN KEY ("story_id") REFERENCES "public"."Story"("id");

ALTER TABLE ONLY "public"."Section"
    ADD CONSTRAINT "section_subject_id_foreign" FOREIGN KEY ("subject_id") REFERENCES "public"."Subject"("id");

ALTER TABLE ONLY "public"."Segment"
    ADD CONSTRAINT "segment_scene_id_foreign" FOREIGN KEY ("scene_id") REFERENCES "public"."Scene"("id");

ALTER TABLE ONLY "public"."Segment"
    ADD CONSTRAINT "segment_sound_id_foreign" FOREIGN KEY ("sound_id") REFERENCES "public"."Sound"("id");

ALTER TABLE ONLY "public"."Story"
    ADD CONSTRAINT "story_section_id_foreign" FOREIGN KEY ("section_id") REFERENCES "public"."Section"("id");

ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON TABLE "public"."Action" TO "anon";
GRANT ALL ON TABLE "public"."Action" TO "authenticated";
GRANT ALL ON TABLE "public"."Action" TO "service_role";

GRANT ALL ON TABLE "public"."FillInTheBlankCorrectResponse" TO "anon";
GRANT ALL ON TABLE "public"."FillInTheBlankCorrectResponse" TO "authenticated";
GRANT ALL ON TABLE "public"."FillInTheBlankCorrectResponse" TO "service_role";

GRANT ALL ON TABLE "public"."FillInTheBlankTextFragment" TO "anon";
GRANT ALL ON TABLE "public"."FillInTheBlankTextFragment" TO "authenticated";
GRANT ALL ON TABLE "public"."FillInTheBlankTextFragment" TO "service_role";

GRANT ALL ON TABLE "public"."FillInTheBlankWrongResponse" TO "anon";
GRANT ALL ON TABLE "public"."FillInTheBlankWrongResponse" TO "authenticated";
GRANT ALL ON TABLE "public"."FillInTheBlankWrongResponse" TO "service_role";

GRANT ALL ON TABLE "public"."FillIneTheBlankQuestion" TO "anon";
GRANT ALL ON TABLE "public"."FillIneTheBlankQuestion" TO "authenticated";
GRANT ALL ON TABLE "public"."FillIneTheBlankQuestion" TO "service_role";

GRANT ALL ON TABLE "public"."Image" TO "anon";
GRANT ALL ON TABLE "public"."Image" TO "authenticated";
GRANT ALL ON TABLE "public"."Image" TO "service_role";

GRANT ALL ON TABLE "public"."MultipleChoiceQuestion" TO "anon";
GRANT ALL ON TABLE "public"."MultipleChoiceQuestion" TO "authenticated";
GRANT ALL ON TABLE "public"."MultipleChoiceQuestion" TO "service_role";

GRANT ALL ON TABLE "public"."MultipleChoiceQuestionResponse" TO "anon";
GRANT ALL ON TABLE "public"."MultipleChoiceQuestionResponse" TO "authenticated";
GRANT ALL ON TABLE "public"."MultipleChoiceQuestionResponse" TO "service_role";

GRANT ALL ON TABLE "public"."Page" TO "anon";
GRANT ALL ON TABLE "public"."Page" TO "authenticated";
GRANT ALL ON TABLE "public"."Page" TO "service_role";

GRANT ALL ON TABLE "public"."ParentChildSubjectsLink" TO "anon";
GRANT ALL ON TABLE "public"."ParentChildSubjectsLink" TO "authenticated";
GRANT ALL ON TABLE "public"."ParentChildSubjectsLink" TO "service_role";

GRANT ALL ON TABLE "public"."Question" TO "anon";
GRANT ALL ON TABLE "public"."Question" TO "authenticated";
GRANT ALL ON TABLE "public"."Question" TO "service_role";

GRANT ALL ON TABLE "public"."QuestionsGame" TO "anon";
GRANT ALL ON TABLE "public"."QuestionsGame" TO "authenticated";
GRANT ALL ON TABLE "public"."QuestionsGame" TO "service_role";

GRANT ALL ON TABLE "public"."Scene" TO "anon";
GRANT ALL ON TABLE "public"."Scene" TO "authenticated";
GRANT ALL ON TABLE "public"."Scene" TO "service_role";

GRANT ALL ON TABLE "public"."Section" TO "anon";
GRANT ALL ON TABLE "public"."Section" TO "authenticated";
GRANT ALL ON TABLE "public"."Section" TO "service_role";

GRANT ALL ON TABLE "public"."Segment" TO "anon";
GRANT ALL ON TABLE "public"."Segment" TO "authenticated";
GRANT ALL ON TABLE "public"."Segment" TO "service_role";

GRANT ALL ON TABLE "public"."Sound" TO "anon";
GRANT ALL ON TABLE "public"."Sound" TO "authenticated";
GRANT ALL ON TABLE "public"."Sound" TO "service_role";

GRANT ALL ON TABLE "public"."Story" TO "anon";
GRANT ALL ON TABLE "public"."Story" TO "authenticated";
GRANT ALL ON TABLE "public"."Story" TO "service_role";

GRANT ALL ON TABLE "public"."Subject" TO "anon";
GRANT ALL ON TABLE "public"."Subject" TO "authenticated";
GRANT ALL ON TABLE "public"."Subject" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;

--
-- Dumped schema changes for auth and storage
--

