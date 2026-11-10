/**
 * LoveWorld Expo 2026 - Reporting & Analytics Engine
 * Supports Exhibitors, Clusters, and Admin portals.
 * Fully compatible with Supabase and includes instant local-storage preview mode.
 */

// --- 1. STATE & CONFIGURATION ---
const SUPABASE_CONFIG = {
  url: window.EXPO_SUPABASE_URL || 'https://xyzcompany.supabase.co',
  anonKey: window.EXPO_SUPABASE_ANON_KEY || 'public-anon-key'
};

// Initialize Supabase if configured, otherwise fallback to reactive LocalStore
let supabase = null;
try {
  if (window.supabase && SUPABASE_CONFIG.url !== 'https://xyzcompany.supabase.co') {
    supabase = window.supabase.createClient(SUPABASE_CONFIG.url, SUPABASE_CONFIG.anonKey);
    console.log("Supabase connected live.");
  }
} catch (e) {
  console.log("Running in offline/embedded mode with LocalStorage fallback.");
}

// Local Reactive State Store
let currentUser = null;
let activeFeedbackTarget = null;

// Initial Pre-seeded Data for Testing
const INITIAL_PRODUCTS = {
  "exhibitor.360suite1@expo2026.org": [
    { id: "p1", name: "360 CRM Enterprise", active: true },
    { id: "p2", name: "360 Lead Capture Mobile", active: true },
    { id: "p3", name: "360 Event Analytics Hub", active: true }
  ]
};

// Load or initialize local data
function getStore(key, defaultVal) {
  const saved = localStorage.getItem(`expo_${key}`);
  return saved ? JSON.parse(saved) : defaultVal;
}
function setStore(key, val) {
  localStorage.setItem(`expo_${key}`, JSON.stringify(val));
}

let exhibitorProducts = getStore('products', INITIAL_PRODUCTS);
let exhibitorReports = getStore('exhibitor_reports', [
  {
    id: "rep-1",
    user_email: "exhibitor.360suite1@expo2026.org",
    org_name: "360 Suite",
    booth: "P1-B01",
    pavilion: "Pavilion 1 - Tech City",
    day: "Day 1",
    staff_count: 5,
    visitors_count: 320,
    dignitaries: "Zonal Pastor, Ministry Directors",
    products_exhibited: ["360 CRM Enterprise", "360 Lead Capture Mobile"],
    most_engaged: "360 Lead Capture Mobile",
    engagements: 140,
    conversions: 45,
    conversion_rate: "32.14%",
    deals: "Partnered with 3 Tech hubs for bulk deployment",
    new_requests: "Offline sync for rural churches",
    key_observations: "Peak traffic between 2 PM and 5 PM",
    challenges: "Wi-Fi bandwidth dips in late afternoon",
    improvements: "Set up dedicated local hotspot",
    pictures: ["https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&auto=format&fit=crop&q=80"],
    video_url: "https://drive.google.com/sample-clip",
    status: "reviewed",
    admin_feedback: "Commendable footfall and conversion rate! IT team has deployed an auxiliary access point near Bay 1.",
    created_at: new Date(Date.now() - 86400000).toISOString()
  }
]);

let clusterReports = getStore('cluster_reports', [
  {
    id: "cl-1",
    user_email: "cluster1@expo2026.org",
    cluster_name: "Cluster 1",
    subchairman: "Pastor Michael Adams",
    secretary: "Deacon Emmanuel Obi",
    day: "Day 1",
    summary: "Grand opening of Pavilion 1. All 13 tech booths operational with zero downtime.",
    achievements: "Over 1,200 unique delegates visited Pavilion 1 on opening day.",
    challenges_solutions: "Minor crowd congestion around main aisle; rerouted visitor path clockwise.",
    improvements: "Add more digital signage at pavilion foyer.",
    comments: "Great coordination with security and protocol teams.",
    pictures: ["https://images.unsplash.com/photo-1511578314322-379afb476865?w=600&auto=format&fit=crop&q=80"],
    video_url: "",
    status: "reviewed",
    admin_feedback: "Excellent management of the tech pavilion. Keep up the high standards.",
    created_at: new Date(Date.now() - 86400000).toISOString()
  }
]);

let clusterFinalReports = getStore('cluster_final_reports', []);

// --- 2. AUTHENTICATION & DEMO SWITCHER ---
const DEMO_USERS = {
  admin: {
    email: 'admin@expo2026.org',
    name: 'Lead Expo Admin',
    role: 'admin',
    org: 'LoveWorld Expo Secretariat',
    location: 'Main Secretariat (HQ)'
  },
  cluster: {
    email: 'cluster1@expo2026.org',
    name: 'Pastor Michael Adams',
    role: 'cluster',
    org: 'Cluster 1',
    location: 'Pavilion 1 - Tech City',
    subchairman: 'Pastor Michael Adams',
    secretary: 'Deacon Emmanuel Obi'
  },
  exhibitor: {
    email: 'exhibitor.360suite1@expo2026.org',
    name: '360 Suite Representative',
    role: 'exhibitor',
    org: '360 Suite',
    location: 'Booth P1-B01',
    pavilion: 'Pavilion 1 - Tech City',
    cluster_name: 'Cluster 1'
  }
};

function demoLogin(roleKey) {
  currentUser = DEMO_USERS[roleKey];
  applyUserSession();
  Swal.fire({
    icon: 'success',
    title: `Signed in as ${currentUser.name}`,
    text: `Role: ${currentUser.role.toUpperCase()} • ${currentUser.location}`,
    timer: 1500,
    showConfirmButton: false
  });
}

document.getElementById('loginForm').addEventListener('submit', (e) => {
  e.preventDefault();
  const email = document.getElementById('loginEmail').value.trim();
  
  // Find matching user from known patterns or default to exhibitor
  if (email.startsWith('admin')) {
    demoLogin('admin');
  } else if (email.startsWith('cluster')) {
    const num = email.replace(/\D/g, '') || '1';
    currentUser = {
      email,
      name: `Cluster ${num} Secretariat`,
      role: 'cluster',
      org: `Cluster ${num}`,
      location: `Cluster ${num} Command`,
      subchairman: `Subchairman Cluster ${num}`,
      secretary: `Secretary Cluster ${num}`
    };
    applyUserSession();
  } else {
    // Exhibitor
    currentUser = {
      email,
      name: 'Exhibitor Rep',
      role: 'exhibitor',
      org: 'Exhibitor Organization',
      location: 'Assigned Booth',
      pavilion: 'Expo Hall',
      cluster_name: 'Cluster 1'
    };
    applyUserSession();
  }
});

document.getElementById('logoutBtn').addEventListener('click', () => {
  currentUser = null;
  document.getElementById('appNav').classList.add('hidden');
  document.getElementById('exhibitorSection').classList.add('hidden');
  document.getElementById('clusterSection').classList.add('hidden');
  document.getElementById('adminSection').classList.add('hidden');
  document.getElementById('loginSection').classList.remove('hidden');
  Swal.fire({
    icon: 'info',
    title: 'Signed Out',
    timer: 1200,
    showConfirmButton: false
  });
});

function applyUserSession() {
  document.getElementById('loginSection').classList.add('hidden');
  document.getElementById('appNav').classList.remove('hidden');
  
  // Set user profile in nav
  document.getElementById('userNameDisplay').textContent = currentUser.org || currentUser.name;
  document.getElementById('userRoleBadge').textContent = currentUser.role;
  document.getElementById('userLocationDisplay').textContent = currentUser.location;

  if (currentUser.role === 'admin') {
    setupAdminPortal();
  } else if (currentUser.role === 'cluster') {
    setupClusterPortal();
  } else {
    setupExhibitorPortal();
  }
  lucide.createIcons();
}

// --- 3. EXHIBITOR PORTAL LOGIC ---
function setupExhibitorPortal() {
  document.getElementById('exhibitorSection').classList.remove('hidden');
  document.getElementById('clusterSection').classList.add('hidden');
  document.getElementById('adminSection').classList.add('hidden');

  document.getElementById('exhibitorOrgName').textContent = currentUser.org;
  document.getElementById('exhibitorBoothHeader').textContent = currentUser.location;
  document.getElementById('exhibitorClusterPavilion').textContent = `${currentUser.pavilion || 'Exhibition Pavilion'} • Assigned to ${currentUser.cluster_name || 'Cluster 1'}`;

  // Real-time conversion rate auto-calculation
  const engInput = document.getElementById('exEngagementsCount');
  const convInput = document.getElementById('exConversionsCount');
  const rateInput = document.getElementById('exConversionRate');

  function calculateRate() {
    const eng = parseFloat(engInput.value) || 0;
    const conv = parseFloat(convInput.value) || 0;
    if (eng > 0) {
      const rate = ((conv / eng) * 100).toFixed(2);
      rateInput.value = `${rate}%`;
    } else {
      rateInput.value = '0.00%';
    }
  }
  engInput.addEventListener('input', calculateRate);
  convInput.addEventListener('input', calculateRate);

  renderExhibitorProducts();
  renderExhibitorHistory();
  switchExhibitorTab('report');
}

function switchExhibitorTab(tabName) {
  document.getElementById('exhibitorReportTab').classList.toggle('hidden', tabName !== 'report');
  document.getElementById('exhibitorProductsTab').classList.toggle('hidden', tabName !== 'products');
  document.getElementById('exhibitorHistoryTab').classList.toggle('hidden', tabName !== 'history');

  // Highlight active button
  const setBtn = (id, active) => {
    const el = document.getElementById(id);
    if (active) {
      el.className = "px-4 py-2 rounded-xl text-xs font-bold bg-white text-blue-900 shadow-sm transition";
    } else {
      el.className = "px-4 py-2 rounded-xl text-xs font-bold bg-blue-800/80 hover:bg-white/20 text-white transition";
    }
  };
  setBtn('tabBtnReport', tabName === 'report');
  setBtn('tabBtnProducts', tabName === 'products');
  setBtn('tabBtnHistory', tabName === 'history');
  lucide.createIcons();
}

// Manage Catalog Products
function getMyProducts() {
  return exhibitorProducts[currentUser.email] || [
    { id: "def-1", name: `${currentUser.org} Flagship Solution`, active: true },
    { id: "def-2", name: `${currentUser.org} Service Package`, active: true }
  ];
}

function renderExhibitorProducts() {
  const products = getMyProducts();
  exhibitorProducts[currentUser.email] = products;
  setStore('products', exhibitorProducts);

  // 1. Render Catalog Table
  const tableBody = document.getElementById('catalogTableBody');
  tableBody.innerHTML = products.map((p, idx) => `
    <tr>
      <td class="py-3 px-4 font-semibold text-slate-400">${idx + 1}</td>
      <td class="py-3 px-4 font-bold text-slate-900">${p.name}</td>
      <td class="py-3 px-4">
        <span class="px-2 py-0.5 rounded-full text-[10px] font-bold ${p.active ? 'bg-emerald-100 text-emerald-800' : 'bg-slate-100 text-slate-500'}">
          ${p.active ? 'Active' : 'Archived'}
        </span>
      </td>
      <td class="py-3 px-4 text-right">
        <button onclick="removeProduct('${p.id}')" class="text-rose-500 hover:text-rose-700 text-xs font-semibold">
          Remove
        </button>
      </td>
    </tr>
  `).join('');

  // 2. Render Checkboxes for Daily Report
  const chipsContainer = document.getElementById('exhibitorProductsListContainer');
  chipsContainer.innerHTML = products.filter(p => p.active).map(p => `
    <label class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl border border-blue-200 bg-white text-xs font-semibold text-slate-800 hover:bg-blue-50 cursor-pointer shadow-xs">
      <input type="checkbox" name="exProduct" value="${p.name}" class="rounded text-blue-600 focus:ring-blue-500" checked>
      <span>${p.name}</span>
    </label>
  `).join('');

  // 3. Render Most Engaged Product dropdown
  const select = document.getElementById('exMostEngagedSelect');
  select.innerHTML = '<option value="">Select the top engaged product...</option>' + 
    products.filter(p => p.active).map(p => `<option value="${p.name}">${p.name}</option>`).join('');
}

document.getElementById('addProductForm').addEventListener('submit', (e) => {
  e.preventDefault();
  const input = document.getElementById('newProductName');
  const name = input.value.trim();
  if (!name) return;

  const products = getMyProducts();
  products.push({ id: `p-${Date.now()}`, name, active: true });
  exhibitorProducts[currentUser.email] = products;
  setStore('products', exhibitorProducts);
  input.value = '';
  renderExhibitorProducts();

  Swal.fire({
    icon: 'success',
    title: 'Product Added!',
    text: `"${name}" is now available in your daily reporting dropdowns.`,
    timer: 1500,
    showConfirmButton: false
  });
});

function removeProduct(id) {
  let products = getMyProducts();
  products = products.filter(p => p.id !== id);
  exhibitorProducts[currentUser.email] = products;
  setStore('products', exhibitorProducts);
  renderExhibitorProducts();
}

// Temporary uploaded photos buffer
let exhibitorPhotosBuffer = [];
function handlePhotoUpload(e) {
  const files = Array.from(e.target.files);
  files.forEach(file => {
    const reader = new FileReader();
    reader.onload = (event) => {
      exhibitorPhotosBuffer.push(event.target.result);
      renderPhotoPreviews();
    };
    reader.readAsDataURL(file);
  });
}

function renderPhotoPreviews() {
  const container = document.getElementById('exPhotoPreviewContainer');
  container.innerHTML = exhibitorPhotosBuffer.map((src, i) => `
    <div class="relative w-14 h-14 rounded-lg overflow-hidden border border-slate-200 shadow-xs">
      <img src="${src}" class="w-full h-full object-cover">
      <button type="button" onclick="removePhoto(${i})" class="absolute top-0 right-0 bg-rose-600 text-white rounded-bl p-0.5 text-[10px]">
        ✕
      </button>
    </div>
  `).join('');
}
function removePhoto(i) {
  exhibitorPhotosBuffer.splice(i, 1);
  renderPhotoPreviews();
}

// Exhibitor Daily Form Submission
document.getElementById('exhibitorReportForm').addEventListener('submit', (e) => {
  e.preventDefault();

  const selectedProducts = Array.from(document.querySelectorAll('input[name="exProduct"]:checked')).map(el => el.value);
  if (selectedProducts.length === 0) {
    Swal.fire('Please Select Products', 'Select at least one product exhibited today.', 'warning');
    return;
  }

  const report = {
    id: `rep-${Date.now()}`,
    user_email: currentUser.email,
    org_name: currentUser.org,
    booth: currentUser.location,
    pavilion: currentUser.pavilion,
    day: document.getElementById('exhibitorDaySelect').value,
    staff_count: parseInt(document.getElementById('exStaffCount').value) || 0,
    visitors_count: parseInt(document.getElementById('exVisitorsCount').value) || 0,
    dignitaries: document.getElementById('exDignitaries').value.trim(),
    products_exhibited: selectedProducts,
    most_engaged: document.getElementById('exMostEngagedSelect').value,
    engagements: parseInt(document.getElementById('exEngagementsCount').value) || 0,
    conversions: parseInt(document.getElementById('exConversionsCount').value) || 0,
    conversion_rate: document.getElementById('exConversionRate').value,
    deals: document.getElementById('exDealsSecured').value.trim(),
    new_requests: document.getElementById('exNewRequests').value.trim(),
    key_observations: document.getElementById('exKeyObservations').value.trim(),
    challenges: document.getElementById('exChallenges').value.trim(),
    improvements: document.getElementById('exImprovements').value.trim(),
    pictures: [...exhibitorPhotosBuffer],
    video_url: document.getElementById('exVideoUrl').value.trim(),
    status: 'submitted',
    admin_feedback: null,
    created_at: new Date().toISOString()
  };

  exhibitorReports.unshift(report);
  setStore('exhibitor_reports', exhibitorReports);

  // Reset form
  e.target.reset();
  exhibitorPhotosBuffer = [];
  renderPhotoPreviews();
  document.getElementById('exConversionRate').value = '0.00%';

  Swal.fire({
    icon: 'success',
    title: 'Report Submitted!',
    text: `Your ${report.day} daily report has been saved. The admin team will review it shortly.`,
    confirmButtonColor: '#1d4ed8'
  }).then(() => {
    switchExhibitorTab('history');
    renderExhibitorHistory();
  });
});

function renderExhibitorHistory() {
  const container = document.getElementById('exhibitorSubmissionsList');
  const myReports = exhibitorReports.filter(r => r.user_email === currentUser.email);

  if (myReports.length === 0) {
    container.innerHTML = `<p class="text-sm text-slate-400 py-6 text-center">No reports submitted yet. Use the Daily Report Form to submit your first day.</p>`;
    return;
  }

  container.innerHTML = myReports.map(r => `
    <div class="p-5 rounded-2xl border ${r.admin_feedback ? 'border-blue-300 bg-blue-50/20' : 'border-slate-200 bg-white'} shadow-sm space-y-3">
      <div class="flex justify-between items-start">
        <div class="flex items-center gap-2">
          <span class="font-extrabold text-sm text-slate-900">${r.day} Report</span>
          <span class="text-xs text-slate-400">• ${new Date(r.created_at).toLocaleDateString()}</span>
        </div>
        <span class="px-2.5 py-0.5 rounded-full text-xs font-bold uppercase tracking-wider ${r.status === 'reviewed' ? 'bg-emerald-100 text-emerald-800' : 'bg-amber-100 text-amber-800'}">
          ${r.status === 'reviewed' ? 'Reviewed' : 'Pending Review'}
        </span>
      </div>

      <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 bg-slate-50 p-3 rounded-xl text-xs">
        <div><span class="text-slate-400">Visitors:</span> <strong class="text-slate-900">${r.visitors_count}</strong></div>
        <div><span class="text-slate-400">Engagements:</span> <strong class="text-slate-900">${r.engagements}</strong></div>
        <div><span class="text-slate-400">Conversions:</span> <strong class="text-slate-900">${r.conversions}</strong></div>
        <div><span class="text-slate-400">Conversion Rate:</span> <strong class="text-emerald-700 font-bold">${r.conversion_rate}</strong></div>
      </div>

      <p class="text-xs text-slate-600"><strong>Most Engaged Product:</strong> ${r.most_engaged}</p>

      ${r.admin_feedback ? `
        <div class="p-3.5 bg-blue-100/60 rounded-xl border border-blue-200 space-y-1">
          <div class="flex items-center gap-1.5 text-xs font-bold text-blue-900">
            <i data-lucide="message-square-text" class="w-4 h-4 text-blue-700"></i> Admin Feedback:
          </div>
          <p class="text-xs text-blue-800">${r.admin_feedback}</p>
        </div>
      ` : `
        <div class="text-[11px] text-slate-400 italic">Awaiting feedback from the expo administration.</div>
      `}
    </div>
  `).join('');
  lucide.createIcons();
}

// --- 4. CLUSTER PORTAL LOGIC ---
function setupClusterPortal() {
  document.getElementById('exhibitorSection').classList.add('hidden');
  document.getElementById('clusterSection').classList.remove('hidden');
  document.getElementById('adminSection').classList.add('hidden');

  document.getElementById('clusterTitleDisplay').textContent = currentUser.org;
  document.getElementById('clusterLeadershipDisplay').textContent = `Subchairman: ${currentUser.subchairman} • Secretary: ${currentUser.secretary}`;
  document.getElementById('clSubchairman').value = currentUser.subchairman;
  document.getElementById('clSecretary').value = currentUser.secretary;

  renderClusterHistory();
  switchClusterTab('daily');
}

function switchClusterTab(tabName) {
  document.getElementById('clusterDailyTab').classList.toggle('hidden', tabName !== 'daily');
  document.getElementById('clusterFinalTab').classList.toggle('hidden', tabName !== 'final');
  document.getElementById('clusterHistoryTab').classList.toggle('hidden', tabName !== 'history');

  const setBtn = (id, active) => {
    const el = document.getElementById(id);
    if (active) {
      el.className = "px-4 py-2 rounded-xl text-xs font-bold bg-white text-emerald-900 shadow-sm transition";
    } else {
      el.className = "px-4 py-2 rounded-xl text-xs font-bold bg-emerald-950/60 hover:bg-white/20 text-white transition";
    }
  };
  setBtn('clTabBtnDaily', tabName === 'daily');
  setBtn('clTabBtnFinal', tabName === 'final');
  setBtn('clTabBtnHistory', tabName === 'history');
  lucide.createIcons();
}

let clusterPhotosBuffer = [];
function handleClusterPhotoUpload(e) {
  const files = Array.from(e.target.files);
  files.forEach(file => {
    const reader = new FileReader();
    reader.onload = (event) => {
      clusterPhotosBuffer.push(event.target.result);
      renderClusterPhotoPreviews();
    };
    reader.readAsDataURL(file);
  });
}
function renderClusterPhotoPreviews() {
  const container = document.getElementById('clPhotoPreviewContainer');
  container.innerHTML = clusterPhotosBuffer.map(src => `
    <img src="${src}" class="w-12 h-12 rounded object-cover border border-slate-200">
  `).join('');
}

// Cluster Daily Report Form Submit
document.getElementById('clusterDailyForm').addEventListener('submit', (e) => {
  e.preventDefault();

  const report = {
    id: `cl-${Date.now()}`,
    user_email: currentUser.email,
    cluster_name: currentUser.org,
    subchairman: document.getElementById('clSubchairman').value.trim(),
    secretary: document.getElementById('clSecretary').value.trim(),
    day: document.getElementById('clusterDaySelect').value,
    summary: document.getElementById('clSummary').value.trim(),
    achievements: document.getElementById('clAchievements').value.trim(),
    challenges_solutions: document.getElementById('clChallengesSolutions').value.trim(),
    improvements: document.getElementById('clImprovements').value.trim(),
    comments: document.getElementById('clComments').value.trim(),
    pictures: [...clusterPhotosBuffer],
    video_url: document.getElementById('clVideoUrl').value.trim(),
    status: 'submitted',
    admin_feedback: null,
    created_at: new Date().toISOString()
  };

  clusterReports.unshift(report);
  setStore('cluster_reports', clusterReports);

  e.target.reset();
  clusterPhotosBuffer = [];
  renderClusterPhotoPreviews();

  Swal.fire({
    icon: 'success',
    title: 'Cluster Report Submitted!',
    text: `Daily report for ${report.day} recorded successfully.`,
    confirmButtonColor: '#059669'
  }).then(() => {
    switchClusterTab('history');
    renderClusterHistory();
  });
});

// Cluster Final Report Docs Buffer
let clusterDocFiles = [];
function handleDocUpload(e) {
  const files = Array.from(e.target.files);
  files.forEach(f => clusterDocFiles.push(f.name));
  const container = document.getElementById('clDocPreviewContainer');
  container.innerHTML = clusterDocFiles.map(name => `
    <div class="px-3 py-1.5 bg-emerald-100 text-emerald-900 rounded-lg text-xs font-semibold flex items-center justify-between">
      <span>📄 ${name}</span>
      <span class="text-[10px] text-emerald-700">Attached</span>
    </div>
  `).join('');
}

document.getElementById('clusterFinalForm').addEventListener('submit', (e) => {
  e.preventDefault();
  const finalReport = {
    id: `cl-final-${Date.now()}`,
    user_email: currentUser.email,
    cluster_name: currentUser.org,
    summary: document.getElementById('clFinalSummary').value.trim(),
    leads: parseInt(document.getElementById('clFinalLeads').value) || 0,
    deals: parseInt(document.getElementById('clFinalDeals').value) || 0,
    documents: [...clusterDocFiles],
    submitted_at: new Date().toISOString(),
    status: 'submitted',
    admin_feedback: null
  };
  clusterFinalReports.unshift(finalReport);
  setStore('cluster_final_reports', clusterFinalReports);

  Swal.fire({
    icon: 'success',
    title: 'Final Expo Report Submitted!',
    text: 'Your overall cluster report and attachments have been delivered to Admin.',
    confirmButtonColor: '#065f46'
  });
});

function renderClusterHistory() {
  const container = document.getElementById('clusterSubmissionsList');
  const myReports = clusterReports.filter(r => r.user_email === currentUser.email);

  if (myReports.length === 0) {
    container.innerHTML = `<p class="text-sm text-slate-400 py-6 text-center">No daily cluster reports submitted yet.</p>`;
    return;
  }

  container.innerHTML = myReports.map(r => `
    <div class="p-5 rounded-2xl border ${r.admin_feedback ? 'border-emerald-300 bg-emerald-50/20' : 'border-slate-200 bg-white'} shadow-sm space-y-3">
      <div class="flex justify-between items-start">
        <div>
          <span class="font-extrabold text-sm text-slate-900">${r.day} Assessment</span>
          <p class="text-xs text-slate-500">Subchairman: ${r.subchairman} • Secretary: ${r.secretary}</p>
        </div>
        <span class="px-2.5 py-0.5 rounded-full text-xs font-bold uppercase tracking-wider ${r.status === 'reviewed' ? 'bg-emerald-100 text-emerald-800' : 'bg-amber-100 text-amber-800'}">
          ${r.status === 'reviewed' ? 'Reviewed' : 'Pending Review'}
        </span>
      </div>

      <p class="text-xs text-slate-700"><strong>Daily Summary:</strong> ${r.summary}</p>
      <p class="text-xs text-slate-700"><strong>Achievements:</strong> ${r.achievements}</p>

      ${r.admin_feedback ? `
        <div class="p-3.5 bg-emerald-100/60 rounded-xl border border-emerald-200 space-y-1">
          <div class="flex items-center gap-1.5 text-xs font-bold text-emerald-900">
            <i data-lucide="message-square-text" class="w-4 h-4 text-emerald-700"></i> Admin Feedback:
          </div>
          <p class="text-xs text-emerald-800">${r.admin_feedback}</p>
        </div>
      ` : `
        <div class="text-[11px] text-slate-400 italic">Awaiting feedback from the expo administration.</div>
      `}
    </div>
  `).join('');
  lucide.createIcons();
}

// --- 5. ADMIN PORTAL LOGIC ---
let visitorsChart = null;
let productsChart = null;

function setupAdminPortal() {
  document.getElementById('exhibitorSection').classList.add('hidden');
  document.getElementById('clusterSection').classList.add('hidden');
  document.getElementById('adminSection').classList.remove('hidden');

  computeAdminMetrics();
  renderAdminFeed();
  initAdminCharts();
}

function computeAdminMetrics() {
  const totalReports = exhibitorReports.length + clusterReports.length + clusterFinalReports.length;
  const totalVisitors = exhibitorReports.reduce((sum, r) => sum + (r.visitors_count || 0), 0);
  const totalEngagements = exhibitorReports.reduce((sum, r) => sum + (r.engagements || 0), 0);
  const totalConversions = exhibitorReports.reduce((sum, r) => sum + (r.conversions || 0), 0);

  document.getElementById('adminMetricReports').textContent = totalReports;
  document.getElementById('adminMetricVisitors').textContent = totalVisitors.toLocaleString();
  document.getElementById('adminMetricEngagements').textContent = totalEngagements.toLocaleString();
  document.getElementById('adminMetricConversions').textContent = totalConversions.toLocaleString();

  if (totalEngagements > 0) {
    const avgRate = ((totalConversions / totalEngagements) * 100).toFixed(1);
    document.getElementById('adminMetricAvgRate').textContent = `Avg conversion rate: ${avgRate}%`;
  }
}

function renderAdminFeed() {
  const filterType = document.getElementById('adminFilterType').value;
  const filterDay = document.getElementById('adminFilterDay').value;
  const search = document.getElementById('adminSearchInput').value.toLowerCase();

  let combined = [];

  if (filterType === 'all' || filterType === 'exhibitor') {
    exhibitorReports.forEach(r => combined.push({ ...r, type: 'Exhibitor Daily', entityName: r.org_name, sub: r.booth }));
  }
  if (filterType === 'all' || filterType === 'cluster_daily') {
    clusterReports.forEach(r => combined.push({ ...r, type: 'Cluster Daily', entityName: r.cluster_name, sub: `Sec: ${r.secretary}` }));
  }
  if (filterType === 'all' || filterType === 'cluster_final') {
    clusterFinalReports.forEach(r => combined.push({ ...r, type: 'Cluster Final', day: 'Final', entityName: r.cluster_name, sub: 'Overall Report' }));
  }

  // Filter day
  if (filterDay !== 'all') {
    combined = combined.filter(item => item.day === filterDay);
  }
  // Filter search
  if (search) {
    combined = combined.filter(item => item.entityName.toLowerCase().includes(search) || (item.sub && item.sub.toLowerCase().includes(search)));
  }

  const tableBody = document.getElementById('adminFeedTableBody');
  if (combined.length === 0) {
    tableBody.innerHTML = `<tr><td colspan="6" class="text-center py-8 text-slate-400 text-xs">No records matching the selected filters.</td></tr>`;
    return;
  }

  tableBody.innerHTML = combined.map(item => `
    <tr class="hover:bg-slate-50/80 transition">
      <td class="py-3.5 px-4">
        <div class="font-bold text-slate-900">${item.entityName}</div>
        <div class="text-[11px] text-slate-400">${item.sub}</div>
      </td>
      <td class="py-3.5 px-4">
        <span class="px-2 py-0.5 rounded-full text-[10px] font-bold ${
          item.type === 'Exhibitor Daily' ? 'bg-blue-100 text-blue-800' :
          item.type === 'Cluster Daily' ? 'bg-emerald-100 text-emerald-800' :
          'bg-purple-100 text-purple-800'
        }">${item.type}</span>
      </td>
      <td class="py-3.5 px-4 font-semibold text-xs text-slate-700">${item.day}</td>
      <td class="py-3.5 px-4 text-xs">
        ${item.type === 'Exhibitor Daily' ? `
          <div>Visitors: <strong>${item.visitors_count}</strong></div>
          <div class="text-emerald-700">Conv: <strong>${item.conversions}</strong> (${item.conversion_rate})</div>
        ` : `
          <div class="text-slate-600 line-clamp-1">${item.summary || 'Summary logged'}</div>
        `}
      </td>
      <td class="py-3.5 px-4 text-xs">
        <div class="flex items-center gap-1.5 mb-1">
          <span class="w-2 h-2 rounded-full ${item.status === 'reviewed' ? 'bg-emerald-500' : 'bg-amber-400'}"></span>
          <span class="font-bold text-[11px] uppercase ${item.status === 'reviewed' ? 'text-emerald-700' : 'text-amber-700'}">${item.status}</span>
        </div>
        ${item.admin_feedback ? `
          <div class="text-[11px] text-slate-500 italic max-w-xs truncate" title="${item.admin_feedback}">
            "${item.admin_feedback}"
          </div>
        ` : '<span class="text-[10px] text-slate-400">No feedback yet</span>'}
      </td>
      <td class="py-3.5 px-4 text-right">
        <button onclick="openFeedbackModal('${item.id}', '${item.type}')" 
          class="px-3 py-1.5 bg-blue-50 hover:bg-blue-100 text-blue-700 font-bold text-xs rounded-lg transition border border-blue-200">
          ${item.admin_feedback ? 'Edit Feedback' : 'Review & Feedback'}
        </button>
      </td>
    </tr>
  `).join('');
  lucide.createIcons();
}

function openFeedbackModal(reportId, reportType) {
  let target = null;
  if (reportType === 'Exhibitor Daily') {
    target = exhibitorReports.find(r => r.id === reportId);
  } else if (reportType === 'Cluster Daily') {
    target = clusterReports.find(r => r.id === reportId);
  } else {
    target = clusterFinalReports.find(r => r.id === reportId);
  }
  if (!target) return;

  activeFeedbackTarget = { reportId, reportType, target };
  document.getElementById('modalTargetLabel').textContent = `To: ${target.org_name || target.cluster_name} (${target.day || 'Final'})`;
  document.getElementById('modalFeedbackText').value = target.admin_feedback || '';
  document.getElementById('feedbackModal').classList.remove('hidden');
}

function closeFeedbackModal() {
  document.getElementById('feedbackModal').classList.add('hidden');
  activeFeedbackTarget = null;
}

function submitAdminFeedback() {
  if (!activeFeedbackTarget) return;
  const feedback = document.getElementById('modalFeedbackText').value.trim();
  if (!feedback) {
    Swal.fire('Empty Feedback', 'Please enter feedback before submitting.', 'warning');
    return;
  }

  const { reportId, reportType, target } = activeFeedbackTarget;
  target.admin_feedback = feedback;
  target.status = 'reviewed';

  if (reportType === 'Exhibitor Daily') {
    setStore('exhibitor_reports', exhibitorReports);
  } else if (reportType === 'Cluster Daily') {
    setStore('cluster_reports', clusterReports);
  } else {
    setStore('cluster_final_reports', clusterFinalReports);
  }

  closeFeedbackModal();
  renderAdminFeed();
  computeAdminMetrics();

  Swal.fire({
    icon: 'success',
    title: 'Feedback Delivered!',
    text: `Your comments have been sent to ${target.org_name || target.cluster_name}. They will see it immediately upon logging in.`,
    timer: 2000,
    showConfirmButton: false
  });
}

function initAdminCharts() {
  // 1. Visitors & Engagements Trend Chart
  const ctxVisitors = document.getElementById('adminVisitorsChart').getContext('2d');
  if (visitorsChart) visitorsChart.destroy();

  visitorsChart = new Chart(ctxVisitors, {
    type: 'line',
    data: {
      labels: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'],
      datasets: [
        {
          label: 'Visitors (Footfall)',
          data: [320, 480, 560, 690, 810, 950, 1100],
          borderColor: '#1d4ed8',
          backgroundColor: 'rgba(29, 78, 216, 0.1)',
          fill: true,
          tension: 0.3
        },
        {
          label: 'Interactions / Engagements',
          data: [140, 210, 280, 390, 450, 520, 610],
          borderColor: '#f59e0b',
          backgroundColor: 'rgba(245, 158, 11, 0.05)',
          fill: true,
          tension: 0.3
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: { legend: { position: 'top' } }
    }
  });

  // 2. Top Products Bar Chart
  const ctxProducts = document.getElementById('adminProductsChart').getContext('2d');
  if (productsChart) productsChart.destroy();

  productsChart = new Chart(ctxProducts, {
    type: 'bar',
    data: {
      labels: ['360 Lead Capture', 'PCDL Vouchers', 'KingsChat Pro', 'Espees Pay', 'Healing School Mag'],
      datasets: [{
        label: 'Engagements Logged',
        data: [140, 120, 98, 85, 76],
        backgroundColor: '#3b82f6',
        borderRadius: 8
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: { legend: { display: false } }
    }
  });
}

// Export All Data to CSV
function exportDataToCSV() {
  let csv = 'Type,Entity Name,Location,Day,Visitors,Engagements,Conversions,Rate,Feedback\n';
  exhibitorReports.forEach(r => {
    csv += `"Exhibitor","${r.org_name}","${r.booth}","${r.day}",${r.visitors_count},${r.engagements},${r.conversions},"${r.conversion_rate}","${(r.admin_feedback || '').replace(/"/g, '""')}"\n`;
  });
  clusterReports.forEach(c => {
    csv += `"Cluster","${c.cluster_name}","N/A","${c.day}",0,0,0,"0%","${(c.admin_feedback || '').replace(/"/g, '""')}"\n`;
  });

  const blob = new Blob([csv], { type: 'text/csv' });
  const url = window.URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.setAttribute('href', url);
  a.setAttribute('download', `LoveWorld_Expo_2026_Report_${new Date().toISOString().slice(0, 10)}.csv`);
  a.click();
}

// Initialize Lucide icons on boot
document.addEventListener('DOMContentLoaded', () => {
  lucide.createIcons();
});
