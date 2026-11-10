"""
Real-world Account Seeder for LOVEWORLD EXPO 2026
Extracted from Pavilion Directory Boards:
- Pavilion 1: Tech City (13 exhibitors)
- Pavilion 2: Ministry, Corporate & Finance (32 exhibitors)
- Pavilion 3: Angel Court (31 exhibitors)
- Pavilion 4: Healing Dome (17 exhibitors)
- Pavilion 5: Marketplace (41 exhibitors)
Total: 134 Exhibitors, 20 Clusters, 2 Admins
"""

import os
import csv
import uuid
import re

output_dir = os.path.join(os.path.dirname(__file__), '..', 'supabase')
os.makedirs(output_dir, exist_ok=True)

# 1. ADMINS
admins = [
    {
        'id': str(uuid.uuid4()),
        'email': 'admin@expo2026.org',
        'name': 'Lead Expo Admin',
        'role': 'admin',
        'org': 'LoveWorld Expo Secretariat',
        'pavilion': 'Main Secretariat',
        'booth': 'HQ-01',
        'password': 'AdminExpo2026!Pass'
    },
    {
        'id': str(uuid.uuid4()),
        'email': 'supervisor@expo2026.org',
        'name': 'Reports Supervisor',
        'role': 'admin',
        'org': 'LoveWorld Expo Secretariat',
        'pavilion': 'Main Secretariat',
        'booth': 'HQ-02',
        'password': 'AdminExpo2026!Pass'
    }
]

# 2. CLUSTERS (20 Clusters)
clusters = []
for i in range(1, 21):
    clusters.append({
        'id': str(uuid.uuid4()),
        'email': f'cluster{i}@expo2026.org',
        'name': f'Cluster {i} Leadership',
        'role': 'cluster',
        'org': f'Cluster {i}',
        'pavilion': f'Cluster {i}',
        'subchairman': f'Subchairman Cluster {i}',
        'secretary': f'Secretary Cluster {i}',
        'booth': f'CL-{i:02d}',
        'password': f'Cluster2026!#{i:02d}'
    })

# 3. REAL EXHIBITORS BY PAVILION
pavilions_data = {
    "Pavilion 1 - Tech City": [
        "360 Suite", "CeFlix Sceptre", "Cloudax", "Eden Hub (Praxiom)", "Espees",
        "KingsSuite", "NeoTech", "Omnia Technologies", "One World", "PCDL",
        "Qubators", "Tsion Cars", "Worldstreet & Co"
    ],
    "Pavilion 2 - Ministry & Corporate": [
        "Beverly Meals", "BLW Campus Ministry", "British Canadian University",
        "Bureau de Change", "Children Ministry", "Chris Oyakhilome Foundation International (COFI)",
        "Church Ministry", "Espees Corps", "Haven Nation", "Herald App",
        "Inner City Missions for Children", "Kiddies Media Production/Lovetoons Comic",
        "LMAM Unending Praise", "Loveworld Film and Art Department", "Loveworld Ladies Network",
        "Loveworld Ministry of Commerce", "Loveworld Networks", "Loveworld Schools",
        "Loveworld Sports & Youth Ministry", "Media Blast Network", "Ministry of Discipleship",
        "Ministry of Food Technology & Sovereignty", "Ministry of Human Resource Transformation",
        "Ministry Programs", "New Media Ministry", "Nuclear Medicine",
        "Office of the President & CELF", "Parallex Bank", "Refuge Mortgage Bank",
        "SOM (Sons of Ministry)", "Spectrum Micro Finance Bank"
    ],
    "Pavilion 3 - Angel Court": [
        "Angel Marketplace", "Crownelle", "Manifeston Journal & Movies",
        "Meridian Translations", "Reach Out Campaigns", "REON",
        "Rhapsody Digital Products", "Rhapsody Distribution Network", "Rhapsody Influencers Network",
        "Rhapsody International Missions", "Rhapsody Kiddies Dailies with Pastor Chris",
        "Rhapsody Technologies", "Rhapsody TV", "RORK", "Smile Campaign", "Tap2Read",
        "Visionwear", "Youths Aglow", "THE GREAT COMPANY", "RHAPSODY BIBLES", "WONDER TV",
        "WONDERKIDS TV", "A HERO GOES TO SCHOOL", "SEE THROUGH A HERO",
        "THE POWER OF YOUR MIND", "HEROES AT CHRISTMAS", "LOVEWORLD CHILDREN'S PUBLISHING",
        "LOVEWORLD TEENS PUBLISHING", "LW PUBLICATIONS - THE FULL BOOK RANGE",
        "BIBLES IN MULTIPLE LANGUAGES AND FORMATS", "LIFESTYLE AND PERSONAL CARE PRODUCTS"
    ],
    "Pavilion 4 - Healing Dome": [
        "Advanced School of Technology", "Chris Oyakhilome Foundation International (COFI - Health)",
        "Directorate of Health Services", "Directorate of Social Services",
        "Future Africa Leaders Foundation (FALF)", "Global Youth Leaders Forum (GYLF)",
        "Healing School", "International School of Ministry (ISM)", "Leaders School of Ministry (LSM)",
        "Licht Marketing", "Loveworld Medical Center", "Loveworld Medical Foundation (LMF)",
        "Marpe Wellness", "Ministry of Humanitarian Affairs", "Neo Tech Hub",
        "Nuclear Medicine Museum", "Pastoral Deaconry Nominees Training Program (PDNTP)"
    ],
    "Pavilion 5 - Marketplace": [
        "Kelsey Greene Group of Companies", "Nazer Company Limited",
        "Prime Foods and Beverages Nigeria Limited", "Forever Loveworld", "MadeInHeaven",
        "Eden Glow", "House of Seraph", "OCA Services", "Elenchos Consulting Limited",
        "Cedar and Cradle Limited", "Shares Service Limited", "Norah Mining Limited",
        "Licht Group", "Auxano", "Pointek", "Parallex Bank (Marketplace)", "Fashion Redemption",
        "Home World Supermarket", "Dolly Nation Kayla's Castle", "Celebrity Style",
        "Fashion Redemption Print", "Jazari", "Yummilicious Pizza", "Beverly Restaurant",
        "Kiddies Corner", "Omnia Health", "Omnia Eye Clinic", "Cappelli Hair Salon",
        "All Natural", "Complete Studio", "The Wash Spot", "Event Centre", "Azers Cinema",
        "Miniso", "Sharer's Suite of Shops", "Spectrum Microfinance Bank (Marketplace)",
        "The Play Arena", "Omnia Tech World", "CWE Bistro", "CWE Supermarket", "Tummy's Cafe"
    ]
}

def slugify(text):
    clean = re.sub(r'[^a-zA-Z0-9]', '', text.lower())
    return clean[:12] if clean else 'rep'

exhibitors = []
global_idx = 1
for pav_name, org_list in pavilions_data.items():
    pav_code = pav_name.split()[1] # e.g. "1", "2"
    for i, org in enumerate(org_list, 1):
        slug = slugify(org)
        email = f"exhibitor.{slug}{global_idx}@expo2026.org"
        booth = f"P{pav_code}-B{i:02d}"
        assigned_cluster = f"Cluster {((global_idx - 1) % 20) + 1}"
        
        exhibitors.append({
            'id': str(uuid.uuid4()),
            'email': email,
            'name': f"{org} Representative",
            'role': 'exhibitor',
            'org': org,
            'pavilion': pav_name,
            'cluster_name': assigned_cluster,
            'booth': booth,
            'subchairman': '',
            'secretary': '',
            'password': f"Expo2026!{global_idx:03d}"
        })
        global_idx += 1

all_users = admins + clusters + exhibitors

# 1. Write CSV distribution sheet
csv_path = os.path.join(output_dir, 'credentials_distribution.csv')
with open(csv_path, 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['Role', 'Pavilion / Location', 'Organization / Brand', 'Assigned Cluster', 'Booth Number', 'Contact Name', 'Login Email', 'Temporary Password'])
    for u in all_users:
        contact = u.get('subchairman', '')
        if u.get('secretary'):
            contact += f" / {u['secretary']}" if contact else u['secretary']
        if not contact:
            contact = u['name']
        writer.writerow([
            u['role'],
            u.get('pavilion', ''),
            u['org'],
            u.get('cluster_name', ''),
            u.get('booth', ''),
            contact,
            u['email'],
            u['password']
        ])

print(f"Generated CSV with {len(all_users)} authentic accounts at: {csv_path}")

# 2. Write Supabase SQL batch seeder
sql_path = os.path.join(output_dir, 'seed_users.sql')
with open(sql_path, 'w', encoding='utf-8') as f:
    f.write("-- ==============================================================================\n")
    f.write(f"-- BATCH SEED ACCOUNTS FOR LOVEWORLD EXPO 2026 ({len(all_users)} REAL ACCOUNTS)\n")
    f.write("-- 2 Admins, 20 Clusters, 134 Authentic Exhibitors Across Pavilions 1 to 5\n")
    f.write("-- Paste directly into Supabase SQL Editor\n")
    f.write("-- ==============================================================================\n\n")
    f.write("CREATE EXTENSION IF NOT EXISTS pgcrypto;\n\n")

    for u in all_users:
        user_id = u['id']
        email = u['email']
        raw_pw = u['password']
        name = u['name'].replace("'", "''")
        org = u['org'].replace("'", "''")
        role = u['role']
        cluster = f"'{u.get('cluster_name', '')}'" if u.get('cluster_name') else 'NULL'
        booth = f"'{u.get('booth', '')}'" if u.get('booth') else 'NULL'
        subchairman = f"'{u.get('subchairman', '')}'" if u.get('subchairman') else 'NULL'
        secretary = f"'{u.get('secretary', '')}'" if u.get('secretary') else 'NULL'

        f.write(f"""
-- User: {email} ({org})
DO $$
DECLARE
    new_user_id UUID := '{user_id}';
BEGIN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = '{email}') THEN
        INSERT INTO auth.users (
            id, instance_id, email, encrypted_password, email_confirmed_at,
            raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
        ) VALUES (
            new_user_id, '00000000-0000-0000-0000-000000000000', '{email}',
            crypt('{raw_pw}', gen_salt('bf')), now(),
            '{{"provider":"email","providers":["email"]}}'::jsonb,
            '{{"full_name":"{name}","role":"{role}","org":"{org}"}}'::jsonb,
            now(), now(), 'authenticated', 'authenticated'
        );

        INSERT INTO public.profiles (
            id, email, full_name, organization_name, role, cluster_name, booth_number, subchairman_name, secretary_name
        ) VALUES (
            new_user_id, '{email}', '{name}', '{org}', '{role}', {cluster}, {booth}, {subchairman}, {secretary}
        ) ON CONFLICT (id) DO NOTHING;
    END IF;
END $$;
""")

print(f"Generated SQL seed file at: {sql_path}")
