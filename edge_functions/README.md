# SUPABASE CLI commands

## init repo (only one time)
supabase init

## install SUPABASE CLI 
brew install supabase/tap/supabase

## create new edge function
supabase functions new subject-add

## run locally
supabase start

## show supabase services status
supabase status

## Serve edge functions locally
supabase functions serve --import-map supabase/functions/import_map.json

## database commands
supabase migration new migration_name
supabase db push
supabase db diff
supabase db diff -f stable1 (to create local db migration file?)
supabase db pull
supabase migration up
supabase migration list

## login with the cli
supabase login

## get list of secrets from the logged in account
supabase secrets list

## link supabase with project
supabase link --project-ref oeuepxbxisbankcxncho

## deploy all functions 
supabase functions deploy

## list all functions
supabase functions list

# DATABASE Stored Functions:

## get_questions_of_subject

```
CREATE OR REPLACE FUNCTION get_subject_with_questions_by_subject_id(subject_id int8)
RETURNS TABLE (
  id int8,
  title text,
  description text,
  questions json
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s1.id,
    s1.title,
    s1.description,
    COALESCE(json_agg(
      json_build_object(
        'id', q.id,
        'type', q.type::text,
        'props', q.props,
        'label', qsl.label
      )
    ) FILTER (WHERE q.id IS NOT NULL), '[]') AS questions
  FROM
    "Subject" s1
  LEFT JOIN
    "QuestionToSubjectLink" qsl ON s1.id = qsl."subjectId"
  LEFT JOIN
    "Question" q ON qsl."questionId" = q.id
  WHERE
    s1.id = subject_id
  GROUP BY
    s1.id, s1.title, s1.description;
END;
$$ LANGUAGE plpgsql;
```

## get_subjects_with_children:
```
CREATE OR REPLACE FUNCTION get_subjects_with_children()
RETURNS TABLE (
  id int8,
  title text,
  description text,
  children json
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s1.id,
    s1.title,
    s1.description,
    COALESCE(json_agg(
      json_build_object(
        'id', s2.id,
        'title', s2.title,
        'description', s2.description
      )
    ) FILTER (WHERE s2.id IS NOT NULL), '[]') AS children
  FROM
    "Subject" s1
  LEFT JOIN
    "ParentChildSubjectsLink" pcsl ON s1.id = pcsl."parentId"
  LEFT JOIN
    "Subject" s2 ON pcsl."childId" = s2.id
  WHERE NOT EXISTS (
    SELECT 1
    FROM "ParentChildSubjectsLink" pcsl_check
    WHERE s1.id = pcsl_check."childId"
  )
  GROUP BY
    s1.id, s1.title, s1.description;
END;
$$ LANGUAGE plpgsql;
```

## get_subjects_with_children_by_parent_id:

```
CREATE OR REPLACE FUNCTION get_subjects_with_children_by_parent_id(parent_id int8)
RETURNS TABLE (
  id int8,
  title text,
  description text,
  children json
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s1.id,
    s1.title,
    s1.description,
    COALESCE(json_agg(
      json_build_object(
        'id', s2.id,
        'title', s2.title,
        'description', s2.description,
        'label', pcsl.label
      )
    ) FILTER (WHERE s2.id IS NOT NULL), '[]') AS children
  FROM
    "Subject" s1
  LEFT JOIN
    "ParentChildSubjectsLink" pcsl ON s1.id = pcsl."parentId"
  LEFT JOIN
    "Subject" s2 ON pcsl."childId" = s2.id
  WHERE
    s1.id = parent_id
  GROUP BY
    s1.id, s1.title, s1.description;
END;
$$ LANGUAGE plpgsql;
```