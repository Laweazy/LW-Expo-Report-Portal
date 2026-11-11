'use client';

import React, { useState, useEffect } from 'react';
import { createClient } from '@supabase/supabase-js';
import { 
  Shield, Lock, Mail, ArrowRight, LogOut, Plus, FileText, 
  BarChart3, MessageSquare, Send, Award, Download, Package, Trash2
} from 'lucide-react';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '';
const supabase = createClient(supabaseUrl, supabaseAnonKey);

export default function LoveworldExpoPortal() {
  const [session, setSession] = useState(null);
  const [profile, setProfile] = useState(null);
  const [loading, setLoading] = useState(true);

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [authError, setAuthError] = useState('');

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session);
      if (session) fetchUserProfile(session.user.id);
      else setLoading(false);
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setSession(session);
      if (session) fetchUserProfile(session.user.id);
      else {
        setProfile(null);
        setLoading(false);
      }
    });

    return () => subscription.unsubscribe();
  }, []);

  const fetchUserProfile = async (userId) => {
    try {
      const { data } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();
      if (data) setProfile(data);
    } catch (err) {
      console.error('Profile fetch error:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    setAuthError('');
    try {
      const { data, error } = await supabase.auth.signInWithPassword({ email, password });
      if (error) throw error;
      await fetchUserProfile(data.user.id);
    } catch (err) {
      setAuthError(err.message || 'Invalid credentials');
      setLoading(false);
    }
  };

  const handleLogout = async () => {
    await supabase.auth.signOut();
    setSession(null);
    setProfile(null);
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-slate-900 text-white flex items-center justify-center font-sans">
        <div className="text-center space-y-3">
          <div className="w-10 h-10 border-4 border-indigo-500 border-t-transparent rounded-full animate-spin mx-auto"></div>
          <p className="text-slate-400 text-sm">Loading Loveworld Expo Portal...</p>
        </div>
      </div>
    );
  }

  if (!session || !profile) {
    return (
      <div className="min-h-screen bg-slate-900 flex items-center justify-center p-4 font-sans">
        <div className="max-w-md w-full bg-slate-800 border border-slate-700 rounded-2xl p-8 shadow-2xl space-y-6">
          <div className="text-center space-y-2">
            <div className="inline-flex p-3 bg-indigo-600/20 text-indigo-400 rounded-2xl mb-1">
              <Shield className="w-8 h-8" />
            </div>
            <h1 className="text-2xl font-bold text-white tracking-wide">Loveworld Expo Portal</h1>
            <p className="text-slate-400 text-sm">Reporting & Analytics Management System</p>
          </div>

          {authError && (
            <div className="p-3 bg-red-500/10 border border-red-500/30 text-red-400 rounded-xl text-xs text-center">
              {authError}
            </div>
          )}

          <form onSubmit={handleLogin} className="space-y-4">
            <div>
              <label className="block text-xs font-semibold text-slate-300 uppercase mb-2">Email Address</label>
              <div className="relative">
                <Mail className="absolute left-3 top-3.5 text-slate-500 w-5 h-5" />
                <input
                  type="email"
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="cluster1@loveworldexpo.org"
                  className="w-full pl-10 pr-4 py-3 bg-slate-900 border border-slate-700 rounded-xl text-white text-sm focus:outline-none focus:border-indigo-500"
                />
              </div>
            </div>

            <div>
              <label className="block text-xs font-semibold text-slate-300 uppercase mb-2">Password</label>
              <div className="relative">
                <Lock className="absolute left-3 top-3.5 text-slate-500 w-5 h-5" />
                <input
                  type="password"
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  className="w-full pl-10 pr-4 py-3 bg-slate-900 border border-slate-700 rounded-xl text-white text-sm focus:outline-none focus:border-indigo-500"
                />
              </div>
            </div>

            <button
              type="submit"
              className="w-full py-3.5 bg-indigo-600 hover:bg-indigo-500 text-white font-semibold rounded-xl text-sm flex items-center justify-center space-x-2 transition shadow-lg shadow-indigo-600/20"
            >
              <span>Sign In to Dashboard</span>
              <ArrowRight className="w-4 h-4" />
            </button>
          </form>

          <div className="text-center pt-2">
            <p className="text-xs text-slate-500">Loveworld Expo • Secure Multi-Role Portal</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col font-sans">
      <header className="bg-slate-900 text-white px-6 py-4 flex justify-between items-center shadow-md">
        <div className="flex items-center space-x-3">
          <div className="p-2 bg-indigo-600 rounded-xl text-white">
            <Shield className="w-5 h-5" />
          </div>
          <div>
            <h1 className="font-bold text-base leading-none">{profile.entity_name || 'Loveworld Portal'}</h1>
            <span className="text-xs text-indigo-400 capitalize font-medium">{profile.role} Account</span>
          </div>
        </div>
        <button
          onClick={handleLogout}
          className="text-xs font-semibold text-red-400 hover:text-red-300 bg-slate-800 hover:bg-slate-700 px-3 py-2 rounded-xl flex items-center space-x-1.5 transition"
        >
          <LogOut className="w-3.5 h-3.5" />
          <span>Sign Out</span>
        </button>
      </header>

      {profile.role === 'exhibitor' && <ExhibitorView user={session.user} profile={profile} />}
      {profile.role === 'cluster' && <ClusterView user={session.user} profile={profile} />}
      {profile.role === 'admin' && <AdminView user={session.user} profile={profile} />}
    </div>
  );
}

// ----------------------------------------------------------------------------
// EXHIBITOR VIEW (WITH PRODUCT CATALOG & DROPDOWN SELECTION)
// ----------------------------------------------------------------------------
function ExhibitorView({ user, profile }) {
  const [activeTab, setActiveTab] = useState('new');
  const [reports, setReports] = useState([]);
  const [products, setProducts] = useState([]);
  const [saving, setSaving] = useState(false);

  // Product Catalog Form
  const [newProdName, setNewProdName] = useState('');
  const [newProdCat, setNewProdCat] = useState('');

  // Daily Report Form
  const [exhibitionDay, setExhibitionDay] = useState('Day 1');
  const [staffCount, setStaffCount] = useState(0);
  const [visitorsCount, setVisitorsCount] = useState(0);
  const [engagementsCount, setEngagementsCount] = useState(0);
  const [conversionsCount, setConversionsCount] = useState(0);
  const [selectedProducts, setSelectedProducts] = useState([]);
  const [mostEngagedProduct, setMostEngagedProduct] = useState('');
  const [dignitaries, setDignitaries] = useState('');
  const [deals, setDeals] = useState('');
  const [observations, setObservations] = useState('');

  useEffect(() => {
    fetchExhibitorData();
  }, []);

  const fetchExhibitorData = async () => {
    const { data: rData } = await supabase
      .from('exhibitor_daily_reports')
      .select('*')
      .eq('user_id', user.id)
      .order('created_at', { ascending: false });

    const { data: pData } = await supabase
      .from('exhibitor_products')
      .select('*')
      .eq('user_id', user.id)
      .order('created_at', { ascending: true });

    if (rData) setReports(rData);
    if (pData) setProducts(pData);
  };

  const handleAddProduct = async (e) => {
    e.preventDefault();
    if (!newProdName.trim()) return;

    await supabase.from('exhibitor_products').insert([{
      user_id: user.id,
      product_name: newProdName,
      category: newProdCat
    }]);

    setNewProdName('');
    setNewProdCat('');
    fetchExhibitorData();
  };

  const handleDeleteProduct = async (id) => {
    await supabase.from('exhibitor_products').delete().eq('id', id);
    fetchExhibitorData();
  };

  const toggleProductCheck = (name) => {
    if (selectedProducts.includes(name)) {
      setSelectedProducts(selectedProducts.filter(p => p !== name));
    } else {
      setSelectedProducts([...selectedProducts, name]);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSaving(true);
    const convRate = visitorsCount > 0 ? ((conversionsCount / visitorsCount) * 100).toFixed(2) : 0;

    await supabase.from('exhibitor_daily_reports').insert([{
      user_id: user.id,
      exhibitor_name: profile.entity_name,
      pavilion: 'Pavilion Stand',
      exhibition_day: exhibitionDay,
      number_of_staff_on_stand: parseInt(staffCount),
      number_of_visitors_recorded: parseInt(visitorsCount),
      total_number_of_engagements: parseInt(engagementsCount),
      total_number_of_conversions: parseInt(conversionsCount),
      conversion_rate: parseFloat(convRate),
      list_of_products_exhibited: selectedProducts.join(', '),
      most_engaged_product_for_the_day: mostEngagedProduct,
      list_of_dignitaries_received: dignitaries,
      significant_deals_partnerships_secured: deals,
      key_observations: observations
    }]);

    setSaving(false);
    fetchExhibitorData();
    setActiveTab('entries');
  };

  const totalVisitors = reports.reduce((acc, r) => acc + (r.number_of_visitors_recorded || 0), 0);
  const totalConversions = reports.reduce((acc, r) => acc + (r.total_number_of_conversions || 0), 0);

  return (
    <div className="flex-1 flex flex-col">
      <div className="bg-white border-b border-slate-200 px-6 flex space-x-6 text-sm font-semibold">
        <button onClick={() => setActiveTab('new')} className={`py-4 border-b-2 flex items-center space-x-2 ${activeTab === 'new' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <Plus className="w-4 h-4" /> <span>New Daily Report</span>
        </button>
        <button onClick={() => setActiveTab('catalog')} className={`py-4 border-b-2 flex items-center space-x-2 ${activeTab === 'catalog' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <Package className="w-4 h-4" /> <span>Product Catalog ({products.length})</span>
        </button>
        <button onClick={() => setActiveTab('entries')} className={`py-4 border-b-2 flex items-center space-x-2 ${activeTab === 'entries' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <FileText className="w-4 h-4" /> <span>My Entries ({reports.length})</span>
        </button>
        <button onClick={() => setActiveTab('analytics')} className={`py-4 border-b-2 flex items-center space-x-2 ${activeTab === 'analytics' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <BarChart3 className="w-4 h-4" /> <span>Analytics</span>
        </button>
        <button onClick={() => setActiveTab('feedback')} className={`py-4 border-b-2 flex items-center space-x-2 ${activeTab === 'feedback' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <MessageSquare className="w-4 h-4" /> <span>Admin Feedback</span>
        </button>
      </div>

      <main className="flex-1 max-w-4xl w-full mx-auto p-6">
        {/* CATALOG TAB */}
        {activeTab === 'catalog' && (
          <div className="space-y-6">
            <form onSubmit={handleAddProduct} className="bg-white border rounded-2xl p-6 shadow-sm flex items-end space-x-4">
              <div className="flex-1">
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Product / Title Name</label>
                <input type="text" required placeholder="e.g. Rhapsody of Realities, Healing Magazine" value={newProdName} onChange={e => setNewProdName(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-sm" />
              </div>
              <div className="w-64">
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Category (Optional)</label>
                <input type="text" placeholder="e.g. Print, Digital" value={newProdCat} onChange={e => setNewProdCat(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-sm" />
              </div>
              <button type="submit" className="px-6 py-3 bg-indigo-600 text-white font-bold rounded-xl text-sm hover:bg-indigo-500">
                Add Product
              </button>
            </form>

            <div className="bg-white border rounded-2xl p-6 shadow-sm">
              <h3 className="font-bold text-slate-800 text-base mb-4">Exhibitor Catalog Items</h3>
              <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
                {products.map(p => (
                  <div key={p.id} className="p-3 border rounded-xl bg-slate-50 flex justify-between items-center text-xs">
                    <div>
                      <p className="font-bold text-slate-800">{p.product_name}</p>
                      {p.category && <span className="text-indigo-600">{p.category}</span>}
                    </div>
                    <button onClick={() => handleDeleteProduct(p.id)} className="text-slate-400 hover:text-red-500">
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* DAILY REPORT FORM */}
        {activeTab === 'new' && (
          <form onSubmit={handleSubmit} className="bg-white border border-slate-200 rounded-2xl p-8 space-y-6 shadow-sm">
            <h2 className="text-lg font-bold text-slate-800 border-b pb-3">Daily Exhibitor Entry Form</h2>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Exhibition Day</label>
                <select value={exhibitionDay} onChange={e => setExhibitionDay(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-sm">
                  {['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'].map(d => <option key={d} value={d}>{d}</option>)}
                </select>
              </div>
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Staff on Stand</label>
                <input type="number" required value={staffCount} onChange={e => setStaffCount(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-sm" />
              </div>
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Visitors Recorded</label>
                <input type="number" required value={visitorsCount} onChange={e => setVisitorsCount(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-sm" />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Total Engagements</label>
                <input type="number" required value={engagementsCount} onChange={e => setEngagementsCount(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-sm" />
              </div>
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Total Conversions</label>
                <input type="number" required value={conversionsCount} onChange={e => setConversionsCount(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-sm" />
              </div>
            </div>

            {/* DYNAMIC PRODUCTS SELECTION FROM CATALOG */}
            <div className="border border-indigo-100 bg-indigo-50/40 rounded-2xl p-6 space-y-4">
              <div className="flex justify-between items-center">
                <label className="block text-xs font-bold text-indigo-900 uppercase">Select Products Exhibited Today</label>
                <button type="button" onClick={() => setActiveTab('catalog')} className="text-xs font-semibold text-indigo-600 hover:underline">
                  + Add items to catalog
                </button>
              </div>

              {products.length === 0 ? (
                <div className="p-4 bg-white border rounded-xl text-center text-xs text-slate-500">
                  No products in catalog yet. Click catalog tab above to populate products.
                </div>
              ) : (
                <div className="grid grid-cols-2 md:grid-cols-3 gap-2 max-h-40 overflow-y-auto p-2 bg-white rounded-xl border">
                  {products.map(p => (
                    <label key={p.id} className={`flex items-center space-x-2 p-2 rounded-lg border cursor-pointer text-xs font-medium ${selectedProducts.includes(p.product_name) ? 'bg-indigo-600 text-white border-indigo-600' : 'bg-slate-50 text-slate-700'}`}>
                      <input type="checkbox" checked={selectedProducts.includes(p.product_name)} onChange={() => toggleProductCheck(p.product_name)} className="hidden" />
                      <span>{p.product_name}</span>
                    </label>
                  ))}
                </div>
              )}

              <div>
                <label className="block text-xs font-bold text-indigo-900 uppercase mb-1">Most Engaged Product for the Day</label>
                <select value={mostEngagedProduct} onChange={e => setMostEngagedProduct(e.target.value)} className="w-full p-3 border rounded-xl bg-white text-sm">
                  <option value="">Select from catalog...</option>
                  {products.map(p => (
                    <option key={p.id} value={p.product_name}>{p.product_name}</option>
                  ))}
                </select>
              </div>
            </div>

            <div>
              <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Key Observations & Improvements</label>
              <textarea rows={3} value={observations} onChange={e => setObservations(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-sm" />
            </div>

            <button type="submit" disabled={saving} className="w-full py-3.5 bg-indigo-600 hover:bg-indigo-500 text-white font-bold rounded-xl shadow-md text-sm transition">
              {saving ? 'Submitting...' : 'Submit Daily Exhibitor Report'}
            </button>
          </form>
        )}

        {/* ENTRIES TAB */}
        {activeTab === 'entries' && (
          <div className="space-y-4">
            {reports.map(r => (
              <div key={r.id} className="bg-white border rounded-2xl p-6 shadow-sm space-y-3">
                <div className="flex justify-between items-center border-b pb-3">
                  <span className="font-bold text-indigo-600">{r.exhibition_day}</span>
                  <span className="text-xs text-slate-400">{new Date(r.created_at).toLocaleDateString()}</span>
                </div>
                <div className="grid grid-cols-4 gap-2 text-center bg-slate-50 p-3 rounded-xl text-xs font-semibold">
                  <div>Visitors: <span className="text-indigo-600 font-bold">{r.number_of_visitors_recorded}</span></div>
                  <div>Staff: {r.number_of_staff_on_stand}</div>
                  <div>Conversions: <span className="text-emerald-600 font-bold">{r.total_number_of_conversions}</span></div>
                  <div>Rate: {r.conversion_rate}%</div>
                </div>
              </div>
            ))}
          </div>
        )}

        {/* ANALYTICS TAB */}
        {activeTab === 'analytics' && (
          <div className="grid grid-cols-2 gap-6">
            <div className="bg-white p-6 rounded-2xl border text-center">
              <p className="text-slate-500 text-xs font-bold uppercase">Total Visitors Recorded</p>
              <h3 className="text-4xl font-bold text-slate-800 mt-2">{totalVisitors}</h3>
            </div>
            <div className="bg-white p-6 rounded-2xl border text-center">
              <p className="text-slate-500 text-xs font-bold uppercase">Total Conversions</p>
              <h3 className="text-4xl font-bold text-emerald-600 mt-2">{totalConversions}</h3>
            </div>
          </div>
        )}

        {/* FEEDBACK TAB */}
        {activeTab === 'feedback' && (
          <div className="space-y-4">
            {reports.filter(r => r.admin_feedback).map(r => (
              <div key={r.id} className="bg-indigo-50/50 border border-indigo-200 rounded-2xl p-5 space-y-2">
                <span className="font-bold text-sm text-slate-800">{r.exhibition_day} Feedback</span>
                <p className="text-xs text-slate-700 bg-white p-3 rounded-xl border">{r.admin_feedback}</p>
              </div>
            ))}
            {reports.filter(r => r.admin_feedback).length === 0 && (
              <p className="text-center text-slate-400 py-10 text-sm">No admin feedback received yet.</p>
            )}
          </div>
        )}
      </main>
    </div>
  );
}

// ----------------------------------------------------------------------------
// CLUSTER VIEW COMPONENT
// ----------------------------------------------------------------------------
function ClusterView({ user, profile }) {
  const [activeTab, setActiveTab] = useState('daily');
  const [dailyReports, setDailyReports] = useState([]);
  const [finalReports, setFinalReports] = useState([]);
  const [saving, setSaving] = useState(false);

  const [subchairman, setSubchairman] = useState('');
  const [secretary, setSecretary] = useState('');
  const [exhibitionDay, setExhibitionDay] = useState('Day 1');
  const [activities, setActivities] = useState('');
  const [achievements, setAchievements] = useState('');
  const [challenges, setChallenges] = useState('');
  const [improvements, setImprovements] = useState('');

  const [expoSummary, setExpoSummary] = useState('');
  const [milestones, setMilestones] = useState('');
  const [recommendations, setRecommendations] = useState('');
  const [docUrl, setDocUrl] = useState('');

  useEffect(() => {
    fetchClusterReports();
  }, []);

  const fetchClusterReports = async () => {
    const { data: dData } = await supabase.from('cluster_daily_reports').select('*').eq('user_id', user.id);
    const { data: fData } = await supabase.from('cluster_final_reports').select('*').eq('user_id', user.id);

    if (dData) setDailyReports(dData);
    if (fData) setFinalReports(fData);
  };

  const handleDailySubmit = async (e) => {
    e.preventDefault();
    setSaving(true);
    await supabase.from('cluster_daily_reports').insert([{
      user_id: user.id,
      cluster: profile.entity_name,
      cluster_subchairman: subchairman,
      cluster_secretary: secretary,
      exhibition_day: exhibitionDay,
      summary_of_activities: activities,
      significant_achievements: achievements,
      challenges_and_solutions_proferred: challenges,
      improvements_for_next_day: improvements
    }]);
    setSaving(false);
    fetchClusterReports();
    setActiveTab('entries');
  };

  const handleFinalSubmit = async (e) => {
    e.preventDefault();
    setSaving(true);
    await supabase.from('cluster_final_reports').insert([{
      user_id: user.id,
      cluster: profile.entity_name,
      cluster_subchairman: subchairman,
      cluster_secretary: secretary,
      overall_expo_summary: expoSummary,
      key_milestones_achieved: milestones,
      total_cluster_deliverables_summary: milestones,
      recommendations_for_future_expo: recommendations,
      document_attachment_url: docUrl
    }]);
    setSaving(false);
    fetchClusterReports();
    setActiveTab('entries');
  };

  return (
    <div className="flex-1 flex flex-col">
      <div className="bg-white border-b border-slate-200 px-6 flex space-x-6 text-sm font-semibold">
        <button onClick={() => setActiveTab('daily')} className={`py-4 border-b-2 ${activeTab === 'daily' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          Daily Cluster Report
        </button>
        <button onClick={() => setActiveTab('final')} className={`py-4 border-b-2 flex items-center space-x-1 ${activeTab === 'final' ? 'border-amber-600 text-amber-600' : 'border-transparent text-slate-500'}`}>
          <Award className="w-4 h-4 text-amber-500" /> <span>Final 7-Day Expo Report</span>
        </button>
        <button onClick={() => setActiveTab('entries')} className={`py-4 border-b-2 ${activeTab === 'entries' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          Submissions ({dailyReports.length + finalReports.length})
        </button>
      </div>

      <main className="flex-1 max-w-4xl w-full mx-auto p-6">
        {activeTab === 'daily' && (
          <form onSubmit={handleDailySubmit} className="bg-white border rounded-2xl p-8 space-y-6 shadow-sm">
            <h2 className="text-lg font-bold text-slate-800 border-b pb-3">Cluster Daily Delivery Entry</h2>
            <div className="grid grid-cols-3 gap-4">
              <input type="text" required placeholder="Subchairman Name *" value={subchairman} onChange={e => setSubchairman(e.target.value)} className="p-3 border rounded-xl text-sm" />
              <input type="text" required placeholder="Secretary Name *" value={secretary} onChange={e => setSecretary(e.target.value)} className="p-3 border rounded-xl text-sm" />
              <select value={exhibitionDay} onChange={e => setExhibitionDay(e.target.value)} className="p-3 border rounded-xl text-sm">
                {['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'].map(d => <option key={d} value={d}>{d}</option>)}
              </select>
            </div>
            <textarea required rows={3} placeholder="Summary of activities *" value={activities} onChange={e => setActivities(e.target.value)} className="w-full p-3 border rounded-xl text-sm" />
            <textarea required rows={3} placeholder="Significant Achievements *" value={achievements} onChange={e => setAchievements(e.target.value)} className="w-full p-3 border rounded-xl text-sm" />
            <button type="submit" disabled={saving} className="w-full py-3.5 bg-indigo-600 text-white font-bold rounded-xl text-sm">
              {saving ? 'Submitting...' : 'Submit Cluster Daily Report'}
            </button>
          </form>
        )}

        {activeTab === 'final' && (
          <form onSubmit={handleFinalSubmit} className="bg-white border-2 border-amber-200 rounded-2xl p-8 space-y-6 shadow-sm">
            <div className="flex items-center space-x-2 text-amber-600 border-b pb-3">
              <Award className="w-5 h-5" />
              <h2 className="text-lg font-bold text-slate-800">Final Expo Summary Report</h2>
            </div>
            <textarea required rows={4} placeholder="Overall Expo Summary *" value={expoSummary} onChange={e => setExpoSummary(e.target.value)} className="w-full p-3 border rounded-xl text-sm" />
            <input type="url" placeholder="Document Attachment Link (PDF / Word)" value={docUrl} onChange={e => setDocUrl(e.target.value)} className="w-full p-3 border rounded-xl text-sm" />
            <button type="submit" disabled={saving} className="w-full py-3.5 bg-amber-600 text-white font-bold rounded-xl text-sm">
              {saving ? 'Submitting...' : 'Submit Final Summary Report'}
            </button>
          </form>
        )}
      </main>
    </div>
  );
}

// ----------------------------------------------------------------------------
// ADMIN OVERSIGHT COMPONENT
// ----------------------------------------------------------------------------
function AdminView({ user, profile }) {
  const [exhibitorReports, setExhibitorReports] = useState([]);
  const [clusterReports, setClusterReports] = useState([]);
  const [feedbackText, setFeedbackText] = useState({});

  useEffect(() => {
    fetchAllData();
  }, []);

  const fetchAllData = async () => {
    const { data: eData } = await supabase.from('exhibitor_daily_reports').select('*').order('created_at', { ascending: false });
    const { data: cData } = await supabase.from('cluster_daily_reports').select('*').order('created_at', { ascending: false });
    if (eData) setExhibitorReports(eData);
    if (cData) setClusterReports(cData);
  };

  const handleSendFeedback = async (table, id) => {
    const text = feedbackText[id];
    if (!text) return;

    await supabase.from(table).update({
      admin_feedback: text,
      feedback_given_at: new Date().toISOString(),
      status: 'reviewed'
    }).eq('id', id);

    alert('Feedback sent successfully to portal!');
    fetchAllData();
  };

  return (
    <div className="flex-1 max-w-6xl w-full mx-auto p-6 space-y-6">
      <div className="grid grid-cols-3 gap-6">
        <div className="bg-white p-5 rounded-2xl border shadow-sm">
          <p className="text-xs text-slate-500 font-bold uppercase">Exhibitor Reports</p>
          <h3 className="text-3xl font-bold text-slate-800 mt-1">{exhibitorReports.length}</h3>
        </div>
        <div className="bg-white p-5 rounded-2xl border shadow-sm">
          <p className="text-xs text-slate-500 font-bold uppercase">Cluster Daily Reports</p>
          <h3 className="text-3xl font-bold text-slate-800 mt-1">{clusterReports.length}</h3>
        </div>
        <div className="bg-white p-5 rounded-2xl border shadow-sm">
          <p className="text-xs text-slate-500 font-bold uppercase">Total Visitors</p>
          <h3 className="text-3xl font-bold text-indigo-600 mt-1">
            {exhibitorReports.reduce((acc, r) => acc + (r.number_of_visitors_recorded || 0), 0)}
          </h3>
        </div>
      </div>

      <div className="bg-white rounded-2xl border p-6 shadow-sm space-y-4">
        <h2 className="text-base font-bold text-slate-800">Review Submissions & Provide Feedback</h2>
        <div className="space-y-4">
          {exhibitorReports.map(r => (
            <div key={r.id} className="p-4 border rounded-xl bg-slate-50 flex justify-between items-start text-xs">
              <div className="space-y-1">
                <span className="font-bold text-indigo-600 text-sm">{r.exhibitor_name} ({r.exhibition_day})</span>
                <p>Visitors: {r.number_of_visitors_recorded} | Conversions: {r.total_number_of_conversions}</p>
                <p className="text-slate-500">Products: {r.list_of_products_exhibited}</p>
              </div>
              <div className="w-72 space-y-2">
                <textarea
                  rows={2}
                  placeholder="Type feedback for exhibitor..."
                  value={feedbackText[r.id] || r.admin_feedback || ''}
                  onChange={e => setFeedbackText({ ...feedbackText, [r.id]: e.target.value })}
                  className="w-full p-2 border rounded bg-white text-xs"
                />
                <button
                  onClick={() => handleSendFeedback('exhibitor_daily_reports', r.id)}
                  className="w-full py-1.5 bg-indigo-600 text-white font-bold rounded flex items-center justify-center space-x-1"
                >
                  <Send className="w-3 h-3" /> <span>Save Feedback</span>
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}