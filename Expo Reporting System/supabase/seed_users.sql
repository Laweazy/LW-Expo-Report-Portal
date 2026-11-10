-- ==============================================================================
-- BATCH SEED ACCOUNTS FOR LOVEWORLD EXPO 2026 (155 REAL ACCOUNTS)
-- 2 Admins, 20 Clusters, 134 Authentic Exhibitors Across Pavilions 1 to 5
-- Paste directly into Supabase SQL Editor
-- ==============================================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- User: admin@expo2026.org (LoveWorld Expo Secretariat)
DO $$
DECLARE
    new_user_id UUID := 'af43e3ff-934e-482f-8e1a-bbd7a31376a2';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'admin@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'admin@expo2026.org',
            crypt('AdminExpo2026!Pass', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Lead Expo Admin","role":"admin","org":"LoveWorld Expo Secretariat"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'admin@expo2026.org', 'Lead Expo Admin', 'LoveWorld Expo Secretariat', 'admin', NULL, 'HQ-01', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: supervisor@expo2026.org (LoveWorld Expo Secretariat)
DO $$
DECLARE
    new_user_id UUID := 'd70d5cb0-933a-415a-b508-ceaca7caf833';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'supervisor@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'supervisor@expo2026.org',
            crypt('AdminExpo2026!Pass', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Reports Supervisor","role":"admin","org":"LoveWorld Expo Secretariat"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'supervisor@expo2026.org', 'Reports Supervisor', 'LoveWorld Expo Secretariat', 'admin', NULL, 'HQ-02', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster1@expo2026.org (Cluster 1)
DO $$
DECLARE
    new_user_id UUID := '8f723d4a-50a5-4979-8e63-b808054b8f74';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster1@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster1@expo2026.org',
            crypt('Cluster2026!#01', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 1 Leadership","role":"cluster","org":"Cluster 1"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster1@expo2026.org', 'Cluster 1 Leadership', 'Cluster 1', 'cluster', NULL, 'CL-01', 'Subchairman Cluster 1', 'Secretary Cluster 1'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster2@expo2026.org (Cluster 2)
DO $$
DECLARE
    new_user_id UUID := '09949fde-5768-47c9-a44a-a13e23a81b16';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster2@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster2@expo2026.org',
            crypt('Cluster2026!#02', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 2 Leadership","role":"cluster","org":"Cluster 2"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster2@expo2026.org', 'Cluster 2 Leadership', 'Cluster 2', 'cluster', NULL, 'CL-02', 'Subchairman Cluster 2', 'Secretary Cluster 2'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster3@expo2026.org (Cluster 3)
DO $$
DECLARE
    new_user_id UUID := 'a383de35-67a1-4de4-8aa5-60f6b568c957';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster3@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster3@expo2026.org',
            crypt('Cluster2026!#03', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 3 Leadership","role":"cluster","org":"Cluster 3"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster3@expo2026.org', 'Cluster 3 Leadership', 'Cluster 3', 'cluster', NULL, 'CL-03', 'Subchairman Cluster 3', 'Secretary Cluster 3'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster4@expo2026.org (Cluster 4)
DO $$
DECLARE
    new_user_id UUID := '0e73bb71-1b69-4e46-8bac-9bdbdb25e0ed';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster4@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster4@expo2026.org',
            crypt('Cluster2026!#04', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 4 Leadership","role":"cluster","org":"Cluster 4"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster4@expo2026.org', 'Cluster 4 Leadership', 'Cluster 4', 'cluster', NULL, 'CL-04', 'Subchairman Cluster 4', 'Secretary Cluster 4'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster5@expo2026.org (Cluster 5)
DO $$
DECLARE
    new_user_id UUID := '521f1cae-3645-4c48-b883-a0fa009f74ab';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster5@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster5@expo2026.org',
            crypt('Cluster2026!#05', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 5 Leadership","role":"cluster","org":"Cluster 5"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster5@expo2026.org', 'Cluster 5 Leadership', 'Cluster 5', 'cluster', NULL, 'CL-05', 'Subchairman Cluster 5', 'Secretary Cluster 5'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster6@expo2026.org (Cluster 6)
DO $$
DECLARE
    new_user_id UUID := '93279e0e-bc50-476d-bc9b-47fdce4d5c91';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster6@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster6@expo2026.org',
            crypt('Cluster2026!#06', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 6 Leadership","role":"cluster","org":"Cluster 6"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster6@expo2026.org', 'Cluster 6 Leadership', 'Cluster 6', 'cluster', NULL, 'CL-06', 'Subchairman Cluster 6', 'Secretary Cluster 6'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster7@expo2026.org (Cluster 7)
DO $$
DECLARE
    new_user_id UUID := '4c984a65-8bbe-4e2c-bc4b-18d6824912a6';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster7@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster7@expo2026.org',
            crypt('Cluster2026!#07', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 7 Leadership","role":"cluster","org":"Cluster 7"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster7@expo2026.org', 'Cluster 7 Leadership', 'Cluster 7', 'cluster', NULL, 'CL-07', 'Subchairman Cluster 7', 'Secretary Cluster 7'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster8@expo2026.org (Cluster 8)
DO $$
DECLARE
    new_user_id UUID := 'b088d519-a396-4a6b-a26f-1f8a299a3a7e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster8@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster8@expo2026.org',
            crypt('Cluster2026!#08', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 8 Leadership","role":"cluster","org":"Cluster 8"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster8@expo2026.org', 'Cluster 8 Leadership', 'Cluster 8', 'cluster', NULL, 'CL-08', 'Subchairman Cluster 8', 'Secretary Cluster 8'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster9@expo2026.org (Cluster 9)
DO $$
DECLARE
    new_user_id UUID := 'b3774ea3-40be-48dc-95ea-068f8b0223fc';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster9@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster9@expo2026.org',
            crypt('Cluster2026!#09', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 9 Leadership","role":"cluster","org":"Cluster 9"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster9@expo2026.org', 'Cluster 9 Leadership', 'Cluster 9', 'cluster', NULL, 'CL-09', 'Subchairman Cluster 9', 'Secretary Cluster 9'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster10@expo2026.org (Cluster 10)
DO $$
DECLARE
    new_user_id UUID := '1384cd29-2b43-4da8-96e7-9540a40ffe2d';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster10@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster10@expo2026.org',
            crypt('Cluster2026!#10', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 10 Leadership","role":"cluster","org":"Cluster 10"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster10@expo2026.org', 'Cluster 10 Leadership', 'Cluster 10', 'cluster', NULL, 'CL-10', 'Subchairman Cluster 10', 'Secretary Cluster 10'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster11@expo2026.org (Cluster 11)
DO $$
DECLARE
    new_user_id UUID := '61282b4c-1192-43b0-a3f4-5491ed99a630';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster11@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster11@expo2026.org',
            crypt('Cluster2026!#11', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 11 Leadership","role":"cluster","org":"Cluster 11"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster11@expo2026.org', 'Cluster 11 Leadership', 'Cluster 11', 'cluster', NULL, 'CL-11', 'Subchairman Cluster 11', 'Secretary Cluster 11'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster12@expo2026.org (Cluster 12)
DO $$
DECLARE
    new_user_id UUID := '63db9faa-d275-47de-bc6e-43b53aa8733f';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster12@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster12@expo2026.org',
            crypt('Cluster2026!#12', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 12 Leadership","role":"cluster","org":"Cluster 12"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster12@expo2026.org', 'Cluster 12 Leadership', 'Cluster 12', 'cluster', NULL, 'CL-12', 'Subchairman Cluster 12', 'Secretary Cluster 12'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster13@expo2026.org (Cluster 13)
DO $$
DECLARE
    new_user_id UUID := '462c6555-be56-49cf-92d7-9c530ef56c59';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster13@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster13@expo2026.org',
            crypt('Cluster2026!#13', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 13 Leadership","role":"cluster","org":"Cluster 13"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster13@expo2026.org', 'Cluster 13 Leadership', 'Cluster 13', 'cluster', NULL, 'CL-13', 'Subchairman Cluster 13', 'Secretary Cluster 13'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster14@expo2026.org (Cluster 14)
DO $$
DECLARE
    new_user_id UUID := '48ac86ae-afe4-40c1-a1d0-2e7615c3e3be';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster14@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster14@expo2026.org',
            crypt('Cluster2026!#14', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 14 Leadership","role":"cluster","org":"Cluster 14"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster14@expo2026.org', 'Cluster 14 Leadership', 'Cluster 14', 'cluster', NULL, 'CL-14', 'Subchairman Cluster 14', 'Secretary Cluster 14'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster15@expo2026.org (Cluster 15)
DO $$
DECLARE
    new_user_id UUID := 'fdf8126f-8053-4fb5-b0c3-ce4ca97641bc';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster15@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster15@expo2026.org',
            crypt('Cluster2026!#15', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 15 Leadership","role":"cluster","org":"Cluster 15"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster15@expo2026.org', 'Cluster 15 Leadership', 'Cluster 15', 'cluster', NULL, 'CL-15', 'Subchairman Cluster 15', 'Secretary Cluster 15'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster16@expo2026.org (Cluster 16)
DO $$
DECLARE
    new_user_id UUID := 'b7e862c2-68bb-4642-9fa9-d7d7de8916a8';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster16@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster16@expo2026.org',
            crypt('Cluster2026!#16', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 16 Leadership","role":"cluster","org":"Cluster 16"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster16@expo2026.org', 'Cluster 16 Leadership', 'Cluster 16', 'cluster', NULL, 'CL-16', 'Subchairman Cluster 16', 'Secretary Cluster 16'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster17@expo2026.org (Cluster 17)
DO $$
DECLARE
    new_user_id UUID := '4e57b33a-d3b6-4fb8-9ded-40607855fdf3';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster17@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster17@expo2026.org',
            crypt('Cluster2026!#17', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 17 Leadership","role":"cluster","org":"Cluster 17"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster17@expo2026.org', 'Cluster 17 Leadership', 'Cluster 17', 'cluster', NULL, 'CL-17', 'Subchairman Cluster 17', 'Secretary Cluster 17'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster18@expo2026.org (Cluster 18)
DO $$
DECLARE
    new_user_id UUID := '911c41be-0e4c-4f8c-a512-403b02497146';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster18@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster18@expo2026.org',
            crypt('Cluster2026!#18', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 18 Leadership","role":"cluster","org":"Cluster 18"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster18@expo2026.org', 'Cluster 18 Leadership', 'Cluster 18', 'cluster', NULL, 'CL-18', 'Subchairman Cluster 18', 'Secretary Cluster 18'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster19@expo2026.org (Cluster 19)
DO $$
DECLARE
    new_user_id UUID := '7d71a022-8f67-4c82-8bc6-e1aaad622224';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster19@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster19@expo2026.org',
            crypt('Cluster2026!#19', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 19 Leadership","role":"cluster","org":"Cluster 19"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster19@expo2026.org', 'Cluster 19 Leadership', 'Cluster 19', 'cluster', NULL, 'CL-19', 'Subchairman Cluster 19', 'Secretary Cluster 19'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: cluster20@expo2026.org (Cluster 20)
DO $$
DECLARE
    new_user_id UUID := 'b233c76d-e602-4deb-92ad-42fadadb837c';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cluster20@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'cluster20@expo2026.org',
            crypt('Cluster2026!#20', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cluster 20 Leadership","role":"cluster","org":"Cluster 20"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'cluster20@expo2026.org', 'Cluster 20 Leadership', 'Cluster 20', 'cluster', NULL, 'CL-20', 'Subchairman Cluster 20', 'Secretary Cluster 20'
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.360suite1@expo2026.org (360 Suite)
DO $$
DECLARE
    new_user_id UUID := '0b114763-080c-4bbc-a61e-845c021d65ce';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.360suite1@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.360suite1@expo2026.org',
            crypt('Expo2026!001', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"360 Suite Representative","role":"exhibitor","org":"360 Suite"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.360suite1@expo2026.org', '360 Suite Representative', '360 Suite', 'exhibitor', 'Cluster 1', 'P1-B01', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.ceflixsceptr2@expo2026.org (CeFlix Sceptre)
DO $$
DECLARE
    new_user_id UUID := '7a228772-3c19-41d1-8694-939b84c01a3f';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.ceflixsceptr2@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.ceflixsceptr2@expo2026.org',
            crypt('Expo2026!002', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"CeFlix Sceptre Representative","role":"exhibitor","org":"CeFlix Sceptre"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.ceflixsceptr2@expo2026.org', 'CeFlix Sceptre Representative', 'CeFlix Sceptre', 'exhibitor', 'Cluster 2', 'P1-B02', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.cloudax3@expo2026.org (Cloudax)
DO $$
DECLARE
    new_user_id UUID := '0c6406fb-0dd6-4516-8e7a-4b3ba1c363bd';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.cloudax3@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.cloudax3@expo2026.org',
            crypt('Expo2026!003', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cloudax Representative","role":"exhibitor","org":"Cloudax"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.cloudax3@expo2026.org', 'Cloudax Representative', 'Cloudax', 'exhibitor', 'Cluster 3', 'P1-B03', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.edenhubpraxi4@expo2026.org (Eden Hub (Praxiom))
DO $$
DECLARE
    new_user_id UUID := '220f0556-b11c-4162-9e90-5f6f4771251e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.edenhubpraxi4@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.edenhubpraxi4@expo2026.org',
            crypt('Expo2026!004', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Eden Hub (Praxiom) Representative","role":"exhibitor","org":"Eden Hub (Praxiom)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.edenhubpraxi4@expo2026.org', 'Eden Hub (Praxiom) Representative', 'Eden Hub (Praxiom)', 'exhibitor', 'Cluster 4', 'P1-B04', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.espees5@expo2026.org (Espees)
DO $$
DECLARE
    new_user_id UUID := 'd7bcf98d-1900-4eca-9e5c-a5ea41deb558';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.espees5@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.espees5@expo2026.org',
            crypt('Expo2026!005', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Espees Representative","role":"exhibitor","org":"Espees"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.espees5@expo2026.org', 'Espees Representative', 'Espees', 'exhibitor', 'Cluster 5', 'P1-B05', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.kingssuite6@expo2026.org (KingsSuite)
DO $$
DECLARE
    new_user_id UUID := 'c56fdda7-7448-44ac-8c0b-7500ccd55a62';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.kingssuite6@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.kingssuite6@expo2026.org',
            crypt('Expo2026!006', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"KingsSuite Representative","role":"exhibitor","org":"KingsSuite"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.kingssuite6@expo2026.org', 'KingsSuite Representative', 'KingsSuite', 'exhibitor', 'Cluster 6', 'P1-B06', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.neotech7@expo2026.org (NeoTech)
DO $$
DECLARE
    new_user_id UUID := 'd32a3d79-f4bb-4568-8e0e-1fa592d0375c';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.neotech7@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.neotech7@expo2026.org',
            crypt('Expo2026!007', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"NeoTech Representative","role":"exhibitor","org":"NeoTech"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.neotech7@expo2026.org', 'NeoTech Representative', 'NeoTech', 'exhibitor', 'Cluster 7', 'P1-B07', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.omniatechnol8@expo2026.org (Omnia Technologies)
DO $$
DECLARE
    new_user_id UUID := '13624768-118f-4680-b2be-399136d74e13';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.omniatechnol8@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.omniatechnol8@expo2026.org',
            crypt('Expo2026!008', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Omnia Technologies Representative","role":"exhibitor","org":"Omnia Technologies"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.omniatechnol8@expo2026.org', 'Omnia Technologies Representative', 'Omnia Technologies', 'exhibitor', 'Cluster 8', 'P1-B08', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.oneworld9@expo2026.org (One World)
DO $$
DECLARE
    new_user_id UUID := 'c90b3d9e-f282-4b73-bc63-6caeb540994f';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.oneworld9@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.oneworld9@expo2026.org',
            crypt('Expo2026!009', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"One World Representative","role":"exhibitor","org":"One World"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.oneworld9@expo2026.org', 'One World Representative', 'One World', 'exhibitor', 'Cluster 9', 'P1-B09', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.pcdl10@expo2026.org (PCDL)
DO $$
DECLARE
    new_user_id UUID := '1e422f72-d438-4973-9290-ad95f595e477';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.pcdl10@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.pcdl10@expo2026.org',
            crypt('Expo2026!010', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"PCDL Representative","role":"exhibitor","org":"PCDL"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.pcdl10@expo2026.org', 'PCDL Representative', 'PCDL', 'exhibitor', 'Cluster 10', 'P1-B10', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.qubators11@expo2026.org (Qubators)
DO $$
DECLARE
    new_user_id UUID := 'a885a7cf-9f75-48be-8c84-2c496b106d8f';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.qubators11@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.qubators11@expo2026.org',
            crypt('Expo2026!011', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Qubators Representative","role":"exhibitor","org":"Qubators"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.qubators11@expo2026.org', 'Qubators Representative', 'Qubators', 'exhibitor', 'Cluster 11', 'P1-B11', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.tsioncars12@expo2026.org (Tsion Cars)
DO $$
DECLARE
    new_user_id UUID := '39cf723b-5379-4054-a319-34f2758b3796';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.tsioncars12@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.tsioncars12@expo2026.org',
            crypt('Expo2026!012', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Tsion Cars Representative","role":"exhibitor","org":"Tsion Cars"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.tsioncars12@expo2026.org', 'Tsion Cars Representative', 'Tsion Cars', 'exhibitor', 'Cluster 12', 'P1-B12', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.worldstreetc13@expo2026.org (Worldstreet & Co)
DO $$
DECLARE
    new_user_id UUID := 'f91b950c-7924-4d95-8f07-471702f91be0';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.worldstreetc13@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.worldstreetc13@expo2026.org',
            crypt('Expo2026!013', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Worldstreet & Co Representative","role":"exhibitor","org":"Worldstreet & Co"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.worldstreetc13@expo2026.org', 'Worldstreet & Co Representative', 'Worldstreet & Co', 'exhibitor', 'Cluster 13', 'P1-B13', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.beverlymeals14@expo2026.org (Beverly Meals)
DO $$
DECLARE
    new_user_id UUID := '50a2fc7c-018b-438b-92c7-03b23b51ea33';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.beverlymeals14@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.beverlymeals14@expo2026.org',
            crypt('Expo2026!014', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Beverly Meals Representative","role":"exhibitor","org":"Beverly Meals"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.beverlymeals14@expo2026.org', 'Beverly Meals Representative', 'Beverly Meals', 'exhibitor', 'Cluster 14', 'P2-B01', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.blwcampusmin15@expo2026.org (BLW Campus Ministry)
DO $$
DECLARE
    new_user_id UUID := 'cd9351b4-d414-4cac-8ab7-86436844bea5';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.blwcampusmin15@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.blwcampusmin15@expo2026.org',
            crypt('Expo2026!015', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"BLW Campus Ministry Representative","role":"exhibitor","org":"BLW Campus Ministry"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.blwcampusmin15@expo2026.org', 'BLW Campus Ministry Representative', 'BLW Campus Ministry', 'exhibitor', 'Cluster 15', 'P2-B02', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.britishcanad16@expo2026.org (British Canadian University)
DO $$
DECLARE
    new_user_id UUID := '067ee286-2556-4761-96c0-0d05d73e32fc';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.britishcanad16@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.britishcanad16@expo2026.org',
            crypt('Expo2026!016', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"British Canadian University Representative","role":"exhibitor","org":"British Canadian University"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.britishcanad16@expo2026.org', 'British Canadian University Representative', 'British Canadian University', 'exhibitor', 'Cluster 16', 'P2-B03', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.bureaudechan17@expo2026.org (Bureau de Change)
DO $$
DECLARE
    new_user_id UUID := '8a6e4d70-fc14-4b27-b3a0-0799c3611786';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.bureaudechan17@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.bureaudechan17@expo2026.org',
            crypt('Expo2026!017', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Bureau de Change Representative","role":"exhibitor","org":"Bureau de Change"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.bureaudechan17@expo2026.org', 'Bureau de Change Representative', 'Bureau de Change', 'exhibitor', 'Cluster 17', 'P2-B04', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.childrenmini18@expo2026.org (Children Ministry)
DO $$
DECLARE
    new_user_id UUID := '9105d94f-3fa6-46fe-8c22-fc609f46c9c7';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.childrenmini18@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.childrenmini18@expo2026.org',
            crypt('Expo2026!018', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Children Ministry Representative","role":"exhibitor","org":"Children Ministry"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.childrenmini18@expo2026.org', 'Children Ministry Representative', 'Children Ministry', 'exhibitor', 'Cluster 18', 'P2-B05', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.chrisoyakhil19@expo2026.org (Chris Oyakhilome Foundation International (COFI))
DO $$
DECLARE
    new_user_id UUID := '4283d2c1-cb5c-4ddb-a804-5adb35006ebf';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.chrisoyakhil19@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.chrisoyakhil19@expo2026.org',
            crypt('Expo2026!019', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Chris Oyakhilome Foundation International (COFI) Representative","role":"exhibitor","org":"Chris Oyakhilome Foundation International (COFI)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.chrisoyakhil19@expo2026.org', 'Chris Oyakhilome Foundation International (COFI) Representative', 'Chris Oyakhilome Foundation International (COFI)', 'exhibitor', 'Cluster 19', 'P2-B06', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.churchminist20@expo2026.org (Church Ministry)
DO $$
DECLARE
    new_user_id UUID := '36ce35fd-7758-41e9-a075-b63ad2393b92';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.churchminist20@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.churchminist20@expo2026.org',
            crypt('Expo2026!020', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Church Ministry Representative","role":"exhibitor","org":"Church Ministry"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.churchminist20@expo2026.org', 'Church Ministry Representative', 'Church Ministry', 'exhibitor', 'Cluster 20', 'P2-B07', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.espeescorps21@expo2026.org (Espees Corps)
DO $$
DECLARE
    new_user_id UUID := '2ed2695e-ca6a-434a-91e7-49215c090999';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.espeescorps21@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.espeescorps21@expo2026.org',
            crypt('Expo2026!021', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Espees Corps Representative","role":"exhibitor","org":"Espees Corps"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.espeescorps21@expo2026.org', 'Espees Corps Representative', 'Espees Corps', 'exhibitor', 'Cluster 1', 'P2-B08', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.havennation22@expo2026.org (Haven Nation)
DO $$
DECLARE
    new_user_id UUID := '796bb6b8-93eb-4779-bb1a-15700e6c906b';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.havennation22@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.havennation22@expo2026.org',
            crypt('Expo2026!022', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Haven Nation Representative","role":"exhibitor","org":"Haven Nation"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.havennation22@expo2026.org', 'Haven Nation Representative', 'Haven Nation', 'exhibitor', 'Cluster 2', 'P2-B09', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.heraldapp23@expo2026.org (Herald App)
DO $$
DECLARE
    new_user_id UUID := '43c397f4-9ac0-4926-9fb2-47e490f74565';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.heraldapp23@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.heraldapp23@expo2026.org',
            crypt('Expo2026!023', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Herald App Representative","role":"exhibitor","org":"Herald App"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.heraldapp23@expo2026.org', 'Herald App Representative', 'Herald App', 'exhibitor', 'Cluster 3', 'P2-B10', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.innercitymis24@expo2026.org (Inner City Missions for Children)
DO $$
DECLARE
    new_user_id UUID := 'e2dbe3f7-9eaa-4ca2-8b2d-59a957b6a033';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.innercitymis24@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.innercitymis24@expo2026.org',
            crypt('Expo2026!024', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Inner City Missions for Children Representative","role":"exhibitor","org":"Inner City Missions for Children"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.innercitymis24@expo2026.org', 'Inner City Missions for Children Representative', 'Inner City Missions for Children', 'exhibitor', 'Cluster 4', 'P2-B11', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.kiddiesmedia25@expo2026.org (Kiddies Media Production/Lovetoons Comic)
DO $$
DECLARE
    new_user_id UUID := '75dcad04-6d31-4bb0-a19f-445f79fd7e36';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.kiddiesmedia25@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.kiddiesmedia25@expo2026.org',
            crypt('Expo2026!025', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Kiddies Media Production/Lovetoons Comic Representative","role":"exhibitor","org":"Kiddies Media Production/Lovetoons Comic"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.kiddiesmedia25@expo2026.org', 'Kiddies Media Production/Lovetoons Comic Representative', 'Kiddies Media Production/Lovetoons Comic', 'exhibitor', 'Cluster 5', 'P2-B12', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.lmamunending26@expo2026.org (LMAM Unending Praise)
DO $$
DECLARE
    new_user_id UUID := '7a09d632-50ef-4730-87b1-85b687366003';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.lmamunending26@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.lmamunending26@expo2026.org',
            crypt('Expo2026!026', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"LMAM Unending Praise Representative","role":"exhibitor","org":"LMAM Unending Praise"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.lmamunending26@expo2026.org', 'LMAM Unending Praise Representative', 'LMAM Unending Praise', 'exhibitor', 'Cluster 6', 'P2-B13', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldfil27@expo2026.org (Loveworld Film and Art Department)
DO $$
DECLARE
    new_user_id UUID := '4d3a9553-2c68-48d9-bb06-26b330e78135';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldfil27@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldfil27@expo2026.org',
            crypt('Expo2026!027', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Loveworld Film and Art Department Representative","role":"exhibitor","org":"Loveworld Film and Art Department"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldfil27@expo2026.org', 'Loveworld Film and Art Department Representative', 'Loveworld Film and Art Department', 'exhibitor', 'Cluster 7', 'P2-B14', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldlad28@expo2026.org (Loveworld Ladies Network)
DO $$
DECLARE
    new_user_id UUID := 'c60aa7e1-465f-44e6-bccd-e3b60370705e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldlad28@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldlad28@expo2026.org',
            crypt('Expo2026!028', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Loveworld Ladies Network Representative","role":"exhibitor","org":"Loveworld Ladies Network"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldlad28@expo2026.org', 'Loveworld Ladies Network Representative', 'Loveworld Ladies Network', 'exhibitor', 'Cluster 8', 'P2-B15', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldmin29@expo2026.org (Loveworld Ministry of Commerce)
DO $$
DECLARE
    new_user_id UUID := '7b37c906-f1a7-4ca2-aa8f-d5dfd4366c95';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldmin29@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldmin29@expo2026.org',
            crypt('Expo2026!029', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Loveworld Ministry of Commerce Representative","role":"exhibitor","org":"Loveworld Ministry of Commerce"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldmin29@expo2026.org', 'Loveworld Ministry of Commerce Representative', 'Loveworld Ministry of Commerce', 'exhibitor', 'Cluster 9', 'P2-B16', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldnet30@expo2026.org (Loveworld Networks)
DO $$
DECLARE
    new_user_id UUID := 'db6e8229-a2a8-4aba-a6df-a6924707316e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldnet30@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldnet30@expo2026.org',
            crypt('Expo2026!030', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Loveworld Networks Representative","role":"exhibitor","org":"Loveworld Networks"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldnet30@expo2026.org', 'Loveworld Networks Representative', 'Loveworld Networks', 'exhibitor', 'Cluster 10', 'P2-B17', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldsch31@expo2026.org (Loveworld Schools)
DO $$
DECLARE
    new_user_id UUID := 'fd0d27c5-8b8f-419c-a7ac-7b61fc423472';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldsch31@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldsch31@expo2026.org',
            crypt('Expo2026!031', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Loveworld Schools Representative","role":"exhibitor","org":"Loveworld Schools"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldsch31@expo2026.org', 'Loveworld Schools Representative', 'Loveworld Schools', 'exhibitor', 'Cluster 11', 'P2-B18', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldspo32@expo2026.org (Loveworld Sports & Youth Ministry)
DO $$
DECLARE
    new_user_id UUID := 'f88b3431-89bc-4ebc-a87d-13392bcb9c5a';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldspo32@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldspo32@expo2026.org',
            crypt('Expo2026!032', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Loveworld Sports & Youth Ministry Representative","role":"exhibitor","org":"Loveworld Sports & Youth Ministry"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldspo32@expo2026.org', 'Loveworld Sports & Youth Ministry Representative', 'Loveworld Sports & Youth Ministry', 'exhibitor', 'Cluster 12', 'P2-B19', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.mediablastne33@expo2026.org (Media Blast Network)
DO $$
DECLARE
    new_user_id UUID := '7f080f5d-af53-44b1-9d3b-4c90da7048a6';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.mediablastne33@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.mediablastne33@expo2026.org',
            crypt('Expo2026!033', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Media Blast Network Representative","role":"exhibitor","org":"Media Blast Network"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.mediablastne33@expo2026.org', 'Media Blast Network Representative', 'Media Blast Network', 'exhibitor', 'Cluster 13', 'P2-B20', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.ministryofdi34@expo2026.org (Ministry of Discipleship)
DO $$
DECLARE
    new_user_id UUID := 'e8eb2fa7-5396-439d-a70a-112d58bf49f0';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.ministryofdi34@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.ministryofdi34@expo2026.org',
            crypt('Expo2026!034', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Ministry of Discipleship Representative","role":"exhibitor","org":"Ministry of Discipleship"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.ministryofdi34@expo2026.org', 'Ministry of Discipleship Representative', 'Ministry of Discipleship', 'exhibitor', 'Cluster 14', 'P2-B21', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.ministryoffo35@expo2026.org (Ministry of Food Technology & Sovereignty)
DO $$
DECLARE
    new_user_id UUID := '1057b3ee-f904-420d-80fb-8a481adf031c';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.ministryoffo35@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.ministryoffo35@expo2026.org',
            crypt('Expo2026!035', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Ministry of Food Technology & Sovereignty Representative","role":"exhibitor","org":"Ministry of Food Technology & Sovereignty"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.ministryoffo35@expo2026.org', 'Ministry of Food Technology & Sovereignty Representative', 'Ministry of Food Technology & Sovereignty', 'exhibitor', 'Cluster 15', 'P2-B22', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.ministryofhu36@expo2026.org (Ministry of Human Resource Transformation)
DO $$
DECLARE
    new_user_id UUID := 'd9afe9c5-0ab5-4e9f-8770-d9fb8e3d6490';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.ministryofhu36@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.ministryofhu36@expo2026.org',
            crypt('Expo2026!036', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Ministry of Human Resource Transformation Representative","role":"exhibitor","org":"Ministry of Human Resource Transformation"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.ministryofhu36@expo2026.org', 'Ministry of Human Resource Transformation Representative', 'Ministry of Human Resource Transformation', 'exhibitor', 'Cluster 16', 'P2-B23', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.ministryprog37@expo2026.org (Ministry Programs)
DO $$
DECLARE
    new_user_id UUID := '04915068-867f-457e-abe7-5b6f0f0c0b60';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.ministryprog37@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.ministryprog37@expo2026.org',
            crypt('Expo2026!037', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Ministry Programs Representative","role":"exhibitor","org":"Ministry Programs"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.ministryprog37@expo2026.org', 'Ministry Programs Representative', 'Ministry Programs', 'exhibitor', 'Cluster 17', 'P2-B24', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.newmediamini38@expo2026.org (New Media Ministry)
DO $$
DECLARE
    new_user_id UUID := 'a717e3d3-c51b-4dcb-b08b-efcc953cfce8';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.newmediamini38@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.newmediamini38@expo2026.org',
            crypt('Expo2026!038', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"New Media Ministry Representative","role":"exhibitor","org":"New Media Ministry"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.newmediamini38@expo2026.org', 'New Media Ministry Representative', 'New Media Ministry', 'exhibitor', 'Cluster 18', 'P2-B25', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.nuclearmedic39@expo2026.org (Nuclear Medicine)
DO $$
DECLARE
    new_user_id UUID := 'e263798f-ea52-4f0a-9ba4-6e6fb063e0c4';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.nuclearmedic39@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.nuclearmedic39@expo2026.org',
            crypt('Expo2026!039', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Nuclear Medicine Representative","role":"exhibitor","org":"Nuclear Medicine"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.nuclearmedic39@expo2026.org', 'Nuclear Medicine Representative', 'Nuclear Medicine', 'exhibitor', 'Cluster 19', 'P2-B26', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.officeofthep40@expo2026.org (Office of the President & CELF)
DO $$
DECLARE
    new_user_id UUID := 'b91cfe77-9ee8-455b-b9e0-71e0024655ec';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.officeofthep40@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.officeofthep40@expo2026.org',
            crypt('Expo2026!040', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Office of the President & CELF Representative","role":"exhibitor","org":"Office of the President & CELF"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.officeofthep40@expo2026.org', 'Office of the President & CELF Representative', 'Office of the President & CELF', 'exhibitor', 'Cluster 20', 'P2-B27', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.parallexbank41@expo2026.org (Parallex Bank)
DO $$
DECLARE
    new_user_id UUID := '37316c35-81ac-499a-b97c-65038bfe2c12';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.parallexbank41@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.parallexbank41@expo2026.org',
            crypt('Expo2026!041', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Parallex Bank Representative","role":"exhibitor","org":"Parallex Bank"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.parallexbank41@expo2026.org', 'Parallex Bank Representative', 'Parallex Bank', 'exhibitor', 'Cluster 1', 'P2-B28', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.refugemortga42@expo2026.org (Refuge Mortgage Bank)
DO $$
DECLARE
    new_user_id UUID := 'd4d334f2-34b7-4a34-9e66-bf7381dc42db';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.refugemortga42@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.refugemortga42@expo2026.org',
            crypt('Expo2026!042', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Refuge Mortgage Bank Representative","role":"exhibitor","org":"Refuge Mortgage Bank"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.refugemortga42@expo2026.org', 'Refuge Mortgage Bank Representative', 'Refuge Mortgage Bank', 'exhibitor', 'Cluster 2', 'P2-B29', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.somsonsofmin43@expo2026.org (SOM (Sons of Ministry))
DO $$
DECLARE
    new_user_id UUID := '3ec1662d-a047-4554-bec3-6aaf18abbffd';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.somsonsofmin43@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.somsonsofmin43@expo2026.org',
            crypt('Expo2026!043', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"SOM (Sons of Ministry) Representative","role":"exhibitor","org":"SOM (Sons of Ministry)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.somsonsofmin43@expo2026.org', 'SOM (Sons of Ministry) Representative', 'SOM (Sons of Ministry)', 'exhibitor', 'Cluster 3', 'P2-B30', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.spectrummicr44@expo2026.org (Spectrum Micro Finance Bank)
DO $$
DECLARE
    new_user_id UUID := '11fa4b4b-5851-4ac8-a70e-62651ac9b2c7';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.spectrummicr44@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.spectrummicr44@expo2026.org',
            crypt('Expo2026!044', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Spectrum Micro Finance Bank Representative","role":"exhibitor","org":"Spectrum Micro Finance Bank"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.spectrummicr44@expo2026.org', 'Spectrum Micro Finance Bank Representative', 'Spectrum Micro Finance Bank', 'exhibitor', 'Cluster 4', 'P2-B31', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.angelmarketp45@expo2026.org (Angel Marketplace)
DO $$
DECLARE
    new_user_id UUID := '5af053b7-ce82-48ef-b39b-8d33763d384e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.angelmarketp45@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.angelmarketp45@expo2026.org',
            crypt('Expo2026!045', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Angel Marketplace Representative","role":"exhibitor","org":"Angel Marketplace"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.angelmarketp45@expo2026.org', 'Angel Marketplace Representative', 'Angel Marketplace', 'exhibitor', 'Cluster 5', 'P3-B01', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.crownelle46@expo2026.org (Crownelle)
DO $$
DECLARE
    new_user_id UUID := '08e76b0f-a325-4fba-ad7d-b4c4c43aee62';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.crownelle46@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.crownelle46@expo2026.org',
            crypt('Expo2026!046', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Crownelle Representative","role":"exhibitor","org":"Crownelle"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.crownelle46@expo2026.org', 'Crownelle Representative', 'Crownelle', 'exhibitor', 'Cluster 6', 'P3-B02', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.manifestonjo47@expo2026.org (Manifeston Journal & Movies)
DO $$
DECLARE
    new_user_id UUID := '0c7dd3fd-b9b6-4492-b6b6-fdd34a1d11f7';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.manifestonjo47@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.manifestonjo47@expo2026.org',
            crypt('Expo2026!047', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Manifeston Journal & Movies Representative","role":"exhibitor","org":"Manifeston Journal & Movies"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.manifestonjo47@expo2026.org', 'Manifeston Journal & Movies Representative', 'Manifeston Journal & Movies', 'exhibitor', 'Cluster 7', 'P3-B03', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.meridiantran48@expo2026.org (Meridian Translations)
DO $$
DECLARE
    new_user_id UUID := '767474bd-9437-4905-a412-b67a561f2c65';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.meridiantran48@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.meridiantran48@expo2026.org',
            crypt('Expo2026!048', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Meridian Translations Representative","role":"exhibitor","org":"Meridian Translations"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.meridiantran48@expo2026.org', 'Meridian Translations Representative', 'Meridian Translations', 'exhibitor', 'Cluster 8', 'P3-B04', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.reachoutcamp49@expo2026.org (Reach Out Campaigns)
DO $$
DECLARE
    new_user_id UUID := '1719b885-bf02-469f-9be4-e2950770fb2d';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.reachoutcamp49@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.reachoutcamp49@expo2026.org',
            crypt('Expo2026!049', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Reach Out Campaigns Representative","role":"exhibitor","org":"Reach Out Campaigns"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.reachoutcamp49@expo2026.org', 'Reach Out Campaigns Representative', 'Reach Out Campaigns', 'exhibitor', 'Cluster 9', 'P3-B05', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.reon50@expo2026.org (REON)
DO $$
DECLARE
    new_user_id UUID := 'bc53108c-dd4f-41f8-a6a8-6d1214bda5fe';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.reon50@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.reon50@expo2026.org',
            crypt('Expo2026!050', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"REON Representative","role":"exhibitor","org":"REON"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.reon50@expo2026.org', 'REON Representative', 'REON', 'exhibitor', 'Cluster 10', 'P3-B06', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.rhapsodydigi51@expo2026.org (Rhapsody Digital Products)
DO $$
DECLARE
    new_user_id UUID := 'ae4d526a-41a4-4931-9488-06f74b3dfdb4';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.rhapsodydigi51@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.rhapsodydigi51@expo2026.org',
            crypt('Expo2026!051', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Rhapsody Digital Products Representative","role":"exhibitor","org":"Rhapsody Digital Products"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.rhapsodydigi51@expo2026.org', 'Rhapsody Digital Products Representative', 'Rhapsody Digital Products', 'exhibitor', 'Cluster 11', 'P3-B07', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.rhapsodydist52@expo2026.org (Rhapsody Distribution Network)
DO $$
DECLARE
    new_user_id UUID := '6ab55579-9d43-458b-b3fc-1d6a9c7d1c0c';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.rhapsodydist52@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.rhapsodydist52@expo2026.org',
            crypt('Expo2026!052', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Rhapsody Distribution Network Representative","role":"exhibitor","org":"Rhapsody Distribution Network"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.rhapsodydist52@expo2026.org', 'Rhapsody Distribution Network Representative', 'Rhapsody Distribution Network', 'exhibitor', 'Cluster 12', 'P3-B08', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.rhapsodyinfl53@expo2026.org (Rhapsody Influencers Network)
DO $$
DECLARE
    new_user_id UUID := 'f0121e6d-e4fa-4863-a15e-1801663f1195';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.rhapsodyinfl53@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.rhapsodyinfl53@expo2026.org',
            crypt('Expo2026!053', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Rhapsody Influencers Network Representative","role":"exhibitor","org":"Rhapsody Influencers Network"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.rhapsodyinfl53@expo2026.org', 'Rhapsody Influencers Network Representative', 'Rhapsody Influencers Network', 'exhibitor', 'Cluster 13', 'P3-B09', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.rhapsodyinte54@expo2026.org (Rhapsody International Missions)
DO $$
DECLARE
    new_user_id UUID := '32ce5e6e-504a-4f66-9e3a-a23297627c52';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.rhapsodyinte54@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.rhapsodyinte54@expo2026.org',
            crypt('Expo2026!054', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Rhapsody International Missions Representative","role":"exhibitor","org":"Rhapsody International Missions"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.rhapsodyinte54@expo2026.org', 'Rhapsody International Missions Representative', 'Rhapsody International Missions', 'exhibitor', 'Cluster 14', 'P3-B10', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.rhapsodykidd55@expo2026.org (Rhapsody Kiddies Dailies with Pastor Chris)
DO $$
DECLARE
    new_user_id UUID := 'cb33e670-d037-4b7a-b8bb-48698bc09e97';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.rhapsodykidd55@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.rhapsodykidd55@expo2026.org',
            crypt('Expo2026!055', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Rhapsody Kiddies Dailies with Pastor Chris Representative","role":"exhibitor","org":"Rhapsody Kiddies Dailies with Pastor Chris"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.rhapsodykidd55@expo2026.org', 'Rhapsody Kiddies Dailies with Pastor Chris Representative', 'Rhapsody Kiddies Dailies with Pastor Chris', 'exhibitor', 'Cluster 15', 'P3-B11', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.rhapsodytech56@expo2026.org (Rhapsody Technologies)
DO $$
DECLARE
    new_user_id UUID := '27ee2530-85a3-4b38-9b4f-b49cc23061d0';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.rhapsodytech56@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.rhapsodytech56@expo2026.org',
            crypt('Expo2026!056', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Rhapsody Technologies Representative","role":"exhibitor","org":"Rhapsody Technologies"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.rhapsodytech56@expo2026.org', 'Rhapsody Technologies Representative', 'Rhapsody Technologies', 'exhibitor', 'Cluster 16', 'P3-B12', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.rhapsodytv57@expo2026.org (Rhapsody TV)
DO $$
DECLARE
    new_user_id UUID := 'a751baaf-360f-41b4-8578-e6a6db84f22f';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.rhapsodytv57@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.rhapsodytv57@expo2026.org',
            crypt('Expo2026!057', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Rhapsody TV Representative","role":"exhibitor","org":"Rhapsody TV"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.rhapsodytv57@expo2026.org', 'Rhapsody TV Representative', 'Rhapsody TV', 'exhibitor', 'Cluster 17', 'P3-B13', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.rork58@expo2026.org (RORK)
DO $$
DECLARE
    new_user_id UUID := '33a641a5-181e-433a-925d-72520c46bf7c';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.rork58@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.rork58@expo2026.org',
            crypt('Expo2026!058', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"RORK Representative","role":"exhibitor","org":"RORK"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.rork58@expo2026.org', 'RORK Representative', 'RORK', 'exhibitor', 'Cluster 18', 'P3-B14', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.smilecampaig59@expo2026.org (Smile Campaign)
DO $$
DECLARE
    new_user_id UUID := 'b3bf3d25-3b87-467f-a5c7-8e014f89f82f';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.smilecampaig59@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.smilecampaig59@expo2026.org',
            crypt('Expo2026!059', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Smile Campaign Representative","role":"exhibitor","org":"Smile Campaign"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.smilecampaig59@expo2026.org', 'Smile Campaign Representative', 'Smile Campaign', 'exhibitor', 'Cluster 19', 'P3-B15', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.tap2read60@expo2026.org (Tap2Read)
DO $$
DECLARE
    new_user_id UUID := 'fb0b5875-efc7-4574-8967-d1f22191f3e1';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.tap2read60@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.tap2read60@expo2026.org',
            crypt('Expo2026!060', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Tap2Read Representative","role":"exhibitor","org":"Tap2Read"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.tap2read60@expo2026.org', 'Tap2Read Representative', 'Tap2Read', 'exhibitor', 'Cluster 20', 'P3-B16', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.visionwear61@expo2026.org (Visionwear)
DO $$
DECLARE
    new_user_id UUID := '9d93682c-0824-42b4-99f3-c74038ef2e4e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.visionwear61@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.visionwear61@expo2026.org',
            crypt('Expo2026!061', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Visionwear Representative","role":"exhibitor","org":"Visionwear"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.visionwear61@expo2026.org', 'Visionwear Representative', 'Visionwear', 'exhibitor', 'Cluster 1', 'P3-B17', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.youthsaglow62@expo2026.org (Youths Aglow)
DO $$
DECLARE
    new_user_id UUID := '59debb6c-2e46-4dde-95dc-bc1b3e9c36bb';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.youthsaglow62@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.youthsaglow62@expo2026.org',
            crypt('Expo2026!062', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Youths Aglow Representative","role":"exhibitor","org":"Youths Aglow"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.youthsaglow62@expo2026.org', 'Youths Aglow Representative', 'Youths Aglow', 'exhibitor', 'Cluster 2', 'P3-B18', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.thegreatcomp63@expo2026.org (THE GREAT COMPANY)
DO $$
DECLARE
    new_user_id UUID := 'd77b59ae-5acf-44bc-8849-d93e16661093';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.thegreatcomp63@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.thegreatcomp63@expo2026.org',
            crypt('Expo2026!063', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"THE GREAT COMPANY Representative","role":"exhibitor","org":"THE GREAT COMPANY"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.thegreatcomp63@expo2026.org', 'THE GREAT COMPANY Representative', 'THE GREAT COMPANY', 'exhibitor', 'Cluster 3', 'P3-B19', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.rhapsodybibl64@expo2026.org (RHAPSODY BIBLES)
DO $$
DECLARE
    new_user_id UUID := 'b163798b-d09b-434d-8d1b-e5edd05f0c4b';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.rhapsodybibl64@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.rhapsodybibl64@expo2026.org',
            crypt('Expo2026!064', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"RHAPSODY BIBLES Representative","role":"exhibitor","org":"RHAPSODY BIBLES"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.rhapsodybibl64@expo2026.org', 'RHAPSODY BIBLES Representative', 'RHAPSODY BIBLES', 'exhibitor', 'Cluster 4', 'P3-B20', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.wondertv65@expo2026.org (WONDER TV)
DO $$
DECLARE
    new_user_id UUID := '8ab070fe-275b-4f83-bc97-2aa28971da98';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.wondertv65@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.wondertv65@expo2026.org',
            crypt('Expo2026!065', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"WONDER TV Representative","role":"exhibitor","org":"WONDER TV"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.wondertv65@expo2026.org', 'WONDER TV Representative', 'WONDER TV', 'exhibitor', 'Cluster 5', 'P3-B21', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.wonderkidstv66@expo2026.org (WONDERKIDS TV)
DO $$
DECLARE
    new_user_id UUID := '394338fc-e13f-4b80-9261-55a13902df30';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.wonderkidstv66@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.wonderkidstv66@expo2026.org',
            crypt('Expo2026!066', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"WONDERKIDS TV Representative","role":"exhibitor","org":"WONDERKIDS TV"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.wonderkidstv66@expo2026.org', 'WONDERKIDS TV Representative', 'WONDERKIDS TV', 'exhibitor', 'Cluster 6', 'P3-B22', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.aherogoestos67@expo2026.org (A HERO GOES TO SCHOOL)
DO $$
DECLARE
    new_user_id UUID := '56e2cb10-adaf-4441-94e9-2b506472fdb7';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.aherogoestos67@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.aherogoestos67@expo2026.org',
            crypt('Expo2026!067', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"A HERO GOES TO SCHOOL Representative","role":"exhibitor","org":"A HERO GOES TO SCHOOL"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.aherogoestos67@expo2026.org', 'A HERO GOES TO SCHOOL Representative', 'A HERO GOES TO SCHOOL', 'exhibitor', 'Cluster 7', 'P3-B23', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.seethroughah68@expo2026.org (SEE THROUGH A HERO)
DO $$
DECLARE
    new_user_id UUID := '37ed7413-f49d-4688-b622-d62b5c3afeee';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.seethroughah68@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.seethroughah68@expo2026.org',
            crypt('Expo2026!068', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"SEE THROUGH A HERO Representative","role":"exhibitor","org":"SEE THROUGH A HERO"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.seethroughah68@expo2026.org', 'SEE THROUGH A HERO Representative', 'SEE THROUGH A HERO', 'exhibitor', 'Cluster 8', 'P3-B24', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.thepowerofyo69@expo2026.org (THE POWER OF YOUR MIND)
DO $$
DECLARE
    new_user_id UUID := '532712e4-b91d-45e3-ac65-1f0e8c104d2a';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.thepowerofyo69@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.thepowerofyo69@expo2026.org',
            crypt('Expo2026!069', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"THE POWER OF YOUR MIND Representative","role":"exhibitor","org":"THE POWER OF YOUR MIND"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.thepowerofyo69@expo2026.org', 'THE POWER OF YOUR MIND Representative', 'THE POWER OF YOUR MIND', 'exhibitor', 'Cluster 9', 'P3-B25', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.heroesatchri70@expo2026.org (HEROES AT CHRISTMAS)
DO $$
DECLARE
    new_user_id UUID := '57597fad-16ea-4537-afba-bfd838dc3049';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.heroesatchri70@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.heroesatchri70@expo2026.org',
            crypt('Expo2026!070', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"HEROES AT CHRISTMAS Representative","role":"exhibitor","org":"HEROES AT CHRISTMAS"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.heroesatchri70@expo2026.org', 'HEROES AT CHRISTMAS Representative', 'HEROES AT CHRISTMAS', 'exhibitor', 'Cluster 10', 'P3-B26', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldchi71@expo2026.org (LOVEWORLD CHILDREN''S PUBLISHING)
DO $$
DECLARE
    new_user_id UUID := 'e914964d-2e48-4bd3-9d03-58e74759984c';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldchi71@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldchi71@expo2026.org',
            crypt('Expo2026!071', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"LOVEWORLD CHILDREN''S PUBLISHING Representative","role":"exhibitor","org":"LOVEWORLD CHILDREN''S PUBLISHING"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldchi71@expo2026.org', 'LOVEWORLD CHILDREN''S PUBLISHING Representative', 'LOVEWORLD CHILDREN''S PUBLISHING', 'exhibitor', 'Cluster 11', 'P3-B27', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldtee72@expo2026.org (LOVEWORLD TEENS PUBLISHING)
DO $$
DECLARE
    new_user_id UUID := 'bea7936a-5534-4abd-97c5-9aac837bae6b';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldtee72@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldtee72@expo2026.org',
            crypt('Expo2026!072', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"LOVEWORLD TEENS PUBLISHING Representative","role":"exhibitor","org":"LOVEWORLD TEENS PUBLISHING"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldtee72@expo2026.org', 'LOVEWORLD TEENS PUBLISHING Representative', 'LOVEWORLD TEENS PUBLISHING', 'exhibitor', 'Cluster 12', 'P3-B28', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.lwpublicatio73@expo2026.org (LW PUBLICATIONS - THE FULL BOOK RANGE)
DO $$
DECLARE
    new_user_id UUID := 'f57e8efa-65c9-45ef-8a1a-2e319a1c1375';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.lwpublicatio73@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.lwpublicatio73@expo2026.org',
            crypt('Expo2026!073', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"LW PUBLICATIONS - THE FULL BOOK RANGE Representative","role":"exhibitor","org":"LW PUBLICATIONS - THE FULL BOOK RANGE"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.lwpublicatio73@expo2026.org', 'LW PUBLICATIONS - THE FULL BOOK RANGE Representative', 'LW PUBLICATIONS - THE FULL BOOK RANGE', 'exhibitor', 'Cluster 13', 'P3-B29', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.biblesinmult74@expo2026.org (BIBLES IN MULTIPLE LANGUAGES AND FORMATS)
DO $$
DECLARE
    new_user_id UUID := '5a3dc92b-5ec0-46d3-9e92-2809a57fa7c7';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.biblesinmult74@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.biblesinmult74@expo2026.org',
            crypt('Expo2026!074', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"BIBLES IN MULTIPLE LANGUAGES AND FORMATS Representative","role":"exhibitor","org":"BIBLES IN MULTIPLE LANGUAGES AND FORMATS"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.biblesinmult74@expo2026.org', 'BIBLES IN MULTIPLE LANGUAGES AND FORMATS Representative', 'BIBLES IN MULTIPLE LANGUAGES AND FORMATS', 'exhibitor', 'Cluster 14', 'P3-B30', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.lifestyleand75@expo2026.org (LIFESTYLE AND PERSONAL CARE PRODUCTS)
DO $$
DECLARE
    new_user_id UUID := '1bd79cad-b7c9-403b-b011-b7fa60982639';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.lifestyleand75@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.lifestyleand75@expo2026.org',
            crypt('Expo2026!075', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"LIFESTYLE AND PERSONAL CARE PRODUCTS Representative","role":"exhibitor","org":"LIFESTYLE AND PERSONAL CARE PRODUCTS"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.lifestyleand75@expo2026.org', 'LIFESTYLE AND PERSONAL CARE PRODUCTS Representative', 'LIFESTYLE AND PERSONAL CARE PRODUCTS', 'exhibitor', 'Cluster 15', 'P3-B31', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.advancedscho76@expo2026.org (Advanced School of Technology)
DO $$
DECLARE
    new_user_id UUID := 'dbdaa821-9067-4fb8-99c2-6a448e17fe92';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.advancedscho76@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.advancedscho76@expo2026.org',
            crypt('Expo2026!076', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Advanced School of Technology Representative","role":"exhibitor","org":"Advanced School of Technology"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.advancedscho76@expo2026.org', 'Advanced School of Technology Representative', 'Advanced School of Technology', 'exhibitor', 'Cluster 16', 'P4-B01', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.chrisoyakhil77@expo2026.org (Chris Oyakhilome Foundation International (COFI - Health))
DO $$
DECLARE
    new_user_id UUID := '34e00112-b851-4f3e-86b9-669fa4ce8a7f';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.chrisoyakhil77@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.chrisoyakhil77@expo2026.org',
            crypt('Expo2026!077', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Chris Oyakhilome Foundation International (COFI - Health) Representative","role":"exhibitor","org":"Chris Oyakhilome Foundation International (COFI - Health)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.chrisoyakhil77@expo2026.org', 'Chris Oyakhilome Foundation International (COFI - Health) Representative', 'Chris Oyakhilome Foundation International (COFI - Health)', 'exhibitor', 'Cluster 17', 'P4-B02', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.directorateo78@expo2026.org (Directorate of Health Services)
DO $$
DECLARE
    new_user_id UUID := '8119b604-473e-4999-aa76-707a2dea9816';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.directorateo78@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.directorateo78@expo2026.org',
            crypt('Expo2026!078', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Directorate of Health Services Representative","role":"exhibitor","org":"Directorate of Health Services"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.directorateo78@expo2026.org', 'Directorate of Health Services Representative', 'Directorate of Health Services', 'exhibitor', 'Cluster 18', 'P4-B03', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.directorateo79@expo2026.org (Directorate of Social Services)
DO $$
DECLARE
    new_user_id UUID := '2bf3e50a-d5e7-444c-9367-24f4a3f156c2';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.directorateo79@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.directorateo79@expo2026.org',
            crypt('Expo2026!079', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Directorate of Social Services Representative","role":"exhibitor","org":"Directorate of Social Services"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.directorateo79@expo2026.org', 'Directorate of Social Services Representative', 'Directorate of Social Services', 'exhibitor', 'Cluster 19', 'P4-B04', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.futureafrica80@expo2026.org (Future Africa Leaders Foundation (FALF))
DO $$
DECLARE
    new_user_id UUID := 'e0f4d63c-c098-4f9e-a0c1-c280819ff90e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.futureafrica80@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.futureafrica80@expo2026.org',
            crypt('Expo2026!080', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Future Africa Leaders Foundation (FALF) Representative","role":"exhibitor","org":"Future Africa Leaders Foundation (FALF)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.futureafrica80@expo2026.org', 'Future Africa Leaders Foundation (FALF) Representative', 'Future Africa Leaders Foundation (FALF)', 'exhibitor', 'Cluster 20', 'P4-B05', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.globalyouthl81@expo2026.org (Global Youth Leaders Forum (GYLF))
DO $$
DECLARE
    new_user_id UUID := '5d730498-1ffc-475a-b202-c524887b50ae';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.globalyouthl81@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.globalyouthl81@expo2026.org',
            crypt('Expo2026!081', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Global Youth Leaders Forum (GYLF) Representative","role":"exhibitor","org":"Global Youth Leaders Forum (GYLF)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.globalyouthl81@expo2026.org', 'Global Youth Leaders Forum (GYLF) Representative', 'Global Youth Leaders Forum (GYLF)', 'exhibitor', 'Cluster 1', 'P4-B06', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.healingschoo82@expo2026.org (Healing School)
DO $$
DECLARE
    new_user_id UUID := '6b19ab2c-4ef5-470b-b796-48a5448a2b70';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.healingschoo82@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.healingschoo82@expo2026.org',
            crypt('Expo2026!082', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Healing School Representative","role":"exhibitor","org":"Healing School"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.healingschoo82@expo2026.org', 'Healing School Representative', 'Healing School', 'exhibitor', 'Cluster 2', 'P4-B07', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.internationa83@expo2026.org (International School of Ministry (ISM))
DO $$
DECLARE
    new_user_id UUID := 'f1494f82-7656-4d3e-88d4-a755bdd31e3c';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.internationa83@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.internationa83@expo2026.org',
            crypt('Expo2026!083', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"International School of Ministry (ISM) Representative","role":"exhibitor","org":"International School of Ministry (ISM)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.internationa83@expo2026.org', 'International School of Ministry (ISM) Representative', 'International School of Ministry (ISM)', 'exhibitor', 'Cluster 3', 'P4-B08', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.leadersschoo84@expo2026.org (Leaders School of Ministry (LSM))
DO $$
DECLARE
    new_user_id UUID := '3c94e915-67aa-4870-9f18-99fafae78d4e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.leadersschoo84@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.leadersschoo84@expo2026.org',
            crypt('Expo2026!084', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Leaders School of Ministry (LSM) Representative","role":"exhibitor","org":"Leaders School of Ministry (LSM)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.leadersschoo84@expo2026.org', 'Leaders School of Ministry (LSM) Representative', 'Leaders School of Ministry (LSM)', 'exhibitor', 'Cluster 4', 'P4-B09', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.lichtmarketi85@expo2026.org (Licht Marketing)
DO $$
DECLARE
    new_user_id UUID := 'e56f45f0-5f4a-4394-98ab-0cf757df10bb';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.lichtmarketi85@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.lichtmarketi85@expo2026.org',
            crypt('Expo2026!085', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Licht Marketing Representative","role":"exhibitor","org":"Licht Marketing"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.lichtmarketi85@expo2026.org', 'Licht Marketing Representative', 'Licht Marketing', 'exhibitor', 'Cluster 5', 'P4-B10', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldmed86@expo2026.org (Loveworld Medical Center)
DO $$
DECLARE
    new_user_id UUID := '18644ef4-d897-446b-b801-72c16501d967';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldmed86@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldmed86@expo2026.org',
            crypt('Expo2026!086', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Loveworld Medical Center Representative","role":"exhibitor","org":"Loveworld Medical Center"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldmed86@expo2026.org', 'Loveworld Medical Center Representative', 'Loveworld Medical Center', 'exhibitor', 'Cluster 6', 'P4-B11', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.loveworldmed87@expo2026.org (Loveworld Medical Foundation (LMF))
DO $$
DECLARE
    new_user_id UUID := '5acbee65-e5bf-4d63-a385-f8ce6eb384f3';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.loveworldmed87@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.loveworldmed87@expo2026.org',
            crypt('Expo2026!087', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Loveworld Medical Foundation (LMF) Representative","role":"exhibitor","org":"Loveworld Medical Foundation (LMF)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.loveworldmed87@expo2026.org', 'Loveworld Medical Foundation (LMF) Representative', 'Loveworld Medical Foundation (LMF)', 'exhibitor', 'Cluster 7', 'P4-B12', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.marpewellnes88@expo2026.org (Marpe Wellness)
DO $$
DECLARE
    new_user_id UUID := 'b4f7e609-17f7-40ea-8dc6-10c9cce2c9c8';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.marpewellnes88@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.marpewellnes88@expo2026.org',
            crypt('Expo2026!088', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Marpe Wellness Representative","role":"exhibitor","org":"Marpe Wellness"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.marpewellnes88@expo2026.org', 'Marpe Wellness Representative', 'Marpe Wellness', 'exhibitor', 'Cluster 8', 'P4-B13', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.ministryofhu89@expo2026.org (Ministry of Humanitarian Affairs)
DO $$
DECLARE
    new_user_id UUID := '8bd4f2c9-9607-4263-a730-149d668bb1f2';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.ministryofhu89@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.ministryofhu89@expo2026.org',
            crypt('Expo2026!089', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Ministry of Humanitarian Affairs Representative","role":"exhibitor","org":"Ministry of Humanitarian Affairs"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.ministryofhu89@expo2026.org', 'Ministry of Humanitarian Affairs Representative', 'Ministry of Humanitarian Affairs', 'exhibitor', 'Cluster 9', 'P4-B14', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.neotechhub90@expo2026.org (Neo Tech Hub)
DO $$
DECLARE
    new_user_id UUID := '4ce047df-40de-4888-8e42-ad0c7a942030';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.neotechhub90@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.neotechhub90@expo2026.org',
            crypt('Expo2026!090', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Neo Tech Hub Representative","role":"exhibitor","org":"Neo Tech Hub"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.neotechhub90@expo2026.org', 'Neo Tech Hub Representative', 'Neo Tech Hub', 'exhibitor', 'Cluster 10', 'P4-B15', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.nuclearmedic91@expo2026.org (Nuclear Medicine Museum)
DO $$
DECLARE
    new_user_id UUID := '62b3cc62-f5f6-4d32-8b62-e98adac5777b';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.nuclearmedic91@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.nuclearmedic91@expo2026.org',
            crypt('Expo2026!091', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Nuclear Medicine Museum Representative","role":"exhibitor","org":"Nuclear Medicine Museum"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.nuclearmedic91@expo2026.org', 'Nuclear Medicine Museum Representative', 'Nuclear Medicine Museum', 'exhibitor', 'Cluster 11', 'P4-B16', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.pastoraldeac92@expo2026.org (Pastoral Deaconry Nominees Training Program (PDNTP))
DO $$
DECLARE
    new_user_id UUID := 'c3176fec-ae3f-4020-9926-029a24e37598';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.pastoraldeac92@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.pastoraldeac92@expo2026.org',
            crypt('Expo2026!092', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Pastoral Deaconry Nominees Training Program (PDNTP) Representative","role":"exhibitor","org":"Pastoral Deaconry Nominees Training Program (PDNTP)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.pastoraldeac92@expo2026.org', 'Pastoral Deaconry Nominees Training Program (PDNTP) Representative', 'Pastoral Deaconry Nominees Training Program (PDNTP)', 'exhibitor', 'Cluster 12', 'P4-B17', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.kelseygreene93@expo2026.org (Kelsey Greene Group of Companies)
DO $$
DECLARE
    new_user_id UUID := 'f2a5964e-7c1d-4fc9-b36c-20d286521714';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.kelseygreene93@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.kelseygreene93@expo2026.org',
            crypt('Expo2026!093', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Kelsey Greene Group of Companies Representative","role":"exhibitor","org":"Kelsey Greene Group of Companies"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.kelseygreene93@expo2026.org', 'Kelsey Greene Group of Companies Representative', 'Kelsey Greene Group of Companies', 'exhibitor', 'Cluster 13', 'P5-B01', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.nazercompany94@expo2026.org (Nazer Company Limited)
DO $$
DECLARE
    new_user_id UUID := '7f9b3611-6ca7-402c-a1e4-cebbff3ed549';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.nazercompany94@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.nazercompany94@expo2026.org',
            crypt('Expo2026!094', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Nazer Company Limited Representative","role":"exhibitor","org":"Nazer Company Limited"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.nazercompany94@expo2026.org', 'Nazer Company Limited Representative', 'Nazer Company Limited', 'exhibitor', 'Cluster 14', 'P5-B02', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.primefoodsan95@expo2026.org (Prime Foods and Beverages Nigeria Limited)
DO $$
DECLARE
    new_user_id UUID := '5a6fcffe-f6a7-4be2-acb7-75d1fdbd175e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.primefoodsan95@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.primefoodsan95@expo2026.org',
            crypt('Expo2026!095', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Prime Foods and Beverages Nigeria Limited Representative","role":"exhibitor","org":"Prime Foods and Beverages Nigeria Limited"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.primefoodsan95@expo2026.org', 'Prime Foods and Beverages Nigeria Limited Representative', 'Prime Foods and Beverages Nigeria Limited', 'exhibitor', 'Cluster 15', 'P5-B03', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.foreverlovew96@expo2026.org (Forever Loveworld)
DO $$
DECLARE
    new_user_id UUID := 'ec3bc541-54d2-4344-aa09-bf2d1baaa7a2';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.foreverlovew96@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.foreverlovew96@expo2026.org',
            crypt('Expo2026!096', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Forever Loveworld Representative","role":"exhibitor","org":"Forever Loveworld"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.foreverlovew96@expo2026.org', 'Forever Loveworld Representative', 'Forever Loveworld', 'exhibitor', 'Cluster 16', 'P5-B04', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.madeinheaven97@expo2026.org (MadeInHeaven)
DO $$
DECLARE
    new_user_id UUID := '343c5aa8-c6c4-445c-8c71-c2ede7d71f54';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.madeinheaven97@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.madeinheaven97@expo2026.org',
            crypt('Expo2026!097', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"MadeInHeaven Representative","role":"exhibitor","org":"MadeInHeaven"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.madeinheaven97@expo2026.org', 'MadeInHeaven Representative', 'MadeInHeaven', 'exhibitor', 'Cluster 17', 'P5-B05', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.edenglow98@expo2026.org (Eden Glow)
DO $$
DECLARE
    new_user_id UUID := 'b9236cb6-64a0-4669-a835-6b9bde479363';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.edenglow98@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.edenglow98@expo2026.org',
            crypt('Expo2026!098', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Eden Glow Representative","role":"exhibitor","org":"Eden Glow"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.edenglow98@expo2026.org', 'Eden Glow Representative', 'Eden Glow', 'exhibitor', 'Cluster 18', 'P5-B06', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.houseofserap99@expo2026.org (House of Seraph)
DO $$
DECLARE
    new_user_id UUID := '440a0142-2bb8-4e4f-b82c-e955713363f3';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.houseofserap99@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.houseofserap99@expo2026.org',
            crypt('Expo2026!099', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"House of Seraph Representative","role":"exhibitor","org":"House of Seraph"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.houseofserap99@expo2026.org', 'House of Seraph Representative', 'House of Seraph', 'exhibitor', 'Cluster 19', 'P5-B07', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.ocaservices100@expo2026.org (OCA Services)
DO $$
DECLARE
    new_user_id UUID := '0ab53def-19c8-43aa-8107-3a0ea7170fb4';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.ocaservices100@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.ocaservices100@expo2026.org',
            crypt('Expo2026!100', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"OCA Services Representative","role":"exhibitor","org":"OCA Services"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.ocaservices100@expo2026.org', 'OCA Services Representative', 'OCA Services', 'exhibitor', 'Cluster 20', 'P5-B08', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.elenchoscons101@expo2026.org (Elenchos Consulting Limited)
DO $$
DECLARE
    new_user_id UUID := '9110366b-3d88-4092-9540-d94dbce9fb2a';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.elenchoscons101@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.elenchoscons101@expo2026.org',
            crypt('Expo2026!101', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Elenchos Consulting Limited Representative","role":"exhibitor","org":"Elenchos Consulting Limited"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.elenchoscons101@expo2026.org', 'Elenchos Consulting Limited Representative', 'Elenchos Consulting Limited', 'exhibitor', 'Cluster 1', 'P5-B09', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.cedarandcrad102@expo2026.org (Cedar and Cradle Limited)
DO $$
DECLARE
    new_user_id UUID := '8f11d0e7-4cee-4e13-9d96-350db4a97e9a';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.cedarandcrad102@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.cedarandcrad102@expo2026.org',
            crypt('Expo2026!102', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cedar and Cradle Limited Representative","role":"exhibitor","org":"Cedar and Cradle Limited"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.cedarandcrad102@expo2026.org', 'Cedar and Cradle Limited Representative', 'Cedar and Cradle Limited', 'exhibitor', 'Cluster 2', 'P5-B10', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.sharesservic103@expo2026.org (Shares Service Limited)
DO $$
DECLARE
    new_user_id UUID := '9a8febdb-11d8-4491-8093-802365d37fd4';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.sharesservic103@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.sharesservic103@expo2026.org',
            crypt('Expo2026!103', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Shares Service Limited Representative","role":"exhibitor","org":"Shares Service Limited"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.sharesservic103@expo2026.org', 'Shares Service Limited Representative', 'Shares Service Limited', 'exhibitor', 'Cluster 3', 'P5-B11', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.norahminingl104@expo2026.org (Norah Mining Limited)
DO $$
DECLARE
    new_user_id UUID := '0be9ba09-7769-4e4e-9fec-efbcea2cc107';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.norahminingl104@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.norahminingl104@expo2026.org',
            crypt('Expo2026!104', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Norah Mining Limited Representative","role":"exhibitor","org":"Norah Mining Limited"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.norahminingl104@expo2026.org', 'Norah Mining Limited Representative', 'Norah Mining Limited', 'exhibitor', 'Cluster 4', 'P5-B12', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.lichtgroup105@expo2026.org (Licht Group)
DO $$
DECLARE
    new_user_id UUID := '95bf1a57-26aa-4715-b9bd-2345d5670b68';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.lichtgroup105@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.lichtgroup105@expo2026.org',
            crypt('Expo2026!105', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Licht Group Representative","role":"exhibitor","org":"Licht Group"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.lichtgroup105@expo2026.org', 'Licht Group Representative', 'Licht Group', 'exhibitor', 'Cluster 5', 'P5-B13', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.auxano106@expo2026.org (Auxano)
DO $$
DECLARE
    new_user_id UUID := 'a4924374-4bf4-4967-8d11-e23a9bb2c679';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.auxano106@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.auxano106@expo2026.org',
            crypt('Expo2026!106', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Auxano Representative","role":"exhibitor","org":"Auxano"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.auxano106@expo2026.org', 'Auxano Representative', 'Auxano', 'exhibitor', 'Cluster 6', 'P5-B14', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.pointek107@expo2026.org (Pointek)
DO $$
DECLARE
    new_user_id UUID := '17d942c3-0638-4f7f-b876-0bdbd689d23e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.pointek107@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.pointek107@expo2026.org',
            crypt('Expo2026!107', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Pointek Representative","role":"exhibitor","org":"Pointek"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.pointek107@expo2026.org', 'Pointek Representative', 'Pointek', 'exhibitor', 'Cluster 7', 'P5-B15', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.parallexbank108@expo2026.org (Parallex Bank (Marketplace))
DO $$
DECLARE
    new_user_id UUID := '44de4e0f-071f-427f-8ced-4d2acf22fd9b';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.parallexbank108@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.parallexbank108@expo2026.org',
            crypt('Expo2026!108', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Parallex Bank (Marketplace) Representative","role":"exhibitor","org":"Parallex Bank (Marketplace)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.parallexbank108@expo2026.org', 'Parallex Bank (Marketplace) Representative', 'Parallex Bank (Marketplace)', 'exhibitor', 'Cluster 8', 'P5-B16', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.fashionredem109@expo2026.org (Fashion Redemption)
DO $$
DECLARE
    new_user_id UUID := '0b2214c2-9c11-4577-bfd0-fe70d83af2cf';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.fashionredem109@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.fashionredem109@expo2026.org',
            crypt('Expo2026!109', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Fashion Redemption Representative","role":"exhibitor","org":"Fashion Redemption"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.fashionredem109@expo2026.org', 'Fashion Redemption Representative', 'Fashion Redemption', 'exhibitor', 'Cluster 9', 'P5-B17', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.homeworldsup110@expo2026.org (Home World Supermarket)
DO $$
DECLARE
    new_user_id UUID := 'c70bb718-21c7-4ef3-b6a0-8dc048508c93';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.homeworldsup110@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.homeworldsup110@expo2026.org',
            crypt('Expo2026!110', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Home World Supermarket Representative","role":"exhibitor","org":"Home World Supermarket"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.homeworldsup110@expo2026.org', 'Home World Supermarket Representative', 'Home World Supermarket', 'exhibitor', 'Cluster 10', 'P5-B18', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.dollynationk111@expo2026.org (Dolly Nation Kayla''s Castle)
DO $$
DECLARE
    new_user_id UUID := '54532687-d115-448d-9b16-d6c3b674a7b3';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.dollynationk111@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.dollynationk111@expo2026.org',
            crypt('Expo2026!111', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Dolly Nation Kayla''s Castle Representative","role":"exhibitor","org":"Dolly Nation Kayla''s Castle"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.dollynationk111@expo2026.org', 'Dolly Nation Kayla''s Castle Representative', 'Dolly Nation Kayla''s Castle', 'exhibitor', 'Cluster 11', 'P5-B19', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.celebritysty112@expo2026.org (Celebrity Style)
DO $$
DECLARE
    new_user_id UUID := 'bace151d-e64d-440a-ae7b-3130948060c3';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.celebritysty112@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.celebritysty112@expo2026.org',
            crypt('Expo2026!112', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Celebrity Style Representative","role":"exhibitor","org":"Celebrity Style"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.celebritysty112@expo2026.org', 'Celebrity Style Representative', 'Celebrity Style', 'exhibitor', 'Cluster 12', 'P5-B20', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.fashionredem113@expo2026.org (Fashion Redemption Print)
DO $$
DECLARE
    new_user_id UUID := 'cbb389fd-c644-469b-9037-c2b11ee01c35';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.fashionredem113@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.fashionredem113@expo2026.org',
            crypt('Expo2026!113', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Fashion Redemption Print Representative","role":"exhibitor","org":"Fashion Redemption Print"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.fashionredem113@expo2026.org', 'Fashion Redemption Print Representative', 'Fashion Redemption Print', 'exhibitor', 'Cluster 13', 'P5-B21', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.jazari114@expo2026.org (Jazari)
DO $$
DECLARE
    new_user_id UUID := 'cdfa28dc-99ad-4be7-888c-d5b271a69ae3';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.jazari114@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.jazari114@expo2026.org',
            crypt('Expo2026!114', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Jazari Representative","role":"exhibitor","org":"Jazari"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.jazari114@expo2026.org', 'Jazari Representative', 'Jazari', 'exhibitor', 'Cluster 14', 'P5-B22', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.yummilicious115@expo2026.org (Yummilicious Pizza)
DO $$
DECLARE
    new_user_id UUID := '1d3e1976-25ab-4ab6-bef0-34885fc9f39a';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.yummilicious115@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.yummilicious115@expo2026.org',
            crypt('Expo2026!115', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Yummilicious Pizza Representative","role":"exhibitor","org":"Yummilicious Pizza"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.yummilicious115@expo2026.org', 'Yummilicious Pizza Representative', 'Yummilicious Pizza', 'exhibitor', 'Cluster 15', 'P5-B23', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.beverlyresta116@expo2026.org (Beverly Restaurant)
DO $$
DECLARE
    new_user_id UUID := '7912f4fb-1f62-4415-87ff-abe49ed9fe47';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.beverlyresta116@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.beverlyresta116@expo2026.org',
            crypt('Expo2026!116', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Beverly Restaurant Representative","role":"exhibitor","org":"Beverly Restaurant"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.beverlyresta116@expo2026.org', 'Beverly Restaurant Representative', 'Beverly Restaurant', 'exhibitor', 'Cluster 16', 'P5-B24', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.kiddiescorne117@expo2026.org (Kiddies Corner)
DO $$
DECLARE
    new_user_id UUID := '356001d1-d77d-433b-ab19-7cdcfbbc3c44';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.kiddiescorne117@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.kiddiescorne117@expo2026.org',
            crypt('Expo2026!117', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Kiddies Corner Representative","role":"exhibitor","org":"Kiddies Corner"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.kiddiescorne117@expo2026.org', 'Kiddies Corner Representative', 'Kiddies Corner', 'exhibitor', 'Cluster 17', 'P5-B25', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.omniahealth118@expo2026.org (Omnia Health)
DO $$
DECLARE
    new_user_id UUID := '0ae88fc1-4aa8-4e2e-9c48-c53fff75e1f1';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.omniahealth118@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.omniahealth118@expo2026.org',
            crypt('Expo2026!118', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Omnia Health Representative","role":"exhibitor","org":"Omnia Health"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.omniahealth118@expo2026.org', 'Omnia Health Representative', 'Omnia Health', 'exhibitor', 'Cluster 18', 'P5-B26', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.omniaeyeclin119@expo2026.org (Omnia Eye Clinic)
DO $$
DECLARE
    new_user_id UUID := '0e308144-ef24-4756-b67a-5874187dd9d0';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.omniaeyeclin119@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.omniaeyeclin119@expo2026.org',
            crypt('Expo2026!119', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Omnia Eye Clinic Representative","role":"exhibitor","org":"Omnia Eye Clinic"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.omniaeyeclin119@expo2026.org', 'Omnia Eye Clinic Representative', 'Omnia Eye Clinic', 'exhibitor', 'Cluster 19', 'P5-B27', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.cappellihair120@expo2026.org (Cappelli Hair Salon)
DO $$
DECLARE
    new_user_id UUID := '4f79aaa8-1d41-4cc3-8cec-598b217b2ca0';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.cappellihair120@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.cappellihair120@expo2026.org',
            crypt('Expo2026!120', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Cappelli Hair Salon Representative","role":"exhibitor","org":"Cappelli Hair Salon"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.cappellihair120@expo2026.org', 'Cappelli Hair Salon Representative', 'Cappelli Hair Salon', 'exhibitor', 'Cluster 20', 'P5-B28', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.allnatural121@expo2026.org (All Natural)
DO $$
DECLARE
    new_user_id UUID := '8d49f65c-0df1-429f-bdf8-c00b6c4ee8fd';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.allnatural121@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.allnatural121@expo2026.org',
            crypt('Expo2026!121', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"All Natural Representative","role":"exhibitor","org":"All Natural"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.allnatural121@expo2026.org', 'All Natural Representative', 'All Natural', 'exhibitor', 'Cluster 1', 'P5-B29', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.completestud122@expo2026.org (Complete Studio)
DO $$
DECLARE
    new_user_id UUID := 'dedc1a4d-dd99-4f7d-b2f1-d6544e0a2df9';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.completestud122@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.completestud122@expo2026.org',
            crypt('Expo2026!122', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Complete Studio Representative","role":"exhibitor","org":"Complete Studio"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.completestud122@expo2026.org', 'Complete Studio Representative', 'Complete Studio', 'exhibitor', 'Cluster 2', 'P5-B30', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.thewashspot123@expo2026.org (The Wash Spot)
DO $$
DECLARE
    new_user_id UUID := '53dfd33a-ae84-4ad9-8dca-14e973f4dc08';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.thewashspot123@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.thewashspot123@expo2026.org',
            crypt('Expo2026!123', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"The Wash Spot Representative","role":"exhibitor","org":"The Wash Spot"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.thewashspot123@expo2026.org', 'The Wash Spot Representative', 'The Wash Spot', 'exhibitor', 'Cluster 3', 'P5-B31', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.eventcentre124@expo2026.org (Event Centre)
DO $$
DECLARE
    new_user_id UUID := 'a9c53115-096f-4636-b93a-1e06c8e3fcc3';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.eventcentre124@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.eventcentre124@expo2026.org',
            crypt('Expo2026!124', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Event Centre Representative","role":"exhibitor","org":"Event Centre"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.eventcentre124@expo2026.org', 'Event Centre Representative', 'Event Centre', 'exhibitor', 'Cluster 4', 'P5-B32', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.azerscinema125@expo2026.org (Azers Cinema)
DO $$
DECLARE
    new_user_id UUID := '57535903-c695-4ad8-be1d-9653a0f98c32';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.azerscinema125@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.azerscinema125@expo2026.org',
            crypt('Expo2026!125', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Azers Cinema Representative","role":"exhibitor","org":"Azers Cinema"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.azerscinema125@expo2026.org', 'Azers Cinema Representative', 'Azers Cinema', 'exhibitor', 'Cluster 5', 'P5-B33', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.miniso126@expo2026.org (Miniso)
DO $$
DECLARE
    new_user_id UUID := '24bdecfb-e012-42bd-8f78-28b0fc48ef51';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.miniso126@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.miniso126@expo2026.org',
            crypt('Expo2026!126', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Miniso Representative","role":"exhibitor","org":"Miniso"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.miniso126@expo2026.org', 'Miniso Representative', 'Miniso', 'exhibitor', 'Cluster 6', 'P5-B34', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.sharerssuite127@expo2026.org (Sharer''s Suite of Shops)
DO $$
DECLARE
    new_user_id UUID := '9e3c34a1-6b80-43bb-898c-a3d67d8c8e2a';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.sharerssuite127@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.sharerssuite127@expo2026.org',
            crypt('Expo2026!127', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Sharer''s Suite of Shops Representative","role":"exhibitor","org":"Sharer''s Suite of Shops"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.sharerssuite127@expo2026.org', 'Sharer''s Suite of Shops Representative', 'Sharer''s Suite of Shops', 'exhibitor', 'Cluster 7', 'P5-B35', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.spectrummicr128@expo2026.org (Spectrum Microfinance Bank (Marketplace))
DO $$
DECLARE
    new_user_id UUID := '7b80c6ae-035d-439b-911f-e95ec32ac759';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.spectrummicr128@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.spectrummicr128@expo2026.org',
            crypt('Expo2026!128', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Spectrum Microfinance Bank (Marketplace) Representative","role":"exhibitor","org":"Spectrum Microfinance Bank (Marketplace)"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.spectrummicr128@expo2026.org', 'Spectrum Microfinance Bank (Marketplace) Representative', 'Spectrum Microfinance Bank (Marketplace)', 'exhibitor', 'Cluster 8', 'P5-B36', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.theplayarena129@expo2026.org (The Play Arena)
DO $$
DECLARE
    new_user_id UUID := '595b377f-24b8-4866-85d6-810a96d9b411';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.theplayarena129@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.theplayarena129@expo2026.org',
            crypt('Expo2026!129', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"The Play Arena Representative","role":"exhibitor","org":"The Play Arena"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.theplayarena129@expo2026.org', 'The Play Arena Representative', 'The Play Arena', 'exhibitor', 'Cluster 9', 'P5-B37', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.omniatechwor130@expo2026.org (Omnia Tech World)
DO $$
DECLARE
    new_user_id UUID := 'ee814c3a-8bb4-4393-9c4f-1d7b88a113b4';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.omniatechwor130@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.omniatechwor130@expo2026.org',
            crypt('Expo2026!130', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Omnia Tech World Representative","role":"exhibitor","org":"Omnia Tech World"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.omniatechwor130@expo2026.org', 'Omnia Tech World Representative', 'Omnia Tech World', 'exhibitor', 'Cluster 10', 'P5-B38', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.cwebistro131@expo2026.org (CWE Bistro)
DO $$
DECLARE
    new_user_id UUID := 'bd07e358-4a56-463f-be73-d1097beb550e';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.cwebistro131@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.cwebistro131@expo2026.org',
            crypt('Expo2026!131', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"CWE Bistro Representative","role":"exhibitor","org":"CWE Bistro"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.cwebistro131@expo2026.org', 'CWE Bistro Representative', 'CWE Bistro', 'exhibitor', 'Cluster 11', 'P5-B39', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.cwesupermark132@expo2026.org (CWE Supermarket)
DO $$
DECLARE
    new_user_id UUID := '1e9cd1f9-3f0e-4a96-a7c0-1faff75f4fe5';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.cwesupermark132@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.cwesupermark132@expo2026.org',
            crypt('Expo2026!132', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"CWE Supermarket Representative","role":"exhibitor","org":"CWE Supermarket"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.cwesupermark132@expo2026.org', 'CWE Supermarket Representative', 'CWE Supermarket', 'exhibitor', 'Cluster 12', 'P5-B40', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;

-- User: exhibitor.tummyscafe133@expo2026.org (Tummy''s Cafe)
DO $$
DECLARE
    new_user_id UUID := 'a75583a1-ca99-4fa1-b5f8-03e7845de6eb';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'exhibitor.tummyscafe133@expo2026.org') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', 'exhibitor.tummyscafe133@expo2026.org',
            crypt('Expo2026!133', gen_salt('bf')), now(),
            '{"provider":"email","providers":["email"]}'::jsonb,
            '{"full_name":"Tummy''s Cafe Representative","role":"exhibitor","org":"Tummy''s Cafe"}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, 'exhibitor.tummyscafe133@expo2026.org', 'Tummy''s Cafe Representative', 'Tummy''s Cafe', 'exhibitor', 'Cluster 13', 'P5-B41', NULL, NULL
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;
