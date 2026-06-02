drop extension if exists "pg_net";


  create table "public"."biometric_events" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "source" text not null,
    "measured_at" timestamp with time zone not null,
    "heart_rate_bpm" numeric(6,2),
    "hrv_rmssd" numeric(10,4),
    "hrv_sdnn" numeric(10,4),
    "activity_flag" text not null default 'unknown'::text,
    "confidence" numeric(4,3),
    "is_fresh" boolean not null default false,
    "created_at" timestamp with time zone not null default timezone('utc'::text, now())
      );


alter table "public"."biometric_events" enable row level security;


  create table "public"."biometric_feature_windows" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "window_started_at" timestamp with time zone not null,
    "window_ended_at" timestamp with time zone not null,
    "hr_mean" numeric(6,2),
    "hr_max" numeric(6,2),
    "hr_min" numeric(6,2),
    "hr_delta_from_baseline" numeric(6,2),
    "hrv_rmssd_current" numeric(10,4),
    "hrv_delta_from_baseline" numeric(10,4),
    "trend_up_minutes" integer,
    "context_time_of_day" text,
    "context_rest_state" text not null default 'unknown'::text,
    "feature_version" text not null default 'v1'::text,
    "created_at" timestamp with time zone not null default timezone('utc'::text, now())
      );


alter table "public"."biometric_feature_windows" enable row level security;


  create table "public"."notes" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "title" text not null,
    "content" text not null default ''::text,
    "created_at" timestamp with time zone not null default now()
      );


alter table "public"."notes" enable row level security;


  create table "public"."profiles" (
    "id" uuid not null,
    "email" text,
    "name" text,
    "avatar_url" text,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now(),
    "profession_profile" text,
    "birth_date" date,
    "gender" text,
    "city" text,
    "occupation" text,
    "relationship_status" text,
    "has_children" boolean,
    "sleep_schedule" text,
    "stress_level" integer,
    "energy_level" integer,
    "goals" text,
    "onboarding_completed" boolean default false,
    "trusted_contact_name" text,
    "trusted_contact_phone" text,
    "trusted_contact_note" text,
    "preferred_language" text,
    "timezone" text,
    "daily_routine" text,
    "energy_dip_time" text,
    "session_length_preference" text,
    "support_style" text,
    "work_format" text,
    "stress_triggers" text[] default '{}'::text[],
    "sleep_problems" text[] default '{}'::text[],
    "support_system_score" smallint,
    "self_regulation_experience" text,
    "emergency_help_preference" text,
    "crisis_plan_enabled" boolean default false
      );


alter table "public"."profiles" enable row level security;


  create table "public"."sessions" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "mode_key" text not null,
    "mode_title" text not null,
    "stress_level" integer not null,
    "stress_title" text not null,
    "source" text,
    "status" text not null default 'recommended'::text,
    "note" text,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now(),
    "user_note" text,
    "state_label" text,
    "heart_rate" integer,
    "notes" text,
    "started_at" timestamp with time zone default now(),
    "completed_at" timestamp with time zone,
    "result_rating" text,
    "result_note" text
      );


alter table "public"."sessions" enable row level security;


  create table "public"."stress_feedback_events" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "inference_id" uuid,
    "self_report_stress" integer,
    "felt_anxiety" boolean,
    "started_mode" text,
    "completed_mode" boolean,
    "relief_score_after" integer,
    "feedback_at" timestamp with time zone not null default timezone('utc'::text, now())
      );


alter table "public"."stress_feedback_events" enable row level security;


  create table "public"."stress_inference_results" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "inferred_at" timestamp with time zone not null,
    "state" text not null,
    "stress_score" numeric(6,2) not null default 0,
    "confidence_score" numeric(4,3) not null default 0,
    "trigger_type" text not null,
    "reason_codes" jsonb not null default '[]'::jsonb,
    "recommended_mode" text,
    "model_version" text not null default 'stress-v1'::text,
    "created_at" timestamp with time zone not null default timezone('utc'::text, now())
      );


alter table "public"."stress_inference_results" enable row level security;


  create table "public"."user_biometrics_baseline" (
    "user_id" uuid not null,
    "baseline_hr_rest" numeric(6,2),
    "baseline_hrv_rmssd" numeric(10,4),
    "baseline_hr_morning" numeric(6,2),
    "baseline_hr_day" numeric(6,2),
    "baseline_hr_evening" numeric(6,2),
    "baseline_quality_score" numeric(4,3) not null default 0,
    "days_accumulated" integer not null default 0,
    "updated_at" timestamp with time zone not null default timezone('utc'::text, now())
      );


alter table "public"."user_biometrics_baseline" enable row level security;

CREATE UNIQUE INDEX biometric_events_pkey ON public.biometric_events USING btree (id);

CREATE INDEX biometric_events_user_created_idx ON public.biometric_events USING btree (user_id, created_at DESC);

CREATE INDEX biometric_events_user_measured_idx ON public.biometric_events USING btree (user_id, measured_at DESC);

CREATE UNIQUE INDEX biometric_feature_windows_pkey ON public.biometric_feature_windows USING btree (id);

CREATE INDEX biometric_feature_windows_user_window_idx ON public.biometric_feature_windows USING btree (user_id, window_ended_at DESC);

CREATE UNIQUE INDEX notes_pkey ON public.notes USING btree (id);

CREATE INDEX notes_user_id_created_at_idx ON public.notes USING btree (user_id, created_at DESC);

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id);

CREATE UNIQUE INDEX sessions_pkey ON public.sessions USING btree (id);

CREATE INDEX sessions_started_at_idx ON public.sessions USING btree (started_at DESC);

CREATE INDEX sessions_status_idx ON public.sessions USING btree (status);

CREATE INDEX sessions_user_id_created_at_idx ON public.sessions USING btree (user_id, created_at DESC);

CREATE INDEX sessions_user_id_idx ON public.sessions USING btree (user_id);

CREATE UNIQUE INDEX stress_feedback_events_pkey ON public.stress_feedback_events USING btree (id);

CREATE INDEX stress_feedback_events_user_feedback_idx ON public.stress_feedback_events USING btree (user_id, feedback_at DESC);

CREATE UNIQUE INDEX stress_inference_results_pkey ON public.stress_inference_results USING btree (id);

CREATE INDEX stress_inference_results_user_inferred_idx ON public.stress_inference_results USING btree (user_id, inferred_at DESC);

CREATE UNIQUE INDEX user_biometrics_baseline_pkey ON public.user_biometrics_baseline USING btree (user_id);

alter table "public"."biometric_events" add constraint "biometric_events_pkey" PRIMARY KEY using index "biometric_events_pkey";

alter table "public"."biometric_feature_windows" add constraint "biometric_feature_windows_pkey" PRIMARY KEY using index "biometric_feature_windows_pkey";

alter table "public"."notes" add constraint "notes_pkey" PRIMARY KEY using index "notes_pkey";

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."sessions" add constraint "sessions_pkey" PRIMARY KEY using index "sessions_pkey";

alter table "public"."stress_feedback_events" add constraint "stress_feedback_events_pkey" PRIMARY KEY using index "stress_feedback_events_pkey";

alter table "public"."stress_inference_results" add constraint "stress_inference_results_pkey" PRIMARY KEY using index "stress_inference_results_pkey";

alter table "public"."user_biometrics_baseline" add constraint "user_biometrics_baseline_pkey" PRIMARY KEY using index "user_biometrics_baseline_pkey";

alter table "public"."biometric_events" add constraint "biometric_events_activity_flag_check" CHECK ((activity_flag = ANY (ARRAY['rest'::text, 'active'::text, 'unknown'::text]))) not valid;

alter table "public"."biometric_events" validate constraint "biometric_events_activity_flag_check";

alter table "public"."biometric_events" add constraint "biometric_events_source_check" CHECK ((source = ANY (ARRAY['apple_health'::text, 'watch'::text, 'manual_check'::text, 'derived_import'::text]))) not valid;

alter table "public"."biometric_events" validate constraint "biometric_events_source_check";

alter table "public"."biometric_events" add constraint "biometric_events_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."biometric_events" validate constraint "biometric_events_user_id_fkey";

alter table "public"."biometric_feature_windows" add constraint "biometric_feature_windows_context_rest_state_check" CHECK ((context_rest_state = ANY (ARRAY['rest'::text, 'active'::text, 'unknown'::text]))) not valid;

alter table "public"."biometric_feature_windows" validate constraint "biometric_feature_windows_context_rest_state_check";

alter table "public"."biometric_feature_windows" add constraint "biometric_feature_windows_context_time_of_day_check" CHECK ((context_time_of_day = ANY (ARRAY['morning'::text, 'day'::text, 'evening'::text, 'night'::text]))) not valid;

alter table "public"."biometric_feature_windows" validate constraint "biometric_feature_windows_context_time_of_day_check";

alter table "public"."biometric_feature_windows" add constraint "biometric_feature_windows_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."biometric_feature_windows" validate constraint "biometric_feature_windows_user_id_fkey";

alter table "public"."notes" add constraint "notes_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."notes" validate constraint "notes_user_id_fkey";

alter table "public"."profiles" add constraint "profiles_daily_routine_check" CHECK (((daily_routine IS NULL) OR (daily_routine = ANY (ARRAY['early_bird'::text, 'balanced'::text, 'night_owl'::text, 'irregular'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_daily_routine_check";

alter table "public"."profiles" add constraint "profiles_emergency_help_preference_check" CHECK (((emergency_help_preference IS NULL) OR (emergency_help_preference = ANY (ARRAY['self_help'::text, 'contact_person'::text, 'hotline'::text, 'depends'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_emergency_help_preference_check";

alter table "public"."profiles" add constraint "profiles_energy_dip_time_check" CHECK (((energy_dip_time IS NULL) OR (energy_dip_time = ANY (ARRAY['morning'::text, 'afternoon'::text, 'evening'::text, 'none'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_energy_dip_time_check";

alter table "public"."profiles" add constraint "profiles_energy_level_check" CHECK (((energy_level IS NULL) OR ((energy_level >= 1) AND (energy_level <= 10)))) not valid;

alter table "public"."profiles" validate constraint "profiles_energy_level_check";

alter table "public"."profiles" add constraint "profiles_gender_check" CHECK (((gender IS NULL) OR (gender = ANY (ARRAY['male'::text, 'female'::text, 'other'::text, 'prefer_not_to_say'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_gender_check";

alter table "public"."profiles" add constraint "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_id_fkey";

alter table "public"."profiles" add constraint "profiles_relationship_status_check" CHECK (((relationship_status IS NULL) OR (relationship_status = ANY (ARRAY['single'::text, 'in_relationship'::text, 'married'::text, 'divorced'::text, 'widowed'::text, 'complicated'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_relationship_status_check";

alter table "public"."profiles" add constraint "profiles_self_regulation_experience_check" CHECK (((self_regulation_experience IS NULL) OR (self_regulation_experience = ANY (ARRAY['beginner'::text, 'basic'::text, 'experienced'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_self_regulation_experience_check";

alter table "public"."profiles" add constraint "profiles_session_length_preference_check" CHECK (((session_length_preference IS NULL) OR (session_length_preference = ANY (ARRAY['short'::text, 'medium'::text, 'long'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_session_length_preference_check";

alter table "public"."profiles" add constraint "profiles_sleep_schedule_check" CHECK (((sleep_schedule IS NULL) OR (sleep_schedule = ANY (ARRAY['stable'::text, 'unstable'::text, 'shift'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_sleep_schedule_check";

alter table "public"."profiles" add constraint "profiles_stress_level_check" CHECK (((stress_level IS NULL) OR ((stress_level >= 1) AND (stress_level <= 10)))) not valid;

alter table "public"."profiles" validate constraint "profiles_stress_level_check";

alter table "public"."profiles" add constraint "profiles_support_style_check" CHECK (((support_style IS NULL) OR (support_style = ANY (ARRAY['gentle'::text, 'structured'::text, 'direct'::text, 'warm'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_support_style_check";

alter table "public"."profiles" add constraint "profiles_support_system_score_check" CHECK (((support_system_score IS NULL) OR ((support_system_score >= 1) AND (support_system_score <= 5)))) not valid;

alter table "public"."profiles" validate constraint "profiles_support_system_score_check";

alter table "public"."profiles" add constraint "profiles_work_format_check" CHECK (((work_format IS NULL) OR (work_format = ANY (ARRAY['office'::text, 'remote'::text, 'hybrid'::text, 'shift'::text, 'mobile'::text, 'caregiving'::text, 'study'::text])))) not valid;

alter table "public"."profiles" validate constraint "profiles_work_format_check";

alter table "public"."sessions" add constraint "sessions_result_rating_check" CHECK (((result_rating IS NULL) OR (result_rating = ANY (ARRAY['helped'::text, 'neutral'::text, 'not_helped'::text])))) not valid;

alter table "public"."sessions" validate constraint "sessions_result_rating_check";

alter table "public"."sessions" add constraint "sessions_status_check" CHECK ((status = ANY (ARRAY['started'::text, 'completed'::text, 'cancelled'::text]))) not valid;

alter table "public"."sessions" validate constraint "sessions_status_check";

alter table "public"."sessions" add constraint "sessions_stress_level_check" CHECK (((stress_level >= 1) AND (stress_level <= 4))) not valid;

alter table "public"."sessions" validate constraint "sessions_stress_level_check";

alter table "public"."sessions" add constraint "sessions_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."sessions" validate constraint "sessions_user_id_fkey";

alter table "public"."stress_feedback_events" add constraint "stress_feedback_events_inference_id_fkey" FOREIGN KEY (inference_id) REFERENCES public.stress_inference_results(id) ON DELETE SET NULL not valid;

alter table "public"."stress_feedback_events" validate constraint "stress_feedback_events_inference_id_fkey";

alter table "public"."stress_feedback_events" add constraint "stress_feedback_events_relief_score_after_check" CHECK (((relief_score_after >= 0) AND (relief_score_after <= 10))) not valid;

alter table "public"."stress_feedback_events" validate constraint "stress_feedback_events_relief_score_after_check";

alter table "public"."stress_feedback_events" add constraint "stress_feedback_events_self_report_stress_check" CHECK (((self_report_stress >= 0) AND (self_report_stress <= 10))) not valid;

alter table "public"."stress_feedback_events" validate constraint "stress_feedback_events_self_report_stress_check";

alter table "public"."stress_feedback_events" add constraint "stress_feedback_events_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."stress_feedback_events" validate constraint "stress_feedback_events_user_id_fkey";

alter table "public"."stress_inference_results" add constraint "stress_inference_results_state_check" CHECK ((state = ANY (ARRAY['calm'::text, 'tension'::text, 'stress'::text, 'insufficient_data'::text]))) not valid;

alter table "public"."stress_inference_results" validate constraint "stress_inference_results_state_check";

alter table "public"."stress_inference_results" add constraint "stress_inference_results_trigger_type_check" CHECK ((trigger_type = ANY (ARRAY['passive'::text, 'manual_check'::text, 'post_intervention'::text]))) not valid;

alter table "public"."stress_inference_results" validate constraint "stress_inference_results_trigger_type_check";

alter table "public"."stress_inference_results" add constraint "stress_inference_results_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."stress_inference_results" validate constraint "stress_inference_results_user_id_fkey";

alter table "public"."user_biometrics_baseline" add constraint "user_biometrics_baseline_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."user_biometrics_baseline" validate constraint "user_biometrics_baseline_user_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
begin
  insert into public.profiles (id, email, name)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'name', split_part(new.email, '@', 1))
  )
  on conflict (id) do nothing;
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user_profile()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
begin
  insert into public.profiles (id, name)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'name', '')
  )
  on conflict (id) do nothing;

  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.updated_at = now();
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.set_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.updated_at = now();
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.touch_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.updated_at = now();
  return new;
end;
$function$
;

grant delete on table "public"."biometric_events" to "anon";

grant insert on table "public"."biometric_events" to "anon";

grant references on table "public"."biometric_events" to "anon";

grant select on table "public"."biometric_events" to "anon";

grant trigger on table "public"."biometric_events" to "anon";

grant truncate on table "public"."biometric_events" to "anon";

grant update on table "public"."biometric_events" to "anon";

grant delete on table "public"."biometric_events" to "authenticated";

grant insert on table "public"."biometric_events" to "authenticated";

grant references on table "public"."biometric_events" to "authenticated";

grant select on table "public"."biometric_events" to "authenticated";

grant trigger on table "public"."biometric_events" to "authenticated";

grant truncate on table "public"."biometric_events" to "authenticated";

grant update on table "public"."biometric_events" to "authenticated";

grant delete on table "public"."biometric_events" to "service_role";

grant insert on table "public"."biometric_events" to "service_role";

grant references on table "public"."biometric_events" to "service_role";

grant select on table "public"."biometric_events" to "service_role";

grant trigger on table "public"."biometric_events" to "service_role";

grant truncate on table "public"."biometric_events" to "service_role";

grant update on table "public"."biometric_events" to "service_role";

grant delete on table "public"."biometric_feature_windows" to "anon";

grant insert on table "public"."biometric_feature_windows" to "anon";

grant references on table "public"."biometric_feature_windows" to "anon";

grant select on table "public"."biometric_feature_windows" to "anon";

grant trigger on table "public"."biometric_feature_windows" to "anon";

grant truncate on table "public"."biometric_feature_windows" to "anon";

grant update on table "public"."biometric_feature_windows" to "anon";

grant delete on table "public"."biometric_feature_windows" to "authenticated";

grant insert on table "public"."biometric_feature_windows" to "authenticated";

grant references on table "public"."biometric_feature_windows" to "authenticated";

grant select on table "public"."biometric_feature_windows" to "authenticated";

grant trigger on table "public"."biometric_feature_windows" to "authenticated";

grant truncate on table "public"."biometric_feature_windows" to "authenticated";

grant update on table "public"."biometric_feature_windows" to "authenticated";

grant delete on table "public"."biometric_feature_windows" to "service_role";

grant insert on table "public"."biometric_feature_windows" to "service_role";

grant references on table "public"."biometric_feature_windows" to "service_role";

grant select on table "public"."biometric_feature_windows" to "service_role";

grant trigger on table "public"."biometric_feature_windows" to "service_role";

grant truncate on table "public"."biometric_feature_windows" to "service_role";

grant update on table "public"."biometric_feature_windows" to "service_role";

grant delete on table "public"."notes" to "anon";

grant insert on table "public"."notes" to "anon";

grant references on table "public"."notes" to "anon";

grant select on table "public"."notes" to "anon";

grant trigger on table "public"."notes" to "anon";

grant truncate on table "public"."notes" to "anon";

grant update on table "public"."notes" to "anon";

grant delete on table "public"."notes" to "authenticated";

grant insert on table "public"."notes" to "authenticated";

grant references on table "public"."notes" to "authenticated";

grant select on table "public"."notes" to "authenticated";

grant trigger on table "public"."notes" to "authenticated";

grant truncate on table "public"."notes" to "authenticated";

grant update on table "public"."notes" to "authenticated";

grant delete on table "public"."notes" to "service_role";

grant insert on table "public"."notes" to "service_role";

grant references on table "public"."notes" to "service_role";

grant select on table "public"."notes" to "service_role";

grant trigger on table "public"."notes" to "service_role";

grant truncate on table "public"."notes" to "service_role";

grant update on table "public"."notes" to "service_role";

grant delete on table "public"."profiles" to "anon";

grant insert on table "public"."profiles" to "anon";

grant references on table "public"."profiles" to "anon";

grant select on table "public"."profiles" to "anon";

grant trigger on table "public"."profiles" to "anon";

grant truncate on table "public"."profiles" to "anon";

grant update on table "public"."profiles" to "anon";

grant delete on table "public"."profiles" to "authenticated";

grant insert on table "public"."profiles" to "authenticated";

grant references on table "public"."profiles" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant trigger on table "public"."profiles" to "authenticated";

grant truncate on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant delete on table "public"."profiles" to "service_role";

grant insert on table "public"."profiles" to "service_role";

grant references on table "public"."profiles" to "service_role";

grant select on table "public"."profiles" to "service_role";

grant trigger on table "public"."profiles" to "service_role";

grant truncate on table "public"."profiles" to "service_role";

grant update on table "public"."profiles" to "service_role";

grant delete on table "public"."sessions" to "anon";

grant insert on table "public"."sessions" to "anon";

grant references on table "public"."sessions" to "anon";

grant select on table "public"."sessions" to "anon";

grant trigger on table "public"."sessions" to "anon";

grant truncate on table "public"."sessions" to "anon";

grant update on table "public"."sessions" to "anon";

grant delete on table "public"."sessions" to "authenticated";

grant insert on table "public"."sessions" to "authenticated";

grant references on table "public"."sessions" to "authenticated";

grant select on table "public"."sessions" to "authenticated";

grant trigger on table "public"."sessions" to "authenticated";

grant truncate on table "public"."sessions" to "authenticated";

grant update on table "public"."sessions" to "authenticated";

grant delete on table "public"."sessions" to "service_role";

grant insert on table "public"."sessions" to "service_role";

grant references on table "public"."sessions" to "service_role";

grant select on table "public"."sessions" to "service_role";

grant trigger on table "public"."sessions" to "service_role";

grant truncate on table "public"."sessions" to "service_role";

grant update on table "public"."sessions" to "service_role";

grant delete on table "public"."stress_feedback_events" to "anon";

grant insert on table "public"."stress_feedback_events" to "anon";

grant references on table "public"."stress_feedback_events" to "anon";

grant select on table "public"."stress_feedback_events" to "anon";

grant trigger on table "public"."stress_feedback_events" to "anon";

grant truncate on table "public"."stress_feedback_events" to "anon";

grant update on table "public"."stress_feedback_events" to "anon";

grant delete on table "public"."stress_feedback_events" to "authenticated";

grant insert on table "public"."stress_feedback_events" to "authenticated";

grant references on table "public"."stress_feedback_events" to "authenticated";

grant select on table "public"."stress_feedback_events" to "authenticated";

grant trigger on table "public"."stress_feedback_events" to "authenticated";

grant truncate on table "public"."stress_feedback_events" to "authenticated";

grant update on table "public"."stress_feedback_events" to "authenticated";

grant delete on table "public"."stress_feedback_events" to "service_role";

grant insert on table "public"."stress_feedback_events" to "service_role";

grant references on table "public"."stress_feedback_events" to "service_role";

grant select on table "public"."stress_feedback_events" to "service_role";

grant trigger on table "public"."stress_feedback_events" to "service_role";

grant truncate on table "public"."stress_feedback_events" to "service_role";

grant update on table "public"."stress_feedback_events" to "service_role";

grant delete on table "public"."stress_inference_results" to "anon";

grant insert on table "public"."stress_inference_results" to "anon";

grant references on table "public"."stress_inference_results" to "anon";

grant select on table "public"."stress_inference_results" to "anon";

grant trigger on table "public"."stress_inference_results" to "anon";

grant truncate on table "public"."stress_inference_results" to "anon";

grant update on table "public"."stress_inference_results" to "anon";

grant delete on table "public"."stress_inference_results" to "authenticated";

grant insert on table "public"."stress_inference_results" to "authenticated";

grant references on table "public"."stress_inference_results" to "authenticated";

grant select on table "public"."stress_inference_results" to "authenticated";

grant trigger on table "public"."stress_inference_results" to "authenticated";

grant truncate on table "public"."stress_inference_results" to "authenticated";

grant update on table "public"."stress_inference_results" to "authenticated";

grant delete on table "public"."stress_inference_results" to "service_role";

grant insert on table "public"."stress_inference_results" to "service_role";

grant references on table "public"."stress_inference_results" to "service_role";

grant select on table "public"."stress_inference_results" to "service_role";

grant trigger on table "public"."stress_inference_results" to "service_role";

grant truncate on table "public"."stress_inference_results" to "service_role";

grant update on table "public"."stress_inference_results" to "service_role";

grant delete on table "public"."user_biometrics_baseline" to "anon";

grant insert on table "public"."user_biometrics_baseline" to "anon";

grant references on table "public"."user_biometrics_baseline" to "anon";

grant select on table "public"."user_biometrics_baseline" to "anon";

grant trigger on table "public"."user_biometrics_baseline" to "anon";

grant truncate on table "public"."user_biometrics_baseline" to "anon";

grant update on table "public"."user_biometrics_baseline" to "anon";

grant delete on table "public"."user_biometrics_baseline" to "authenticated";

grant insert on table "public"."user_biometrics_baseline" to "authenticated";

grant references on table "public"."user_biometrics_baseline" to "authenticated";

grant select on table "public"."user_biometrics_baseline" to "authenticated";

grant trigger on table "public"."user_biometrics_baseline" to "authenticated";

grant truncate on table "public"."user_biometrics_baseline" to "authenticated";

grant update on table "public"."user_biometrics_baseline" to "authenticated";

grant delete on table "public"."user_biometrics_baseline" to "service_role";

grant insert on table "public"."user_biometrics_baseline" to "service_role";

grant references on table "public"."user_biometrics_baseline" to "service_role";

grant select on table "public"."user_biometrics_baseline" to "service_role";

grant trigger on table "public"."user_biometrics_baseline" to "service_role";

grant truncate on table "public"."user_biometrics_baseline" to "service_role";

grant update on table "public"."user_biometrics_baseline" to "service_role";


  create policy "biometric_events_insert_own"
  on "public"."biometric_events"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "biometric_events_select_own"
  on "public"."biometric_events"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));



  create policy "biometric_events_update_own"
  on "public"."biometric_events"
  as permissive
  for update
  to public
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));



  create policy "biometric_feature_windows_insert_own"
  on "public"."biometric_feature_windows"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "biometric_feature_windows_select_own"
  on "public"."biometric_feature_windows"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));



  create policy "biometric_feature_windows_update_own"
  on "public"."biometric_feature_windows"
  as permissive
  for update
  to public
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));



  create policy "Users can delete their own notes"
  on "public"."notes"
  as permissive
  for delete
  to public
using ((auth.uid() = user_id));



  create policy "Users can insert their own notes"
  on "public"."notes"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "Users can update their own notes"
  on "public"."notes"
  as permissive
  for update
  to public
using ((auth.uid() = user_id));



  create policy "Users can view their own notes"
  on "public"."notes"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));



  create policy "notes_delete_own"
  on "public"."notes"
  as permissive
  for delete
  to authenticated
using ((auth.uid() = user_id));



  create policy "notes_insert_own"
  on "public"."notes"
  as permissive
  for insert
  to authenticated
with check ((auth.uid() = user_id));



  create policy "notes_select_own"
  on "public"."notes"
  as permissive
  for select
  to authenticated
using ((auth.uid() = user_id));



  create policy "notes_update_own"
  on "public"."notes"
  as permissive
  for update
  to authenticated
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));



  create policy "Users can insert own profile"
  on "public"."profiles"
  as permissive
  for insert
  to authenticated
with check ((auth.uid() = id));



  create policy "Users can update own profile"
  on "public"."profiles"
  as permissive
  for update
  to authenticated
using ((auth.uid() = id));



  create policy "Users can view own profile"
  on "public"."profiles"
  as permissive
  for select
  to authenticated
using ((auth.uid() = id));



  create policy "profiles_insert_own"
  on "public"."profiles"
  as permissive
  for insert
  to public
with check ((auth.uid() = id));



  create policy "profiles_select_own"
  on "public"."profiles"
  as permissive
  for select
  to public
using ((auth.uid() = id));



  create policy "profiles_update_own"
  on "public"."profiles"
  as permissive
  for update
  to public
using ((auth.uid() = id))
with check ((auth.uid() = id));



  create policy "Users can delete own sessions"
  on "public"."sessions"
  as permissive
  for delete
  to public
using ((auth.uid() = user_id));



  create policy "Users can insert own sessions"
  on "public"."sessions"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "Users can update own sessions"
  on "public"."sessions"
  as permissive
  for update
  to public
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));



  create policy "Users can view own sessions"
  on "public"."sessions"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));



  create policy "stress_feedback_events_insert_own"
  on "public"."stress_feedback_events"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "stress_feedback_events_select_own"
  on "public"."stress_feedback_events"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));



  create policy "stress_feedback_events_update_own"
  on "public"."stress_feedback_events"
  as permissive
  for update
  to public
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));



  create policy "stress_inference_results_insert_own"
  on "public"."stress_inference_results"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "stress_inference_results_select_own"
  on "public"."stress_inference_results"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));



  create policy "stress_inference_results_update_own"
  on "public"."stress_inference_results"
  as permissive
  for update
  to public
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));



  create policy "user_biometrics_baseline_insert_own"
  on "public"."user_biometrics_baseline"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "user_biometrics_baseline_select_own"
  on "public"."user_biometrics_baseline"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));



  create policy "user_biometrics_baseline_update_own"
  on "public"."user_biometrics_baseline"
  as permissive
  for update
  to public
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));


CREATE TRIGGER profiles_touch_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.touch_updated_at();

CREATE TRIGGER set_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER sessions_set_updated_at BEFORE UPDATE ON public.sessions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER set_sessions_updated_at BEFORE UPDATE ON public.sessions FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

CREATE TRIGGER on_auth_user_created_profile AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user_profile();


