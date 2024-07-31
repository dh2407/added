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