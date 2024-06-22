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

## database commands
supabase db diff
supabase db pull
supabase migration up


## login with the cli
supabase login

## get list of secrets from the logged in account
supabase secrets list

## link supabase with project
supabase link --project-ref ciokkearwodfqqkmvscq

## deploy all functions 
supabase functions deploy



# DATABASE Stored Functions:

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
        'description', s2.description
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