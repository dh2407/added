ALTER TABLE "public"."Question"
ADD CONSTRAINT unique_order_question_game_id
UNIQUE ("order", "question_game_id");
