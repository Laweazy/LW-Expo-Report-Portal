-- ==============================================================================
-- EXPO REPORTING SYSTEM - DATABASE SCHEMA (SUPABASE / POSTGRESQL)
-- ==============================================================================

-- 1. Create Profile Roles Enum
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('admin', 'exhibitor', 'cluster');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- 2. User Profiles Table (Linked to Supabase Auth)
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL UNIQUE,
    full_name TEXT NOT NULL,
    organization_name TEXT NOT NULL,
    role user_role NOT NULL DEFAULT 'exhibitor',
    pavilion TEXT,           -- e.g. "Pavilion 1 - Tech City"
    cluster_name TEXT,       -- e.g. "Cluster 3" or NULL if exhibitor/admin
    booth_number TEXT,       -- e.g. "P1-B04" or NULL if cluster/admin
    subchairman_name TEXT,   -- For clusters
    secretary_name TEXT,     -- For clusters
    phone_number TEXT,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- 3. Exhibitor Products Catalog (Pre-populated by exhibitors for 1-click selection)
CREATE TABLE IF NOT EXISTS public.exhibitor_products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    product_name TEXT NOT NULL,
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.exhibitor_products ENABLE ROW LEVEL SECURITY;

-- 4. Exhibitor Daily Reports Table
CREATE TABLE IF NOT EXISTS public.exhibitor_daily_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    exhibition_day TEXT NOT NULL,                          -- e.g., "Day 1", "Day 2", etc.
    report_date DATE NOT NULL DEFAULT CURRENT_DATE,
    
    -- Attendance & Footfall
    staff_count INTEGER NOT NULL DEFAULT 0,
    visitors_count INTEGER NOT NULL DEFAULT 0,
    dignitaries_received TEXT,                             -- Govt Representatives, Corporate Organizations etc.
    
    -- Products & Engagements (Selected from pre-populated catalog)
    products_exhibited TEXT[] NOT NULL DEFAULT '{}'::TEXT[],-- Selected product names
    most_engaged_product TEXT NOT NULL,                    -- Selected from dropdown
    engagements_count INTEGER NOT NULL DEFAULT 0,
    conversions_count INTEGER NOT NULL DEFAULT 0,
    conversion_rate NUMERIC(5,2) GENERATED ALWAYS AS (
        CASE 
            WHEN engagements_count > 0 THEN ROUND((conversions_count::numeric / engagements_count::numeric) * 100, 2)
            ELSE 0.00
        END
    ) STORED,
    
    -- Business Development & Feedback
    significant_deals TEXT,                                -- Significant Deals / Partnerships secured
    new_requests TEXT,                                     -- New requests received
    key_observations TEXT,
    challenges_recommendations TEXT,
    improvements_next_day TEXT,
    
    -- Media Attachments
    pictures TEXT[] DEFAULT '{}'::TEXT[],                  -- Array of public URLs
    video_highlight_url TEXT,                              -- Short video URL or uploaded storage path
    
    -- Admin Review & Feedback
    admin_feedback TEXT,
    feedback_provided_by UUID REFERENCES public.profiles(id),
    feedback_at TIMESTAMPTZ,
    status TEXT NOT NULL DEFAULT 'submitted' CHECK (status IN ('submitted', 'reviewed', 'needs_revision')),
    
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL,

    -- Ensure one report per exhibitor per exhibition day
    UNIQUE (user_id, exhibition_day)
);

ALTER TABLE public.exhibitor_daily_reports ENABLE ROW LEVEL SECURITY;

-- 5. Cluster Daily Reports Table (Extracted from KingsForms + Media Attachments)
CREATE TABLE IF NOT EXISTS public.cluster_daily_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    cluster_name TEXT NOT NULL,
    subchairman_name TEXT NOT NULL,
    secretary_name TEXT NOT NULL,
    exhibition_day TEXT NOT NULL,                          -- "Day 1" through "Day 7"
    report_date DATE NOT NULL DEFAULT CURRENT_DATE,
    
    -- Core Cluster Daily Assessment
    activity_summary TEXT NOT NULL,                        -- Summary of activities for the day
    significant_achievements TEXT NOT NULL,                -- Significant Achievements
    challenges_solutions TEXT NOT NULL,                    -- Challenges & Solutions proffered
    improvements_next_day TEXT NOT NULL,                   -- Improvements for next day
    comments TEXT,                                         -- Comments, if any
    
    -- Media Attachments
    pictures TEXT[] DEFAULT '{}'::TEXT[],                  -- Array of public URLs
    video_highlight_url TEXT,                              -- Short video URL or uploaded storage path
    
    -- Admin Review & Feedback
    admin_feedback TEXT,
    feedback_provided_by UUID REFERENCES public.profiles(id),
    feedback_at TIMESTAMPTZ,
    status TEXT NOT NULL DEFAULT 'submitted' CHECK (status IN ('submitted', 'reviewed', 'needs_revision')),
    
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL,

    -- Ensure one report per cluster per exhibition day
    UNIQUE (user_id, exhibition_day)
);

ALTER TABLE public.cluster_daily_reports ENABLE ROW LEVEL SECURITY;

-- 6. Cluster Final / Overall Reports Table (End-of-Period with Word/PDF Docs)
CREATE TABLE IF NOT EXISTS public.cluster_final_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    cluster_name TEXT NOT NULL,
    executive_summary TEXT,
    overall_achievements TEXT,
    total_leads_generated INTEGER DEFAULT 0,
    total_deals_closed INTEGER DEFAULT 0,
    overall_challenges TEXT,
    final_recommendations TEXT,
    
    -- Document Attachments (Word / PDF)
    document_urls TEXT[] DEFAULT '{}'::TEXT[],             -- Links to uploaded .doc, .docx, .pdf files
    
    -- Admin Review & Feedback
    admin_feedback TEXT,
    feedback_provided_by UUID REFERENCES public.profiles(id),
    feedback_at TIMESTAMPTZ,
    status TEXT NOT NULL DEFAULT 'submitted' CHECK (status IN ('submitted', 'reviewed', 'needs_revision')),
    
    submitted_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL,

    UNIQUE (user_id)
);

ALTER TABLE public.cluster_final_reports ENABLE ROW LEVEL SECURITY;

-- ==============================================================================
-- 7. ROW-LEVEL SECURITY (RLS) POLICIES
-- ==============================================================================

-- PROFILES
CREATE POLICY "Users can view their own profile"
    ON public.profiles FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "Admins can view all profiles"
    ON public.profiles FOR SELECT
    USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admins can manage profiles"
    ON public.profiles FOR ALL
    USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'));

-- EXHIBITOR PRODUCTS CATALOG
CREATE POLICY "Exhibitors can view their own products"
    ON public.exhibitor_products FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Exhibitors can manage their own products"
    ON public.exhibitor_products FOR ALL
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can view all exhibitor products"
    ON public.exhibitor_products FOR SELECT
    USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'));

-- EXHIBITOR DAILY REPORTS
CREATE POLICY "Exhibitors can view their own reports"
    ON public.exhibitor_daily_reports FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Exhibitors can submit their own reports"
    ON public.exhibitor_daily_reports FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Exhibitors can edit their own report if not yet reviewed"
    ON public.exhibitor_daily_reports FOR UPDATE
    USING (auth.uid() = user_id AND status != 'reviewed')
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can view all exhibitor reports"
    ON public.exhibitor_daily_reports FOR SELECT
    USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admins can update exhibitor reports (feedback and status)"
    ON public.exhibitor_daily_reports FOR UPDATE
    USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'));

-- CLUSTER DAILY REPORTS
CREATE POLICY "Clusters can view their own reports"
    ON public.cluster_daily_reports FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Clusters can submit their own reports"
    ON public.cluster_daily_reports FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Clusters can edit their own report if not yet reviewed"
    ON public.cluster_daily_reports FOR UPDATE
    USING (auth.uid() = user_id AND status != 'reviewed')
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can view all cluster daily reports"
    ON public.cluster_daily_reports FOR SELECT
    USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admins can update cluster daily reports (feedback and status)"
    ON public.cluster_daily_reports FOR UPDATE
    USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'));

-- CLUSTER FINAL REPORTS
CREATE POLICY "Clusters can view their own final report"
    ON public.cluster_final_reports FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Clusters can submit their own final report"
    ON public.cluster_final_reports FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Clusters can edit their own final report if not yet reviewed"
    ON public.cluster_final_reports FOR UPDATE
    USING (auth.uid() = user_id AND status != 'reviewed')
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can view all cluster final reports"
    ON public.cluster_final_reports FOR SELECT
    USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'));

CREATE POLICY "Admins can update cluster final reports"
    ON public.cluster_final_reports FOR UPDATE
    USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'));

-- 8. PERFORMANCE INDEXES
CREATE INDEX IF NOT EXISTS idx_exhibitor_reports_day ON public.exhibitor_daily_reports(exhibition_day);
CREATE INDEX IF NOT EXISTS idx_exhibitor_reports_user ON public.exhibitor_daily_reports(user_id);
CREATE INDEX IF NOT EXISTS idx_cluster_reports_day ON public.cluster_daily_reports(exhibition_day);
CREATE INDEX IF NOT EXISTS idx_cluster_reports_user ON public.cluster_daily_reports(user_id);
CREATE INDEX IF NOT EXISTS idx_exhibitor_products_user ON public.exhibitor_products(user_id);
