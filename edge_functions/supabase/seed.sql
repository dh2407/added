-- Generate UUIDs for the new rows
-- UUIDs are generated using the function uuid_generate_v4() in PostgreSQL

-- Insert parent subject
INSERT INTO "public"."Subject" (id, created_at, updated_at, title, description) VALUES
('7fa75e3e-b8cf-4e6c-9a23-731da3b78e37', NOW(), NULL, 'DATABASE', 'Parent subject for database-related topics');

-- Insert child subject
INSERT INTO "public"."Subject" (id, created_at, updated_at, title, description) VALUES
('a7c35f87-6b99-4cf4-9f7b-4fef2d7d85e1', NOW(), NULL, 'SQL', 'Child subject for SQL topics');

-- Link parent and child subjects
INSERT INTO "public"."ParentChildSubjectsLink" (created_at, updated_at, parent_id, child_id, label) VALUES
(NOW(), NULL, '7fa75e3e-b8cf-4e6c-9a23-731da3b78e37', 'a7c35f87-6b99-4cf4-9f7b-4fef2d7d85e1', 'Database and SQL');

-- Insert sections for SQL subject
INSERT INTO "public"."Section" (id, created_at, updated_at, subject_id, kind, "order") VALUES
('24f8410a-0b83-4a9b-a15f-5d0d8d4ad228', NOW(), NULL, 'a7c35f87-6b99-4cf4-9f7b-4fef2d7d85e1', 'QUESTIONS_GAME', 1),
('4cb51ec9-15e5-4d50-9149-6a34b841e481', NOW(), NULL, 'a7c35f87-6b99-4cf4-9f7b-4fef2d7d85e1', 'STORY', 2),
('e28b8877-bcdf-4c6d-9b24-9fd183a916ff', NOW(), NULL, 'a7c35f87-6b99-4cf4-9f7b-4fef2d7d85e1', 'PAGE', 3),
('d6e3a8c3-466b-4f12-9b0e-8417fda41a9b', NOW(), NULL, 'a7c35f87-6b99-4cf4-9f7b-4fef2d7d85e1', 'PAGE', 4);

-- Insert Story for section
INSERT INTO "public"."Story" (id, created_at, updated_at, section_id) VALUES
('3a98c9de-7d6d-45cb-8f7e-8d51e79ea2ab', NOW(), NULL, '4cb51ec9-15e5-4d50-9149-6a34b841e481');

-- Insert scenes for Story
INSERT INTO "public"."Scene" (id, created_at, updated_at, story_id) VALUES
('843c9a4e-4c0b-4d9a-8d8c-1b4c61049d78', NOW(), NULL, '3a98c9de-7d6d-45cb-8f7e-8d51e79ea2ab'),
('b235fa83-d8e7-4c67-9a32-7fddfc4bfa58', NOW(), NULL, '3a98c9de-7d6d-45cb-8f7e-8d51e79ea2ab');

-- Insert sounds for segments
INSERT INTO "public"."Sound" (id, created_at, updated_at, sound_url) VALUES
('4eb96e70-d283-451e-a3fc-46d5c9e0335a', NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/sounds/test_sound.mp3'),
('d6b2378a-1e7a-4860-b7b2-9b243f78a33c', NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/sounds/test_sound.mp3'),
('8949e8d5-f4ff-4d3f-9dc8-69e1bcbe285f', NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/sounds/test_sound.mp3'),
('7bc19116-8b3d-401a-9f2e-6d7b89a9c8e4', NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/sounds/test_sound.mp3');

-- Insert images for scenes
INSERT INTO "public"."Image" (id, created_at, updated_at, image_url, scene_id) VALUES
('ac0d3c28-814b-4bcf-96d1-b8891b4d5b7e', NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/images/img1.jpg', '843c9a4e-4c0b-4d9a-8d8c-1b4c61049d78'),
('0e81f460-cdd9-42b8-8098-bb4a90894ef0', NOW(), NULL, 'https://qboeskbhwinhgeigxzpw.supabase.co/storage/v1/object/public/images/img2.jpg', 'b235fa83-d8e7-4c67-9a32-7fddfc4bfa58');

-- Insert segments for scenes
INSERT INTO "public"."Segment" (id, created_at, updated_at, text, sound_id, scene_id, "order") VALUES
('3e8054d6-c30c-45e0-9171-e91e43c2499b', NOW(), NULL, 'This is the first segment of the first scene.', '4eb96e70-d283-451e-a3fc-46d5c9e0335a', '843c9a4e-4c0b-4d9a-8d8c-1b4c61049d78', 1),
('5c9f9d3f-6e62-4e98-b2f0-2a491d2dd7c7', NOW(), NULL, 'This is the second segment of the first scene.', 'd6b2378a-1e7a-4860-b7b2-9b243f78a33c', '843c9a4e-4c0b-4d9a-8d8c-1b4c61049d78', 2),
('127e840d-871f-47b1-9e18-192029c5f108', NOW(), NULL, 'This is the first segment of the second scene.', '8949e8d5-f4ff-4d3f-9dc8-69e1bcbe285f', 'b235fa83-d8e7-4c67-9a32-7fddfc4bfa58', 1),
('1b82e92d-843b-439e-8616-4b4c27cc358e', NOW(), NULL, 'This is the second segment of the second scene.', '7bc19116-8b3d-401a-9f2e-6d7b89a9c8e4', 'b235fa83-d8e7-4c67-9a32-7fddfc4bfa58', 2);

-- Insert QuestionsGame for section
INSERT INTO "public"."QuestionsGame" (id, created_at, updated_at, section_id) VALUES
('23d76163-2f21-497a-8ac5-cd1c0f5e6893', NOW(), NULL, '24f8410a-0b83-4a9b-a15f-5d0d8d4ad228');

-- Insert Question for QuestionsGame section
INSERT INTO "public"."Question" (id, created_at, updated_at, kind, question_game_id, "order") VALUES
('cb1a5b99-1777-43a4-998f-3e5c0e8b6fc0', NOW(), NULL, 'MULTIPLE_CHOICE_QUESTION', '23d76163-2f21-497a-8ac5-cd1c0f5e6893', 1);

-- Insert MultipleChoiceQuestion related to SQL
INSERT INTO "public"."MultipleChoiceQuestion" (id, created_at, updated_at, text, question_id) VALUES
('cd789d24-77d8-4269-878d-7b92c8b6f5a8', NOW(), NULL, 'What does SQL stand for?', 'cb1a5b99-1777-43a4-998f-3e5c0e8b6fc0');

-- Insert responses for MultipleChoiceQuestion
INSERT INTO "public"."MultipleChoiceQuestionResponse" (id, created_at, updated_at, text, multiple_choice_question_id, is_correct, selected_score, unselected_score ) VALUES
('5a6ed29b-04cc-4c1f-a8d8-c9dfbeb1e2c2', NOW(), NULL, 'Structured Query Language', 'cd789d24-77d8-4269-878d-7b92c8b6f5a8', TRUE, 2, -2),
('8d4d8b3e-3f0f-4262-8af3-1b4cbac00dbd', NOW(), NULL, 'Simple Query Language', 'cd789d24-77d8-4269-878d-7b92c8b6f5a8', FALSE, -2, 0),
('a769a83b-26e8-4f90-8f8f-40a15b7d1b74', NOW(), NULL, 'Standard Query Language', 'cd789d24-77d8-4269-878d-7b92c8b6f5a8', FALSE, -2, 0),
('b349c1e1-ef68-46b8-afe3-307f95182ff7', NOW(), NULL, 'Sequential Query Language', 'cd789d24-77d8-4269-878d-7b92c8b6f5a8', FALSE, -2, 0);

-- Insert Pages for the new sections
INSERT INTO "public"."Page" (id, section_id, html) VALUES
('f5a2d34c-52e7-41b5-9a24-8c8a5e60aef3', 'd6e3a8c3-466b-4f12-9b0e-8417fda41a9b', '<p>Would you like to join Sara and Bahi on this exciting adventure? If so, your journey as an SQL developer starts now. </p>'),
('c4b8c6da-565e-431e-97e5-709073e4fc6e', 'e28b8877-bcdf-4c6d-9b24-9fd183a916ff', '<h1>Interview Questions</h1><p>Welcome to your interview for the position of SQL Developer with Bahi and Sara''s team! This interview is designed to understand your determination, problem-solving skills, and your vision for the future.</p>');

-- Insert Actions for the new sections
INSERT INTO "public"."Action" (id, label, next_section_id, page_id) VALUES
('9adfd1f0-28fb-4293-bfcb-6e8b3e6e504f', 'Accept the Challenge', 'e28b8877-bcdf-4c6d-9b24-9fd183a916ff', 'f5a2d34c-52e7-41b5-9a24-8c8a5e60aef3'),
('2b931942-17a3-4f70-8e78-2c75e8e70a4f', 'Let''s get started', '4cb51ec9-15e5-4d50-9149-6a34b841e481', 'c4b8c6da-565e-431e-97e5-709073e4fc6e');
