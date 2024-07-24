-- Insert parent subject
INSERT INTO "public"."Subject" (id, created_at, updated_at, title, description) VALUES
(1, NOW(), NULL, 'DATABASE', 'Parent subject for database-related topics');

-- Insert child subject
INSERT INTO "public"."Subject" (id, created_at, updated_at, title, description) VALUES
(2, NOW(), NULL, 'SQL', 'Child subject for SQL topics');

-- Link parent and child subjects
INSERT INTO "public"."ParentChildSubjectsLink" (created_at, updated_at, parent_id, child_id, label) VALUES
(NOW(), NULL, 1, 2, 'Database and SQL');

-- Insert sections for SQL subject
INSERT INTO "public"."Section" (id, created_at, updated_at, subject_id, kind, "order") VALUES
(1, NOW(), NULL, 2, 'QUESTIONS_GAME', 1),
(2, NOW(), NULL, 2, 'STORY', 2);

-- Insert QuestionsGame for section
INSERT INTO "public"."QuestionsGame" (id, created_at, updated_at, section_id) VALUES
(1, NOW(), NULL, 1);

-- Insert Question for QuestionsGame section
INSERT INTO "public"."Question" (id, created_at, updated_at, kind, question_game_id, "order") VALUES
(1, NOW(), NULL, 'MULTIPLE_CHOICE_QUESTION', 1, 1);

-- Insert MultipleChoiceQuestion related to SQL
INSERT INTO "public"."MultipleChoiceQuestion" (id, created_at, updated_at, text, question_id) VALUES
(1, NOW(), NULL, 'What does SQL stand for?', 1);

-- Insert responses for MultipleChoiceQuestion
INSERT INTO "public"."MultipleChoiceQuestionResponse" (id, created_at, updated_at, text, multiple_choice_question_id, is_correct) VALUES
(1, NOW(), NULL, 'Structured Query Language', 1, TRUE),
(2, NOW(), NULL, 'Simple Query Language', 1, FALSE),
(3, NOW(), NULL, 'Standard Query Language', 1, FALSE),
(4, NOW(), NULL, 'Sequential Query Language', 1, FALSE);

-- Insert Story for section
INSERT INTO "public"."Story" (id, created_at, updated_at, section_id) VALUES
(1, NOW(), NULL, 2);

-- Insert scenes for Story
INSERT INTO "public"."Scene" (id, created_at, updated_at, story_id) VALUES
(1, NOW(), NULL, 1),
(2, NOW(), NULL, 1);

-- Insert sounds for segments
INSERT INTO "public"."Sound" (id, created_at, updated_at, sound_url) VALUES
(1, NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/sounds/test_sound.mp3?t=2024-07-24T15%3A04%3A29.590Z'),
(2, NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/sounds/test_sound.mp3?t=2024-07-24T15%3A04%3A29.590Z');

-- Insert images for scenes
INSERT INTO "public"."Image" (id, created_at, updated_at, image_url, scene_id) VALUES
(1, NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/images/test_img.jpg', 1),
(2, NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/images/test_img.jpg', 2);

-- Insert segments for scenes
INSERT INTO "public"."Segment" (id, created_at, updated_at, text, sound_id, scene_id, "order") VALUES
(1, NOW(), NULL, 'This is the first segment of the first scene.', 1, 1, 1),
(2, NOW(), NULL, 'This is the first segment of the second scene.', 2, 2, 1);
