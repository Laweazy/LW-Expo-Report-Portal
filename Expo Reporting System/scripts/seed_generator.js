/**
 * Account Seeder & Credential Generator for Expo Reporting System
 * 
 * Generates ~100 Exhibitor accounts, ~20 Cluster accounts, and 2 Admin accounts.
 * Outputs:
 *  1. `supabase_users_seed.sql` (direct SQL statements for Supabase SQL Editor)
 *  2. `credentials_distribution.csv` (for expo admin to print or email to participants)
 */

const fs = require('fs');
const path = require('path');

const EXHIBITOR_COUNT = 100;
const CLUSTER_COUNT = 20;

const exhibitors = [];
const clusters = [];
const admins = [
  { email: 'admin@expo2026.org', name: 'Lead Expo Admin', role: 'admin', org: 'Expo Secretariat' },
  { email: 'supervisor@expo2026.org', name: 'Reports Supervisor', role: 'admin', org: 'Expo Secretariat' }
];

// Generate Clusters (Cluster 1 to 20)
for (let i = 1; i <= CLUSTER_COUNT; i++) {
  clusters.push({
    email: `cluster${i}@expo2026.org`,
    name: `Cluster ${i} Lead`,
    org: `Cluster ${i}`,
    role: 'cluster',
    cluster_name: `Cluster ${i}`,
    subchairman: `Subchairman Cluster ${i}`,
    secretary: `Secretary Cluster ${i}`,
    temp_password: `Cluster2026!#${i}`
  });
}

// Generate Exhibitors (Exhibitor 1 to 100 across clusters)
for (let i = 1; i <= EXHIBITOR_COUNT; i++) {
  const assignedCluster = ((i - 1) % CLUSTER_COUNT) + 1;
  const boothCode = `B-${String.fromCharCode(65 + (i % 6))}${10 + (i % 40)}`;
  exhibitors.push({
    email: `exhibitor${i}@expo2026.org`,
    name: `Exhibitor Rep ${i}`,
    org: `Company / Brand ${i}`,
    role: 'exhibitor',
    cluster_name: `Cluster ${assignedCluster}`,
    booth_number: boothCode,
    temp_password: `ExpoExhibitor2026!${i}`
  });
}

// Write CSV for distribution
let csvContent = 'Role,Organization / Brand,Cluster,Booth,Contact Name,Login Email,Temporary Password\n';

admins.forEach(a => {
  csvContent += `${a.role},"${a.org}",N/A,N/A,"${a.name}",${a.email},AdminExpoPass2026!\n`;
});

clusters.forEach(c => {
  csvContent += `cluster,"${c.org}","${c.cluster_name}",N/A,"${c.subchairman} / ${c.secretary}",${c.email},${c.temp_password}\n`;
});

exhibitors.forEach(e => {
  csvContent += `exhibitor,"${e.org}","${e.cluster_name}","${e.booth_number}","${e.name}",${e.email},${e.temp_password}\n`;
});

const outputDir = path.join(__dirname, '..', 'supabase');
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

fs.writeFileSync(path.join(outputDir, 'credentials_distribution.csv'), csvContent);
console.log(`Successfully generated credentials_distribution.csv with ${admins.length + clusters.length + exhibitors.length} accounts.`);
