ALTER TABLE "public"."Section"
ADD CONSTRAINT unique_order_section_id UNIQUE ("order", "subject_id");
